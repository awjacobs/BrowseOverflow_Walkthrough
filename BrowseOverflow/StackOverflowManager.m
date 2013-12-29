//
//  StackOverflowManager.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 11/20/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import "StackOverflowManager.h"
#import "StackOverflowCommunicator.h"
#import "Topic.h"
#import "QuestionBuilder.h"
#import "Question.h"
#import "AnswerBuilder.h"

NSString* StackOverflowManagerError = @"StackOverflowManagerError";
@interface StackOverflowManager ()
@property (weak, nonatomic) Question *questionNeedingBody;
@end

@implementation StackOverflowManager
#pragma mark -
-(void)setDelegate:(id<StackOverflowManagerDelegate>)delegate{
    if(delegate && ![delegate conformsToProtocol:@protocol(StackOverflowManagerDelegate)])
    {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate object does not conform to the delegate protocol" userInfo:nil]raise];
    }
    _delegate = delegate;
}

#pragma mark - Question Header Fetching
-(void)fetchQuestionsOnTopic:(Topic*)topic {
    [self.communicator searchForQuestionsWithTag: [topic tag]];
}

- (void)searchingForQuestionsFailedWithError: (NSError*)error {
    [self tellDelegateAboutQuestionSearchError:error];
}

-(void)receivedQuestionsJSON:(NSString *)objectNotation {
    NSError* error = nil;
    NSArray* questions = [self.questionBuilder questionsFromJSON:objectNotation error:&error];
    if(!questions) {
        [self tellDelegateAboutQuestionSearchError:error];
    } else {
        [self.delegate didReceiveQuestions:questions];
    }
}

#pragma mark - Question Body Fetching

-(void)fetchBodyForQuestion:(Question *)question {
    self.questionNeedingBody = question;
    [self.communicator downloadInformationForQuestionWithID:question.questionID];
}

-(void)receivedQuestionBodyJSON:(NSString *)objectNotation {
    [self.questionBuilder fillInDetailsForQuestion:self.questionNeedingBody fromJSON:objectNotation];
    [self.delegate didReceiveBodyForQuestion:self.questionNeedingBody];
    self.questionToFill = nil;
}

-(void)fetchingQuestionBodyFailedWithError:(NSError *)error {
    [self tellDelegateAboutBodyFetchError:error];
}

#pragma mark - Answer Fetching
-(void)fetchAnswersForQuestion:(Question *)question {
    self.questionToFill = question;
    [self.communicator downloadAnswersToQuestionWithID:question.questionID];
}

-(void)fetchingAnswersFailedWithError:(NSError *)error {
    [self tellDelegateAboutAnswerFetchError:error];
}

-(void)receivedAnswerListJSON:(NSString *)objectNotation {
    NSError *error = nil;
    if([self.answerBuilder addAnswersToQuestion:self.questionToFill fromJSON:objectNotation error:&error]) {
        [self.delegate didReceiveAnswersForQuestion:self.questionToFill];
        self.questionToFill = nil;
    } else {
        [self fetchingAnswersFailedWithError:error];
    }
}

#pragma mark - Error Messaging
- (void)tellDelegateAboutQuestionSearchError:(NSError*)error {
    if(error) {
        NSDictionary* errorInfo = [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
        NSError* reportableError = [NSError errorWithDomain:StackOverflowManagerError code:StackOverflowManagerErrorQuestionSearchCode userInfo:errorInfo];
        [self.delegate fetchingQuestionsFailedWithError:reportableError];
    }
}

- (void)tellDelegateAboutBodyFetchError:(NSError*)error {
    if(error) {
        NSDictionary* errorInfo = [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
        NSError* reportableError = [NSError errorWithDomain:StackOverflowManagerError code:StackOverflowManagerErrorBodyFetchCode userInfo:errorInfo];
        [self.delegate fetchingQuestionBodyFailedWithError:reportableError];
    }
}

- (void)tellDelegateAboutAnswerFetchError:(NSError *)error {
    if (error) {
        NSDictionary *errorInfo = [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
        NSError *reportableError = [NSError errorWithDomain:StackOverflowManagerError code:StackOverflowManagerErrorAnswerFetchCode userInfo:errorInfo];
        [self.delegate fetchingAnswersFailedWithError:reportableError];
    }
}
@end


