//
//  StackOverflowCommunicator.h
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 11/29/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowCommunicatorDelegate.h"

@class Question;
@interface StackOverflowCommunicator : NSObject<NSURLConnectionDataDelegate> {
    @protected
    NSURL *fetchingURL;
    NSURLConnection *fetchingConnection;
}
@property (weak) id<StackOverflowCommunicatorDelegate> delegate;
- (void)searchForQuestionsWithTag: (NSString*)tag;
- (void)downloadInformationForQuestionWithID: (NSInteger)identifier;
- (void)downloadAnswersToQuestionWithID: (NSInteger)identifier;
- (void)fetchBodyForQuestion: (Question*)question;
- (void)cancelAndDiscardURLConnection;

@end
