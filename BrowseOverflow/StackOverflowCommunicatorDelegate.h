//
//  StackOverflowCommunicatorDelegate.h
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/28/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StackOverflowCommunicatorDelegate <NSObject>
- (void)searchingForQuestionsFailedWithError: (NSError*)error;
- (void)receivedQuestionsJSON:(NSString*)objectNotation;

- (void)fetchingQuestionBodyFailedWithError: (NSError*)error;
- (void)receivedQuestionBodyJSON:(NSString*)objectNotation;

- (void)fetchingAnswersFailedWithError: (NSError *)error;
- (void)receivedAnswerListJSON:(NSString *)objectNotation;
@end
