//
//  AnswerBuilder.h
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/14/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Question;
extern NSString *AnswerBuilderErrorDomain;
enum {
    AnswerBuilderInvalidJSONError,
    AnswerBuilderMissingDataError
};

@interface AnswerBuilder : NSObject
- (BOOL)addAnswersToQuestion:(Question *)question
                        fromJSON:(NSString *)objectNotation
                           error:(NSError **)error;
@end
