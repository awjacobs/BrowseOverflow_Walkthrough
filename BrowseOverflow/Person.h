//
//  Person.h
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 11/14/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
-(id)initWithName:(NSString*)aName avatarLocation:(NSString*)location;
@property (readonly) NSString* name;
@property (readonly) NSURL* avatarURL;
@end
