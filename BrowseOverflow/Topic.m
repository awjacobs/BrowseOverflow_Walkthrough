//
//  Topic.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 11/14/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import "Topic.h"
#import "Question.h"

@implementation Topic
{
    NSArray* topicQuestions;
}
-(id)initWithName:(NSString*)newName tag:(NSString*)newTag
{
    self = [super init];
    if(self)
    {
        _name = [newName copy];
        _tag = [newTag copy];
        topicQuestions = [[NSArray alloc]init];
    }
    return self;
}



- (NSArray *)sortQuestionsLatestFirst:(NSArray*)questionList
{
    return [questionList sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        Question* q1 = (Question*)obj1;
        Question* q2 = (Question*)obj2;
        return [q2.date compare:q1.date];
    }];
}

-(NSArray*)recentQuestions
{
    return [self sortQuestionsLatestFirst: topicQuestions];
}

-(void)addQuestion:(Question *)newQuestion
{
    NSArray* newQuestionsArray = [topicQuestions arrayByAddingObject:newQuestion];
    if([newQuestionsArray count] > 20)
    {
        newQuestionsArray = [self sortQuestionsLatestFirst:newQuestionsArray];
        newQuestionsArray = [newQuestionsArray subarrayWithRange:NSMakeRange(0, 20)];
    }
    topicQuestions = newQuestionsArray;
}
@end


