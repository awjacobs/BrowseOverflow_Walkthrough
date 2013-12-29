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

#define kHTTPOKStatus 200
NSString* StackOverflowCommunicatorErrorDomain = @"StackOverflowCommunicatorErrorDomain";

@implementation StackOverflowCommunicator

-(void)dealloc {
    [fetchingConnection cancel];
}

-(void)searchForQuestionsWithTag:(NSString *)tag {
    [self fetchContentAtURL:[NSURL URLWithString:
                             [NSString stringWithFormat:@"%@%@%@%@",kAPIURL, kQuestionListSearch, tag, kpageSize]]
               errorHandler:^(NSError *error) {
                   [self.delegate searchingForQuestionsFailedWithError: error];
               }
             successHandler:^(NSString *objectNotation) {
                 [self.delegate receivedQuestionsJSON: objectNotation];
             }];
}

-(void)downloadInformationForQuestionWithID:(NSInteger)identifier {
    [self fetchContentAtURL:[NSURL URLWithString:
                             [NSString stringWithFormat:@"%@%@%d%@", kAPIURL, kQuestionAPI, identifier, kBodyTrue]]
               errorHandler:^(NSError *error) {
                   [self.delegate fetchingQuestionBodyFailedWithError:error];
               }
             successHandler:^(NSString *objectNotation) {
                 [self.delegate receivedQuestionBodyJSON:objectNotation];
             }];
}

-(void)downloadAnswersToQuestionWithID:(NSInteger)identifier {
    [self fetchContentAtURL:[NSURL URLWithString:
                             [NSString stringWithFormat:@"%@%@%d%@%@", kAPIURL, kQuestionAPI, identifier, kAnswerSearch,   kBodyTrue]]
               errorHandler:^(NSError *error) {
                   [self.delegate fetchingAnswersFailedWithError:error];
               }
             successHandler:^(NSString *objectNotation) {
                 [self.delegate receivedAnswerListJSON:objectNotation];
             }];
}
#pragma mark - Helper Methods

- (void)launchConnectionForRequest: (NSURLRequest *)request {
    [self cancelAndDiscardURLConnection];
    fetchingConnection = [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)fetchContentAtURL:(NSURL *)url errorHandler:(void (^) (NSError *))errorBlock successHandler:(void (^) (NSString *))successBlock {
    fetchingURL = url;
    errorHandler = [errorBlock copy];
    successHandler = [successBlock copy];
    NSURLRequest *request = [NSURLRequest requestWithURL:fetchingURL];
    [self launchConnectionForRequest:request];
}
-(void)cancelAndDiscardURLConnection {
    [fetchingConnection cancel];
    fetchingConnection = nil;
}

#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    receivedData = nil;
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if ([httpResponse statusCode] != kHTTPOKStatus) {
        NSError *error = [NSError errorWithDomain:StackOverflowCommunicatorErrorDomain code:[httpResponse statusCode] userInfo:nil];
        errorHandler(error);
        [self cancelAndDiscardURLConnection];
    } else {
        receivedData = [[NSMutableData alloc]init];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    receivedData = nil;
    fetchingConnection = nil;
    fetchingURL = nil;
    errorHandler(error);
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    fetchingConnection = nil;
    fetchingURL = nil;
    NSString *receivedText = [[NSString alloc]initWithData:receivedData encoding:NSUTF8StringEncoding];
    receivedData = nil;
    successHandler(receivedText);
}
@end
