//
//  MockStackOverflowManagerDelegate.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/18/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import "MockStackOverflowManagerDelegate.h"

@implementation MockStackOverflowManagerDelegate
-(void)fetchingQuestionsFailedWithError:(NSError *)error {
    self.fetchError = error;
}

-(void)didReceiveQuestions:(NSArray *)questions {
    self.receivedQuestions = questions;
}

-(void)fetchingQuestionBodyFailedWithError:(NSError *)error {
    self.fetchError = error;
}

-(void)fetchingAnswersFailedWithError:(NSError *)error {
    self.fetchError = error;
}

-(void)didReceiveBodyForQuestion:(Question *)question {
    self.bodyQuestion = question;
}

-(void)didReceiveAnswersForQuestion:(Question *)question {
    self.successQuestion = question;
}
@end
