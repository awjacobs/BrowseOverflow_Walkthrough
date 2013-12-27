//
//  Person.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 11/14/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import "Person.h"

@implementation Person
-(id)initWithName:(NSString*)aName avatarLocation:(NSString*)location
{
    self = [super self];
    if(self)
    {
        _name = [aName copy];
        _avatarURL = [[NSURL alloc]initWithString:location];
    }
    
    return self;
}
@end
