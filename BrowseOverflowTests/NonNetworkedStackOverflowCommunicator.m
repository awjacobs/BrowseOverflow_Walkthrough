//
//  NonNetworkedStackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/28/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import "NonNetworkedStackOverflowCommunicator.h"

@implementation NonNetworkedStackOverflowCommunicator
- (void)launchConnectionForRequest: (NSURLRequest *)request {

}

-(void)setReceivedData:(NSData *)data {
    receivedData = [data mutableCopy];
}

-(NSData *)receivedData {
    return [receivedData copy];
}
@end
