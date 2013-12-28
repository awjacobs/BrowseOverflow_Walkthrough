//
//  StackOverflowCommunicatorTests.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/24/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "InspectableStackOverflowCommunicator.h"
#import "NonNetworkedStackOverflowCommunicator.h"
#import "MockStackOverflowManager.h"
#import "FakeURLResponse.h"

@interface StackOverflowCommunicatorTests : XCTestCase
{
    InspectableStackOverflowCommunicator *communicator;
    NonNetworkedStackOverflowCommunicator *nnCommunicator;
    MockStackOverflowManager *manager;
    NSData *receivedData;
    FakeURLResponse *fourOhFourResponse;
}
@end

@implementation StackOverflowCommunicatorTests

- (void)setUp
{
    [super setUp];
    communicator = [[InspectableStackOverflowCommunicator alloc]init];
    nnCommunicator = [[NonNetworkedStackOverflowCommunicator alloc]init];
    manager = [[MockStackOverflowManager alloc]init];
    nnCommunicator.delegate = manager;
    fourOhFourResponse = [[FakeURLResponse alloc]initWithStatusCode:404];
    receivedData = [@"Result" dataUsingEncoding:NSUTF8StringEncoding];
}

-(void)tearDown {
    [communicator cancelAndDiscardURLConnection];
}

- (void)testSearchingForQuestionsOnTopicCallsTopicAPI {

    [communicator searchForQuestionsWithTag: @"ios"];
    XCTAssertEqualObjects([[communicator URLToFetch]absoluteString],
                          @"http://api.stackoverflow.com/1.1/search?tagged=ios&pagesize=20",
                          @"Use the search API to find questions with a particular tag");
}

- (void)testFillingInQuestionBodyCallsQuestionAPI {
    [communicator downloadInformationForQuestionWithID: 12345];
    XCTAssertEqualObjects([[communicator URLToFetch]absoluteString],
                          @"http://api.stackoverflow.com/1.1/questions/12345?body=true",
                          @"Use the question API to get the body for a question");
}

- (void)testFetchingAnswersToQuestionCallsQuestionAPI {
    [communicator downloadAnswersToQuestionWithID: 12345];
    XCTAssertEqualObjects([[communicator URLToFetch]absoluteString],
                          @"http://api.stackoverflow.com/1.1/questions/12345/answers?body=true",
                          @"Use the question API to get answers on a given question");
}

- (void)testSearchingForQuestionsCreatesURLConnection {
    [communicator searchForQuestionsWithTag: @"ios"];
    XCTAssertNotNil([communicator currentURLConnection], @"There should be a URL connection in-flight now");
    [communicator cancelAndDiscardURLConnection];
}

- (void)testStartingNewSearchThrowsOutOldConnection {
    [communicator searchForQuestionsWithTag:@"ios"];
    NSURLConnection *firstConnection = [communicator currentURLConnection];
    [communicator searchForQuestionsWithTag:@"cocoa"];
    XCTAssertFalse([[communicator currentURLConnection] isEqual:firstConnection], @"The communicator needs to replace its URL connection to start a new one");
    [communicator cancelAndDiscardURLConnection];
}

- (void)testReceivingResponseDiscardsExistingData {
    nnCommunicator.receivedData = [@"Hello" dataUsingEncoding:NSUTF8StringEncoding];
    [nnCommunicator searchForQuestionsWithTag: @"ios"];
    [nnCommunicator connection:nil didReceiveResponse:nil];
    XCTAssertEqual([nnCommunicator.receivedData length], (NSUInteger)0, @"Data should have been discarded");
}

- (void)testReceivingResponseWith404StatusPassesErrorToDelegate {
    [nnCommunicator searchForQuestionsWithTag:@"ios"];
    [nnCommunicator connection:nil didReceiveResponse:(NSURLResponse*)fourOhFourResponse];
    XCTAssertEqual([manager topicFailurErrorCode], 404, @"Fetch failure was passed through to delegate");
}

@end
