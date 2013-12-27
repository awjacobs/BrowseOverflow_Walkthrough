//
//  QuestionBuilderTests.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/7/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "QuestionBuilder.h"
#import "Question.h"
#import "Person.h"

static NSString *questionJSON = @"{"
@"\"total\": 1,"
@"\"page\": 1,"
@"\"pagesize\": 30,"
@"\"questions\": ["
@"{"
@"\"tags\": ["
@"\"iphone\","
@"\"security\","
@"\"keychain\""
@"],"
@"\"answer_count\": 1,"
@"\"accepted_answer_id\": 3231900,"
@"\"favorite_count\": 1,"
@"\"question_timeline_url\": \"/questions/2817980/timeline\","
@"\"question_comments_url\": \"/questions/2817980/comments\","
@"\"question_answers_url\": \"/questions/2817980/answers\","
@"\"question_id\": 2817980,"
@"\"owner\": {"
@"\"user_id\": 23743,"
@"\"user_type\": \"registered\","
@"\"display_name\": \"Graham Lee\","
@"\"reputation\": 13459,"
@"\"email_hash\": \"563290c0c1b776a315b36e863b388a0c\""
@"},"
@"\"creation_date\": 1273660706,"
@"\"last_activity_date\": 1278965736,"
@"\"up_vote_count\": 2,"
@"\"down_vote_count\": 0,"
@"\"view_count\": 465,"
@"\"score\": 2,"
@"\"community_owned\": false,"
@"\"title\": \"Why does Keychain Services return the wrong keychain content?\","
@"\"body\": \"<p>I've been trying to use persistent keychain references.</p>\""
@"}"
@"]"
@"}";
static NSString *stringIsNotJSON = @"Not JSON";
static NSString *noQuestionsJSONString = @"{ \"noquestions\": true }";
static NSString *emptyQuestionsArray = @"{ \"questions\": [] }";

@interface QuestionBuilderTests : XCTestCase
{
    QuestionBuilder* builder;
    Question* question;
    
}
@end

@implementation QuestionBuilderTests

- (void)setUp
{
    [super setUp];
    builder = [[QuestionBuilder alloc]init];
    question = [[builder questionsFromJSON:questionJSON error:NULL] objectAtIndex:0];
}

- (void)tearDown
{
    builder = nil;
    question = nil;
    [super tearDown];
}

- (void)testThatNilIsNotAnacceptableParameter {
    XCTAssertThrows([builder questionsFromJSON:nil error:NULL], @"Lack of data should have been handled elsewhere");
}

- (void)testNilReturnedWhenStringIsNotJSON {
    XCTAssertNil([builder questionsFromJSON:@"Not JSON" error:NULL], @"This parameter should not be parsable");
}

- (void)testErrorSetWhenStringIsNotJSON {
    NSError* error = nil;
    [builder questionsFromJSON:@"Not JSON" error:&error];
    XCTAssertNotNil(error, @"An Error occured, we should be told");
}

- (void)testPassingNullErrorDoesNotCauseCrash {
    XCTAssertNoThrow([builder questionsFromJSON:@"Not JSON" error:NULL], @"Using a NULL error parameter should not be a problem");
}

- (void)testRealJSONWithoutQuestionsArrayIsError {
    NSString *jsonString = @"{ \"noquestions\": true}";
    XCTAssertNil([builder questionsFromJSON:jsonString error:NULL], @"No questions to parse in this JSON");
}

- (void)testRealJSONWithoutQuestionsReturnsMissingDataError {
    NSString *jsonString = @"{ \"noquestions\": true}";
    NSError *error = nil;
    [builder questionsFromJSON:jsonString error:&error];
    XCTAssertEqual([error code], QuestionBuilderMissingDataError, @"This case should not be an invalid JSON Error");
}

- (void)testJSONwithOneQuestionReturnsOneObject {
    NSError *error = nil;
    NSArray* questions = [builder questionsFromJSON:questionJSON error:&error];
    XCTAssertEqual([questions count], (NSUInteger)1, @"The builder should have created a question");
}

- (void)testQuestionCreatedFromJSONHasPropertiesPresentedInJSON {
    XCTAssertEqual(question.questionID, 2817980, @"The question ID should match the data we sent");
    XCTAssertEqual([question.date timeIntervalSince1970], (NSTimeInterval)1273660706, @"The date of the question should match the data.");
    XCTAssertEqualObjects(question.title, @"Why does Keychain Services return the wrong keychain content?", @"Title should match the provided data");
    XCTAssertEqual(question.score, 2, @"Score should match the data.");
    Person* asker = question.asker;
    XCTAssertEqualObjects(asker.name, @"Graham Lee", @"Looks like I should have asked this question.");
    XCTAssertEqualObjects([asker.avatarURL absoluteString], @"http://www.gravatar.com/avatar/563290c0c1b776a315b36e863b388a0c",
                          @"The avatar URL should be based on the supplied email hash");
    
}

- (void)testQuestionCreatedFromEmptyObjectIsStillValidObject {
    NSString* emptyQuestion = @"{ \"questions\": [ {} ] }";
    NSArray* questions = [builder questionsFromJSON:emptyQuestion error:NULL];
    XCTAssertEqual([questions count], (NSUInteger)1, @"QuestionBuilder must handle partial input");
}

- (void)testBuildingQuestionBodyWithNoDataCannotBeTried {
    XCTAssertThrows([builder fillInDetailsForQuestion:question fromJSON:nil], @"Not receiving data should have been handled earlier.");
}

- (void)testBuildingQuestionBodyWithNoQuestionsCannotBeTried {
    XCTAssertThrows([builder fillInDetailsForQuestion:nil fromJSON:questionJSON], @"No reason to expect that a nil question is passed.");
}

- (void)testNonJSONDataDoesNotCauseABodyToBeAddedToAQuestion {
    [builder fillInDetailsForQuestion:question fromJSON:stringIsNotJSON];
    XCTAssertNil(question.body, @"There was no body to add");
}

- (void)testJSONWhichDoesNotContainABodyDoesNotCauseBodyToBeAdded {
    [builder fillInDetailsForQuestion:question fromJSON:noQuestionsJSONString];
    XCTAssertNil(question.body, @"There was no body to add");
}

- (void)testBodyContainedInJSONIsAddedToQuestion {
    [builder fillInDetailsForQuestion:question fromJSON:questionJSON];
    XCTAssertEqualObjects(question.body, @"<p>I've been trying to use persistent keychain references.</p>", @"The correct question body is added.");
}
@end
