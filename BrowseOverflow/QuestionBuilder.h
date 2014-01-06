//
//  QuestionBuilder.h
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 11/30/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question;
extern NSString* QuestionBuilderErrorDomain;

NS_ENUM(NSInteger, QuestionBuilderErrors) {
    QuestionBuilderInvalidJSONError,
    QuestionBuilderMissingDataError
};

@interface QuestionBuilder : NSObject
- (NSArray*)questionsFromJSON: (NSString *)objectNotation
                        error:(NSError **)error;
- (void)fillInDetailsForQuestion: (Question *)question fromJSON:(NSString *)objectNotation;
@end
