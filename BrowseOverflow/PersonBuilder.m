//
//  PersonBuilder.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/14/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import "PersonBuilder.h"

@implementation PersonBuilder
+ (Person *)personFromDictionary:(NSDictionary *)personValues {
    NSString *name = [personValues objectForKey: @"display_name"];
    NSString *avatarURL = [NSString stringWithFormat: @"http://www.gravatar.com/avatar/%@", [personValues objectForKey: @"email_hash"]];
    Person *owner = [[Person alloc] initWithName: name avatarLocation: avatarURL];
    return owner;
}
@end
