//
//  Question.h
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 11/14/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Answer;
@class Person;

@interface Question : NSObject
{
    NSMutableSet* answerSet;
}

@property (strong) NSDate* date;
@property (nonatomic) Person* asker;
@property (copy) NSString* title;
@property (readonly) NSArray* answers;
@property (nonatomic) NSInteger questionID;
@property NSInteger score;
@property (copy) NSString* body;

- (void)addAnswer: (Answer*)newAnswer;
@end
