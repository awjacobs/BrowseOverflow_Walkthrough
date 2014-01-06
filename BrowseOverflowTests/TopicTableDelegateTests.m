//
//  TopicTableDelegateTests.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 1/5/14.
//  Copyright (c) 2014 Aggrey Jacobs. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TopicTableDelegate.h"
#import "TopicTableDataSource.h"
#import "Topic.h"
@interface TopicTableDelegateTests : XCTestCase
{
    NSNotification *receivedNotification;
    TopicTableDelegate *delegate;
    TopicTableDataSource *dataSource;
    Topic *iPhoneTopic;
}
@end

@implementation TopicTableDelegateTests

- (void)setUp
{
    [super setUp];
    delegate = [[TopicTableDelegate alloc]init];
    dataSource = [[TopicTableDataSource alloc]init];
    iPhoneTopic = [[Topic alloc]initWithName:@"iPhone" tag:@"iphone"];
    [dataSource setTopics:[NSArray arrayWithObject: iPhoneTopic]];
    delegate.tableDataSource = dataSource;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveNotification:)
                                                 name:TopicTableDidSelectTopicNotification
                                               object:nil];
}

- (void)tearDown
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [super tearDown];
}

- (void)didReceiveNotification: (NSNotification *)note {
    receivedNotification = note;
}

- (void)testDelegatePostsNotificationOnSelectionShowingWhichTopicWasSelected {
    NSIndexPath *selection = [NSIndexPath indexPathForRow:0 inSection:0];
    [delegate tableView:nil didSelectRowAtIndexPath:selection];
    XCTAssertEqualObjects([receivedNotification name], @"TopicTableDidSelectTopicNotification", @"The delegate should notify that a topic was selected");
    XCTAssertEqualObjects([receivedNotification object], iPhoneTopic, @"The notification should indicate which topic was selected");
}

@end
