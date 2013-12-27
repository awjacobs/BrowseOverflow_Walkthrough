//
//  FakeQuestionBuilder.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 11/30/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import "FakeQuestionBuilder.h"

@implementation FakeQuestionBuilder
-(NSArray *)questionsFromJSON:(NSString *)objectNotation error:(NSError *__autoreleasing *)error
{
    self.JSON = objectNotation;
    *error = self.errorToSet;
    return self.arrayToReturn;
}

-(void)fillInDetailsForQuestion:(Question *)question fromJSON:(NSString *)objectNotation {
    self.JSON = objectNotation;
    self.questionToFill = question;
}
@end
