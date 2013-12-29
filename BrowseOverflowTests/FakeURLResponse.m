//
//  FakeURLResponse.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/28/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import "FakeURLResponse.h"
@interface FakeURLResponse()

@end

@implementation FakeURLResponse
- (id)initWithStatusCode:(NSInteger)code {
    self = [super init];
    if(self) {
        statusCode = code;
    }
    return self;
}

-(NSInteger)statusCode {
    return statusCode;
}
@end
