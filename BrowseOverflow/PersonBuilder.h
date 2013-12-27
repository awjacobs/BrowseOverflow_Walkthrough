//
//  PersonBuilder.h
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/14/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface PersonBuilder : NSObject

+ (Person *) personFromDictionary:(NSDictionary *)personValues;
@end
