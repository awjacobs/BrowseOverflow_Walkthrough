//
//  Answer.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 11/17/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import "Answer.h"

@implementation Answer
- (NSComparisonResult)compare:(Answer*)otherAnswer
{
    if(self.accepted && !(otherAnswer.accepted))
    {
        return NSOrderedAscending;
    } else if (!self.accepted && otherAnswer.accepted)
    {
        return NSOrderedDescending;
    }
    if(self.score > otherAnswer.score)
    {
        return NSOrderedAscending;
    } else if (self.score < otherAnswer.score)
    {
        return NSOrderedDescending;
    } else
    {
        return NSOrderedSame;
    }
}
@end
