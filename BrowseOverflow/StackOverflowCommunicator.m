//
//  StackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 11/29/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import "StackOverflowCommunicator.h"
#define kAPIURL @"http://api.stackoverflow.com/1.1/"
#define kQuestionListSearch @"search?tagged="
#define kQuestionAPI @"questions/"
#define kBodyTrue @"?body=true"
#define kAnswerSearch @"/answers"
#define kpageSize @"&pagesize=20"

@implementation StackOverflowCommunicator

-(void)searchForQuestionsWithTag:(NSString *)tag {
    [self fetchContentAtURL:[NSURL URLWithString:
                             [NSString stringWithFormat:@"%@%@%@%@",kAPIURL, kQuestionListSearch, tag, kpageSize]]];
}

-(void)downloadInformationForQuestionWithID:(NSInteger)identifier {
    [self fetchContentAtURL:[NSURL URLWithString:
                             [NSString stringWithFormat:@"%@%@%d%@", kAPIURL, kQuestionAPI, identifier, kBodyTrue]]];
}

-(void)downloadAnswersToQuestionWithID:(NSInteger)identifier {
    [self fetchContentAtURL:[NSURL URLWithString:
                             [NSString stringWithFormat:@"%@%@%d%@%@", kAPIURL, kQuestionAPI, identifier, kAnswerSearch,   kBodyTrue]]];
}
#pragma mark - Helper Methods
- (void)fetchContentAtURL:(NSURL *)url {
    fetchingURL = url;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:fetchingURL];
    [self cancelAndDiscardURLConnection];
    fetchingConnection = [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)fetchContentAtURL:(NSURL *)url completionHandler:(NSInteger)f errorHandler:(NSError**)error {
    
}

-(void)cancelAndDiscardURLConnection {
    [fetchingConnection cancel];
    fetchingConnection = nil;
}

@end
