//
//  Question.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 11/14/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import "Question.h"
#import "Answer.h"

@implementation Question

-(id)init
{
    self = [super init];
    if(self)
    {
        answerSet = [[NSMutableSet alloc]init];
    }
    return self;
}

-(void)addAnswer:(Answer *)newAnswer
{
    [answerSet addObject:newAnswer];
}

- (NSArray*)answers
{
    return [[answerSet allObjects]
            sortedArrayUsingSelector:@selector(compare:)];
}
@end
