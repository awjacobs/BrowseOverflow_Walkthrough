//
//  StackOverflowManagerDelegate.h
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/18/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question;

@protocol StackOverflowManagerDelegate <NSObject>
//Fetch Question Headers
- (void)fetchingQuestionsFailedWithError: (NSError*)error;
- (void)didReceiveQuestions:(NSArray*)questions;

//Fetch Question Bodies
- (void)fetchingQuestionBodyFailedWithError: (NSError*)error;
- (void)didReceiveBodyForQuestion:(Question *)question;

//Fetch Answers
- (void)fetchingAnswersFailedWithError: (NSError *)error;
- (void)didReceiveAnswersForQuestion:(Question *)question;
@end
