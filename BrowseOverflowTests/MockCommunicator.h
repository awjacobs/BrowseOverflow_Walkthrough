//
//  MockCommunicator.h
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/18/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowCommunicator.h"

@interface MockCommunicator : StackOverflowCommunicator
- (BOOL)wasAskedToFetchQuestions;
- (BOOL)wasAskedToFetchBody;
- (NSInteger)askedForAnswersToQuestionID;
@end
