//
//  Answer.h
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 11/17/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Person;

@interface Answer : NSObject
@property (strong, nonatomic) NSString* text;
@property (strong, nonatomic) Person* person;
@property NSInteger score;
@property (getter = isAccepted) BOOL accepted;
- (NSComparisonResult)compare:(Answer*)otherAnswer;
@end
