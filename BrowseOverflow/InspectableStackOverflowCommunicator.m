//
//  InspectableStackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/24/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import "InspectableStackOverflowCommunicator.h"

@implementation InspectableStackOverflowCommunicator
- (NSURL *)URLToFetch {
    return fetchingURL;
}

-(NSURLConnection *)currentURLConnection {
    return fetchingConnection;
}

@end
