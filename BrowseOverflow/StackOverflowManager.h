//
//  StackOverflowManager.h
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 11/20/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowManagerDelegate.h"

@class StackOverflowCommunicator;
@class QuestionBuilder;
@class Question;
@class Topic;
@class AnswerBuilder;

extern NSString* StackOverflowManagerError;
enum {
    StackOverflowManagerErrorQuestionSearchCode,
    StackOverflowManagerErrorBodyFetchCode,
    StackOverflowManagerErrorAnswerFetchCode
};

@interface StackOverflowManager : NSObject
@property (weak, nonatomic) id<StackOverflowManagerDelegate> delegate;
@property (strong, nonatomic) StackOverflowCommunicator* communicator;
@property (strong) QuestionBuilder *questionBuilder;
@property (strong) AnswerBuilder *answerBuilder;
@property (strong) Question *questionToFill;

//Fetch Question Headers
- (void)fetchQuestionsOnTopic:(Topic *)topic;
- (void)searchingForQuestionsFailedWithError: (NSError*)error;
- (void)receivedQuestionsJSON:(NSString*)objectNotation;

//Fetch Question Body
- (void)fetchBodyForQuestion:(Question *)question;
- (void)fetchingQuestionBodyFailedWithError: (NSError*)error;
- (void)receivedQuestionBodyJSON:(NSString*)objectNotation;

//Fetch Answers
- (void)fetchAnswersForQuestion:(Question *)question;
- (void)fetchingAnswersFailedWithError: (NSError *)error;
- (void)receivedAnswerListJSON:(NSString *)objectNotation;
@end
