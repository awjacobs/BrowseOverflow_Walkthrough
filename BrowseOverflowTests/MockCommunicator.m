//
//  MockCommunicator.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/18/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import "MockCommunicator.h"
@class Question;
@implementation MockCommunicator
{
    BOOL wasAskedToFetchQuestions;
    BOOL wasAskedToFetchBody;
    NSInteger questionID;
}

- (void)searchForQuestionsWithTag:(NSString *)tag{
    wasAskedToFetchQuestions = YES;
}

-(void)fetchBodyForQuestion:(Question *)question {
    wasAskedToFetchBody = YES;
}

- (void)downloadAnswersToQuestionWithID: (NSInteger)identifier {
    questionID = identifier;
}

#pragma mark - Mock Stuff
-(BOOL)wasAskedToFetchQuestions {
    return wasAskedToFetchQuestions;
}

-(BOOL)wasAskedToFetchBody {
    return wasAskedToFetchBody;
}

-(NSInteger)askedForAnswersToQuestionID {
    return questionID;
}
@end
