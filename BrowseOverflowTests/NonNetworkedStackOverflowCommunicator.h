//
//  NonNetworkedStackOverflowCommunicator.h
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/28/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import "StackOverflowCommunicator.h"

@interface NonNetworkedStackOverflowCommunicator : StackOverflowCommunicator
@property (copy) NSData *receivedData;
@end
