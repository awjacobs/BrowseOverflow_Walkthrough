//
//  StackOverflowCommunicatorTests.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/24/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "InspectableStackOverflowCommunicator.h"

@interface StackOverflowCommunicatorTests : XCTestCase
{
    InspectableStackOverflowCommunicator *communicator;
}
@end

@implementation StackOverflowCommunicatorTests

- (void)setUp
{
    [super setUp];
    communicator = [[InspectableStackOverflowCommunicator alloc]init];
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

@end
