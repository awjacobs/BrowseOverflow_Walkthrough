//
//  AnswerCreationWorkflowTests.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/14/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Question.h"
#import "StackOverflowManager.h"

#import "MockStackOverflowManagerDelegate.h"
#import "MockCommunicator.h"
#import "FakeAnswerBuilder.h"

@interface AnswerCreationWorkflowTests : XCTestCase
{
    StackOverflowManager *manager;
    MockCommunicator *communicator;
    MockStackOverflowManagerDelegate *delegate;
    Question *question;
    FakeAnswerBuilder *answerBuilder;
    NSError *error;
}
@end

@implementation AnswerCreationWorkflowTests

- (void)setUp
{
    [super setUp];
    manager = [[StackOverflowManager alloc] init];
    communicator = [[MockCommunicator alloc] init];
    manager.communicator = communicator;
    delegate = [[MockStackOverflowManagerDelegate alloc] init];
    manager.delegate = delegate;
    question = [[Question alloc] init];
    question.questionID = 12345;
    answerBuilder = [[FakeAnswerBuilder alloc] init];
    manager.answerBuilder = answerBuilder;
    error = [NSError errorWithDomain: @"Fake Domain" code: 42 userInfo: nil];}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testAskingForAnswersMeansCommunicatingWithSite {
    [manager fetchAnswersForQuestion: question];
    XCTAssertEqual(question.questionID, [communicator askedForAnswersToQuestionID], @"Answers to questions are found by communicating with the web site");
}

- (void)testDelegateNotifiedOfFailureToGetAnswers {
    [manager fetchingAnswersFailedWithError: error];
    XCTAssertEqualObjects([[[delegate fetchError]userInfo]objectForKey:NSUnderlyingErrorKey], error, @"Delegate should be notified of failure");
}

- (void)testManagerRemembersWhichQuestionToAddAnswersTo {
    [manager fetchAnswersForQuestion:question];
    XCTAssertEqualObjects(manager.questionToFill, question, @"Manager should know question to fill");
}

- (void)testAnswerResponsePassedToAnswerBuilder {
    [manager receivedAnswerListJSON: @"Fake JSON"];
    XCTAssertEqualObjects([answerBuilder receivedJSON], @"Fake JSON", @"Manager must pass response to builder to get answers built");
}

- (void)testQuestionPassedToAnswerBuilder {
    manager.questionToFill = question;
    [manager receivedAnswerListJSON:@"Fake JSON"];
    XCTAssertEqualObjects(answerBuilder.questionToFill, question, @"Manager must pass the question into the answer builder");
}

- (void)testManagerNotifiesDelegateWhenAnswersAdded {
    answerBuilder.successful = YES;
    manager.questionToFill = question;
    [manager receivedAnswerListJSON:@"Fake JSON"];
    XCTAssertEqualObjects(delegate.successQuestion, question, @"Manager should call the delegate method");
}

- (void)testManagerNotifiesDelegateWhenAnswersNotAdded {
    answerBuilder.successful = NO;
    answerBuilder.error = error;
    [manager receivedAnswerListJSON:@"Fake JSON"];
    XCTAssertEqualObjects([[delegate.fetchError userInfo] objectForKey:NSUnderlyingErrorKey], error, @"Manager should pass error on to the delegate");
}

@end
