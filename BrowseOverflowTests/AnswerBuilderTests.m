//
//  AnswerBuilderTests.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/19/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AnswerBuilder.h"
#import "Answer.h"
#import "Question.h"
#import "Person.h"

static NSString *realAnswerJSON = @"{"
@"\"total\": 1,"
@"\"page\": 1,"
@"\"pagesize\": 30,"
@"\"answers\": ["
@"{"
@"\"answer_id\": 3231900,"
@"\"accepted\": true,"
@"\"answer_comments_url\": \"/answers/3231900/comments\","
@"\"question_id\": 2817980,"
@"\"owner\": {"
@"\"user_id\": 266380,"
@"\"user_type\": \"registered\","
@"\"display_name\": \"dmaclach\","
@"\"reputation\": 151,"
@"\"email_hash\": \"d96ae876eac0075727243a10fab823b3\""
@"},"
@"\"creation_date\": 1278965736,"
@"\"last_activity_date\": 1278965736,"
@"\"up_vote_count\": 1,"
@"\"down_vote_count\": 0,"
@"\"view_count\": 0,"
@"\"score\": 1,"
@"\"community_owned\": false,"
@"\"title\": \"Why does Keychain Services return the wrong keychain content?\","
@"\"body\": \"<p>Turns out that using the kSecMatchItemList doesn't appear to work at all. </p>\""
@"}"
@"]"
@"}";

static NSString *stringIsNotJSON = @"Not JSON";
static NSString *noAnswersJSONString = @"{ \"noanswers\": true }";

@interface AnswerBuilderTests : XCTestCase
{
    AnswerBuilder *builder;
    Question *question;
}
@end

@implementation AnswerBuilderTests

- (void)setUp
{
    [super setUp];
    builder = [[AnswerBuilder alloc]init];
    question = [[Question alloc]init];
    question.questionID = 12345;
}

- (void)testThatSendingNilJSONIsNotAnOption {
    XCTAssertThrows([builder addAnswersToQuestion:question fromJSON:nil error:NULL], @"Lack of data should have been handled elsewhere");
}

- (void)testThatAddingAnswersToNilQuestionIsNotSupported {
    XCTAssertThrows([builder addAnswersToQuestion:nil fromJSON:stringIsNotJSON error:NULL], @"Lack of data should have been handled elsewhere");
}

- (void)testSendingNonJSONIsAnError {
    NSError *error = nil;
    [builder addAnswersToQuestion:question fromJSON:stringIsNotJSON error:&error];
    XCTAssertNotNil(error, @"An Error occured, we should be told");
}

- (void)testPassingNullErrorDoesNotCauseCrash {
    XCTAssertNoThrow([builder addAnswersToQuestion:question fromJSON:stringIsNotJSON error:NULL], @"Using a NULL error parameter should not be a problem");
}

- (void)testSendingJSONWithIncorrectKeysIsAnError {
    NSError *error = nil;
    XCTAssertFalse([builder addAnswersToQuestion:question fromJSON:noAnswersJSONString error:&error],
                   @"There must be a collection of answers in the input data");
}

- (void)testAddingRealAnswerJSONIsNotAnError {
    XCTAssertTrue([builder addAnswersToQuestion:question fromJSON:realAnswerJSON error:NULL], @"Should be OK to actually want to add ansers");
}

- (void)testNumberOfAnswersAddedMatchNumberInData {
    [builder addAnswersToQuestion:question fromJSON:realAnswerJSON error:NULL];
    XCTAssertEqual([question.answers count], (NSUInteger)1, @"One answer added to zero should mean one");
}

- (void)testAnswerPropertiesMatchDataReceived {
    [builder addAnswersToQuestion:question fromJSON:realAnswerJSON error:NULL];
    Answer *answer = [question.answers objectAtIndex:0];
    XCTAssertEqual(answer.score, (NSInteger)1, @"Score property should be set from JSON");
    XCTAssertTrue(answer.accepted, @"Answer should be accepted as in JSON data");
    XCTAssertEqualObjects(answer.text, @"<p>Turns out that using the kSecMatchItemList doesn't appear to work at all. </p>", @"Answer body should match fed data");
}

- (void)testAnswerIsProvidedByExpectedPerson {
    [builder addAnswersToQuestion:question fromJSON:realAnswerJSON error:NULL];
    Answer *answer = [question.answers objectAtIndex:0];
    Person *answerer = answer.person;
    XCTAssertEqualObjects(answerer.name, @"dmaclach", @"The provided person name was used");
    XCTAssertEqualObjects([answerer.avatarURL absoluteString], @"http://www.gravatar.com/avatar/d96ae876eac0075727243a10fab823b3", @"The provided email hash was converted to an avatar URL");

}
@end
