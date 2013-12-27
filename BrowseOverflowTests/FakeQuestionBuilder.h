//
//  FakeQuestionBuilder.h
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 11/30/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import "QuestionBuilder.h"

@class Question;

@interface FakeQuestionBuilder : QuestionBuilder
@property (copy) NSString* JSON;
@property (copy) NSArray* arrayToReturn;
@property (copy) NSError* errorToSet;
@property (strong) Question* questionToFill;
@end
