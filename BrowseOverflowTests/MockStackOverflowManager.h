//
//  MockStackOverflowManager.h
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/28/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import "StackOverflowManager.h"
#import "StackOverflowCommunicatorDelegate.h"
@class Topic;
@class Question;

@interface MockStackOverflowManager : NSObject<StackOverflowCommunicatorDelegate>
{
    NSInteger topicFailureErrorCode;
    NSInteger bodyFailureErrorCode;
    NSInteger answerFailureErrorCode;
    NSString *topicSearchString;
    NSString *questionBodyString;
    NSString *answerListString;
}

- (NSInteger)topicFailureErrorCode;
- (NSInteger)bodyFailureErrorCode;
- (NSInteger)answerFailureErrorCode;
- (NSString *)topicSearchString;
- (NSString *)questionBodyString;
- (NSString *)answerListString;


@property (strong) id delegate;
@end
