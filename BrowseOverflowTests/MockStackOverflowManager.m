//
//  MockStackOverflowManager.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/28/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import "MockStackOverflowManager.h"

@implementation MockStackOverflowManager

-(NSInteger)topicFailureErrorCode {
    return topicFailureErrorCode;
}

-(NSInteger)bodyFailureErrorCode {
    return bodyFailureErrorCode;
}

-(NSInteger)answerFailureErrorCode {
    return answerFailureErrorCode;
}

-(NSString *)questionBodyString {
    return questionBodyString;
}

-(NSString *)topicSearchString {
    return topicSearchString;
}

-(NSString *)answerListString {
    return answerListString;
}

-(void)searchingForQuestionsFailedWithError:(NSError *)error {
    topicFailureErrorCode = [error code];
}

-(void)receivedQuestionsJSON:(NSString *)objectNotation {
    topicSearchString = objectNotation;
}

-(void)fetchingQuestionBodyFailedWithError:(NSError *)error {
    bodyFailureErrorCode = [error code];
}

-(void)receivedQuestionBodyJSON:(NSString *)objectNotation {
    questionBodyString = objectNotation;
}

-(void)fetchingAnswersFailedWithError:(NSError *)error {
    answerFailureErrorCode = [error code];
}

-(void)receivedAnswerListJSON:(NSString *)objectNotation {
    answerListString = objectNotation;
}
@end
