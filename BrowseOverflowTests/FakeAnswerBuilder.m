//
//  FakeAnswerBuilder.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/21/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import "FakeAnswerBuilder.h"

@implementation FakeAnswerBuilder
- (BOOL)addAnswersToQuestion: (Question *)question fromJSON: (NSString *)objectNotation error: (NSError **)addError {
    self.questionToFill = question;
    self.receivedJSON = objectNotation;
    if (addError) {
        *addError = self.error;
    }
    return self.successful;
}
@end
