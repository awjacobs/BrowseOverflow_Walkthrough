//
//  MockStackOverflowManagerDelegate.h
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/18/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowManagerDelegate.h"
@class Question;

@interface MockStackOverflowManagerDelegate : NSObject<StackOverflowManagerDelegate>
@property (strong) NSError* fetchError;
@property (nonatomic) NSArray* receivedQuestions;
@property (strong) Question *successQuestion;
@property (strong) Question *bodyQuestion;
@end
