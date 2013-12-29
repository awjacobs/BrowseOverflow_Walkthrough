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

extern NSString* StackOverflowCommunicatorErrorDomain;

@interface StackOverflowCommunicator : NSObject<NSURLConnectionDataDelegate> {
@protected
    NSURL *fetchingURL;
    NSURLConnection *fetchingConnection;
    NSMutableData *receivedData;
@private
    void (^errorHandler)(NSError *);
    void (^successHandler)(NSString *);
}
@property (assign) id<StackOverflowCommunicatorDelegate> delegate;

- (void)searchForQuestionsWithTag: (NSString*)tag;
- (void)downloadInformationForQuestionWithID: (NSInteger)identifier;
- (void)downloadAnswersToQuestionWithID: (NSInteger)identifier;

- (void)cancelAndDiscardURLConnection;


@end
