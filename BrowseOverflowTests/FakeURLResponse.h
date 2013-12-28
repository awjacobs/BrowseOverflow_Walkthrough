//
//  FakeURLResponse.h
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/28/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FakeURLResponse : NSURLResponse
- (id)initWithStatusCode:(NSInteger)statusCode;
@end
