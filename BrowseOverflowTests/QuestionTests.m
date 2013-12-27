//
//  QuestionTests.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 11/14/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Question.h"
#import "Answer.h"
#import "Person.h"

@interface QuestionTests : XCTestCase
{
    Question* newQuestion;
    Answer* lowScore;
    Answer* highScore;
    Person *asker;
}
@end

@implementation QuestionTests

- (void)setUp
{
    [super setUp];
    newQuestion = [[Question alloc]init];
    newQuestion.date = [NSDate distantPast];
    newQuestion.title = @"Do iPhones also dream of electric sheep?";
    newQuestion.score = 42;
    
    Answer* accepted = [[Answer alloc]init];
    accepted.score = 1;
    accepted.accepted = YES;
    [newQuestion addAnswer: accepted];
    
    lowScore = [[Answer alloc]init];
    lowScore.score = -4;
    [newQuestion addAnswer: lowScore];
    
    highScore = [[Answer alloc]init];
    highScore.score = 4;
    [newQuestion addAnswer: highScore];
    
    asker = [[Person alloc]initWithName:@"Graham Lee" avatarLocation:@"http://example.com/avatar.png"];
    newQuestion.asker = asker;
}

- (void)tearDown
{
    newQuestion = nil;
    lowScore = nil;
    highScore = nil;
    [super tearDown];
}

- (void)testQuestionHasADate
{
    NSDate* testDate = [NSDate distantPast];
    newQuestion.date = testDate;
    XCTAssertEqualObjects(newQuestion.date, testDate, @"Question needs to provide its date");
}

- (void)testQuestionsKeepScore{
    XCTAssertEqual(newQuestion.score, 42, @"Questions need a numeric score");
}

- (void)testQuestionHasATitle
{
    XCTAssertEqualObjects(newQuestion.title, @"Do iPhones also dream of electric sheep?", @"Question should know its title.");
}

- (void)testQuestionCanHaveAnswersAdded
{
    Answer* myAnswer = [[Answer alloc]init];
    XCTAssertNoThrow([newQuestion addAnswer: myAnswer], @"Must be able to add answers");
}

- (void)testAcceptedAnswerIsFirst
{
    XCTAssertTrue([[newQuestion.answers firstObject] isAccepted], @"Accepted answer comes first");
}

- (void)testHighScoreAnswerBeforeLow
{
    NSArray* answers = newQuestion.answers;
    NSInteger highIndex = [answers indexOfObject:highScore];
    NSInteger lowIndex = [answers indexOfObject:lowScore];
    XCTAssertTrue(highIndex < lowIndex, @"High-scoring answer comes first.");
}

- (void)testQuestionWasAskedBySomeone {
    XCTAssertEqualObjects(newQuestion.asker, asker, @"Question should keep track of who asked it.");
}
@end
