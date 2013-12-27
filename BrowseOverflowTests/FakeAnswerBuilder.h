//
//  FakeAnswerBuilder.h
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/21/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import "AnswerBuilder.h"

@interface FakeAnswerBuilder : AnswerBuilder
@property (retain) NSString *receivedJSON;
@property (retain) Question *questionToFill;
@property (retain) NSError *error;
@property BOOL successful;
@end
