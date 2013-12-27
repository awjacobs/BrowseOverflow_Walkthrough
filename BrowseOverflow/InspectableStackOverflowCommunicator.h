//
//  InspectableStackOverflowCommunicator.h
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/24/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import "StackOverflowCommunicator.h"

@interface InspectableStackOverflowCommunicator : StackOverflowCommunicator
- (NSURL *)URLToFetch;
- (NSURLConnection *)currentURLConnection;
@end

