//
//  PersonTests.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 11/14/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Person.h"
@interface PersonTests : XCTestCase
{
    Person* newPerson;
}
@end

@implementation PersonTests

- (void)setUp
{
    [super setUp];
    newPerson = [[Person alloc] initWithName: @"Graham Lee" avatarLocation: @"http://example.com/avatar.png"];
}


- (void)tearDown
{
    newPerson = nil;
    [super tearDown];
}

- (void)testThatPersonHasTheRightName
{
    XCTAssertEqualObjects(newPerson.name, @"Graham Lee", @"Expecting a person to provide its name");
}

- (void) testThatPersonHasAnAvatarURL
{
    NSURL* url = newPerson.avatarURL;
    XCTAssertEqualObjects([url absoluteString], @"http://example.com/avatar.png", @"The Person's avatar should be represented by a URL");
}
@end
