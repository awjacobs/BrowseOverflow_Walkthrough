//
//  QuestionCreationTests.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 11/20/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "StackOverflowManager.h"
#import "StackOverflowCommunicator.h"
#import "Topic.h"
#import "Question.h"

#import "FakeQuestionBuilder.h"
#import "MockStackOverflowManagerDelegate.h"
#import "MockCommunicator.h"

@interface QuestionCreationWorkflowTests : XCTestCase
{
    @private
    StackOverflowManager* mgr;
    MockStackOverflowManagerDelegate* delegate;
    NSError* underlyingError;
    FakeQuestionBuilder* builder;
    NSArray* questionArray;
    
    Question* questionToFetch;
    MockCommunicator* communicator;
}
@end



@implementation QuestionCreationWorkflowTests

- (void)setUp
{
    [super setUp];
    mgr = [[StackOverflowManager alloc]init];
    delegate = [[MockStackOverflowManagerDelegate alloc]init];
    mgr.delegate = delegate;
    underlyingError = [NSError errorWithDomain:@"Test domain" code:0 userInfo:nil];
    builder = [[FakeQuestionBuilder alloc]init];
    mgr.questionBuilder = builder;
    
    questionToFetch  = [[Question alloc]init];
    questionToFetch.questionID = 1234;
    questionArray = [NSArray arrayWithObject:questionToFetch];
    communicator = [[MockCommunicator alloc]init];
    mgr.communicator = communicator;
}

- (void)tearDown
{
    mgr = nil;
    delegate = nil;
    underlyingError = nil;
    builder = nil;
    questionToFetch = nil;
    questionArray = nil;
    communicator = nil;
    [super tearDown];
}

- (void)testNonConformingObjectCannotBeDelegate{
    XCTAssertThrows(mgr.delegate = (id <StackOverflowManagerDelegate>) [NSNull null],
                    @"NSNull should not be used as the delegate as doesn't conform to the delegate protocol");
}

- (void)testConformingObjectCanBeDelegate {
    id <StackOverflowManagerDelegate> mockDelegate = [[MockStackOverflowManagerDelegate alloc]init];
    XCTAssertNoThrow(mgr.delegate = mockDelegate, @"Object conforming to the delegate protocol should be used as the delegate");
}

- (void)testManagerAcceptsNilAsDelegate {
    XCTAssertNoThrow(mgr.delegate = nil, @"It should be acceptable to use nil as an object's delegate");
}

- (void)testAskingForQuestionsMeansRequestingData {
    Topic* topic = [[Topic alloc]initWithName:@"iPhone" tag:@"iphone"];
    [mgr fetchQuestionsOnTopic: topic];
    XCTAssertTrue([communicator wasAskedToFetchQuestions], @"The communicator should need to fetch data.");
}

- (void)testErrorReturnedToDelegateIsNotErrorNotifiedByCommunicator {
    [mgr searchingForQuestionsFailedWithError: underlyingError];
    XCTAssertFalse(underlyingError == [delegate fetchError], @"Error should be at the correct level of abstraction");
}

- (void)testErrorReturnedToDelegateDocumentsUnderlyingError {
    [mgr searchingForQuestionsFailedWithError: underlyingError];
    XCTAssertEqualObjects([[[delegate fetchError] userInfo]objectForKey: NSUnderlyingErrorKey], underlyingError, @"The underlying error should be available to client code");
}

- (void)testQuestionJSONIsPassedToQuestionBuilder {
    [mgr receivedQuestionsJSON: @"Fake JSON"];
    XCTAssertEqualObjects(builder.JSON, @"Fake JSON", @"Downloaded JSON is sent to the builder");
    mgr.questionBuilder = nil;
}

- (void)testDelegateNotifiedOfErrorWhenQuestionBuilderFails {
    builder.arrayToReturn = nil;
    builder.errorToSet = underlyingError;
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertNotNil([[[delegate fetchError]userInfo]
                     objectForKey:NSUnderlyingErrorKey],
                    @"The delegate should have found out about the error");
    mgr.questionBuilder = nil;
}

- (void)testDelegateNotToldAboutErrorWhenQuestionsReceived {
    builder.arrayToReturn = questionArray;
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertNil([delegate fetchError], @"No error should be received on success");
}

- (void)testDelegateReceivesTheQuestionsDiscoveredByManager {
    builder.arrayToReturn = questionArray;
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertEqualObjects([delegate receivedQuestions], questionArray, @"The manager should have sent its questions to the delegate");
}

- (void)testEmptyArrayIsPassedToDelegate {
    builder.arrayToReturn = [NSArray array];
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertEqualObjects([delegate receivedQuestions], [NSArray array], @"Returning an empty array is not an error");
}

- (void)testAskingForQuestionBodyMeansRequestingData {
    [mgr fetchBodyForQuestion: questionToFetch];
    XCTAssertTrue([communicator wasAskedToFetchBody], @"The communicator should need to retrieve data for the question body.");
}

- (void)testDelegateNotifiedOfFailureToFetchQuestion {
    [mgr fetchingQuestionBodyFailedWithError: underlyingError];
    XCTAssertNotNil([[[delegate fetchError]userInfo]objectForKey:NSUnderlyingErrorKey], @"Delegate should have found out about this error.");
}

- (void)testManagerPassesRetrievedQuestionBodyToQuestionBuilder {
    [mgr receivedQuestionBodyJSON: @"Fake JSON"];
    XCTAssertEqualObjects(builder.JSON, @"Fake JSON", @"Successfully-retrieved data should be passed to the builder");
}

- (void)testManagerPassesQuestionItWasSentToQuestionBuilderForFillingIn {
    [mgr fetchBodyForQuestion: questionToFetch];
    [mgr receivedQuestionBodyJSON: @"Fake JSON"];
    XCTAssertEqualObjects(builder.questionToFill, questionToFetch, @"The Question should have been passed to the builder");
}

- (void)testManagerNotifiesDelegateWhenQuestionBodyIsReceived {
    [mgr fetchBodyForQuestion:questionToFetch];
    [mgr receivedQuestionBodyJSON:@"Fake JSON"];
    XCTAssertEqualObjects(delegate.bodyQuestion, questionToFetch, @"Delegate should receive question with body when it is received");
}
@end
