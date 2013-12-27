//
//  TopicTests.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 11/14/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Topic.h"
#import "Question.h"

@interface TopicTests : XCTestCase
{
    Topic* testTopic;
}
@end

@implementation TopicTests

- (void)setUp
{
    [super setUp];
    testTopic = [[Topic alloc]initWithName:@"iPhone" tag: @"iphone"];

}

- (void)tearDown
{
    testTopic = nil;
    [super tearDown];
}

- (void) testThatTopicExists
{
    XCTAssertNotNil(testTopic, @"Should be able to create new Topic instance");
}

- (void) testThatTopicCanBeName{
    XCTAssertEqualObjects(testTopic.name, @"iPhone", @"The Topic should have the name I gave it");
}

- (void) testThatTopicHasATag
{
    XCTAssertEqualObjects(testTopic.tag, @"iphone", @"Topics need to have tags");
}

- (void)testForAListOfQuestions
{
    XCTAssertTrue([[testTopic recentQuestions]isKindOfClass:[NSArray class]], @"Topics should provide a list of recent questions");
}

- (void)testForInitiallyEmptyQuestionList
{
    XCTAssertEqual([[testTopic recentQuestions]count], (NSUInteger)0, @"No questions added yet, count should be zero");
}

- (void)testAddingAQuestionToTheList
{
    Question* newQuestion = [[Question alloc]init];
    [testTopic addQuestion: newQuestion];
    XCTAssertEqual([[testTopic recentQuestions]count], (NSUInteger)1, @"Added a question, the count of questions should increase");
}

- (void)testQuestionsAreListedChronologically
{
    Question* q1 = [[Question alloc]init];
    q1.date = [NSDate distantPast];
    
    Question* q2 = [[Question alloc]init];
    q2.date = [NSDate distantFuture];
    
    [testTopic addQuestion:q1];
    [testTopic addQuestion:q2];
    
    NSArray* questions = [testTopic recentQuestions];
    Question* listedFirst = [questions firstObject];
    Question* listedSecond = [questions lastObject];
    
    XCTAssertEqualObjects([listedFirst.date laterDate:listedSecond.date], listedFirst.date, @"The later question should appear first in the list");
}

- (void)testLimitOfTwentyQuestions{
    Question* q1 = [[Question alloc]init];
    for(NSInteger i = 0; i < 25; i++){
        [testTopic addQuestion:q1];
    }
    XCTAssertTrue([[testTopic recentQuestions]count] < 21, @"There should never be more than twenty questions");
}
@end
