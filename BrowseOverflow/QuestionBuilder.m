//
//  QuestionBuilder.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 11/30/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import "QuestionBuilder.h"
#import "Question.h"
#import "Person.h"
#import "PersonBuilder.h"

#define kAvatarURL @"http://www.gravatar.com/avatar/"

NSString* QuestionBuilderErrorDomain = @"QuestionBuilderErrorDomain";
@implementation QuestionBuilder

-(NSArray *)questionsFromJSON:(NSString *)objectNotation error:(NSError *__autoreleasing *)error {
    NSParameterAssert(objectNotation != nil);
    NSData* unicodeNotation = [objectNotation dataUsingEncoding:NSUTF8StringEncoding];
    NSError *localError = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:unicodeNotation options:0 error:&localError];
    NSDictionary *parsedObject = (id)jsonObject;
    
    if (parsedObject == nil) {
        if(error != NULL) {
            *error = [NSError errorWithDomain:QuestionBuilderErrorDomain code:QuestionBuilderInvalidJSONError userInfo:nil];
        }
        return nil;
    }
    
    NSArray* questions = [parsedObject objectForKey:@"questions"];
    if (questions == nil) {
        if (error != NULL) {
            *error = [NSError errorWithDomain:QuestionBuilderErrorDomain code:QuestionBuilderMissingDataError userInfo:nil];
        }
        return nil;
    }
    NSMutableArray* formedQuestionsArray = [NSMutableArray array];
    for (NSDictionary* dict in questions) {
        Question* newQuestion = [[Question alloc]init];
        newQuestion.questionID = [(NSNumber*)[dict objectForKey:@"question_id"] integerValue];
        
        NSNumber* tempN = (NSNumber*)[dict objectForKey:@"creation_date"];
        newQuestion.date = [NSDate dateWithTimeIntervalSince1970: (NSTimeInterval)tempN.integerValue];
        
        newQuestion.title = (NSString*)[dict objectForKey:@"title"];
        
        newQuestion.score = [(NSNumber*)[dict objectForKey:@"score"]integerValue];

        NSDictionary* askerDict = [dict objectForKey:@"owner"];
        newQuestion.asker = [PersonBuilder personFromDictionary:askerDict];
        [formedQuestionsArray addObject:newQuestion];
    }
    
    return [NSArray arrayWithArray:formedQuestionsArray];
}
-(void)fillInDetailsForQuestion:(Question *)question fromJSON:(NSString *)objectNotation {
    NSParameterAssert(question != nil);
    NSParameterAssert(objectNotation != nil);
    NSData *unicodeNotation = [objectNotation dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:unicodeNotation options:0 error:nil];
    if (![parsedObject isKindOfClass: [NSDictionary class]]) {
        return;
    }
    NSString* body = [[[parsedObject objectForKey:@"questions"]lastObject]objectForKey:@"body"];
    
    if (body) {
        question.body = body;
    }
}
@end
