//
//  AnswerBuilder.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/14/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import "AnswerBuilder.h"
#import "Answer.h"
#import "Question.h"
#import "PersonBuilder.h"

NSString *AnswerBuilderErrorDomain = @"AnswerBuilderErrorDomain";

@implementation AnswerBuilder
-(BOOL)addAnswersToQuestion:(Question *)question fromJSON:(NSString *)objectNotation error:(NSError *__autoreleasing *)error {
    NSParameterAssert(objectNotation != nil);
    NSParameterAssert(question != nil);
    NSError *localError = nil;
    NSData *unicodeNotation = [objectNotation dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:unicodeNotation options:0 error:&localError];
    if (parsedObject == nil) {
        if (error != NULL) {
            *error = [NSError errorWithDomain:AnswerBuilderErrorDomain code:AnswerBuilderInvalidJSONError userInfo:nil];
        }
        return NO;
    }
    NSArray *answers = [parsedObject objectForKey:@"answers"];
    if(answers == nil) {
        if (error != NULL) {
            *error = [NSError errorWithDomain:AnswerBuilderErrorDomain code:AnswerBuilderMissingDataError userInfo:nil];
        }
        return NO;
    }
    
    for (NSDictionary *answerData in answers) {
        Answer *thisAnswer = [[Answer alloc] init];
        thisAnswer.text = [answerData objectForKey: @"body"];
        thisAnswer.accepted = [[answerData objectForKey: @"accepted"] boolValue];
        thisAnswer.score = [[answerData objectForKey: @"score"] integerValue];
        NSDictionary *ownerData = [answerData objectForKey: @"owner"];
        thisAnswer.person = [PersonBuilder personFromDictionary: ownerData];
        [question addAnswer: thisAnswer];
    }
    return YES;
}

@end
