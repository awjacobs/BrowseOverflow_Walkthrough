//
//  Topic.h
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 11/14/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Question;

@interface Topic : NSObject
@property (readonly) NSString* name;
@property (readonly) NSString* tag;

-(id)initWithName:(NSString*)name tag:(NSString*)tag;
-(NSArray*)recentQuestions;
-(void)addQuestion: (Question*)newQuestion;
@end
