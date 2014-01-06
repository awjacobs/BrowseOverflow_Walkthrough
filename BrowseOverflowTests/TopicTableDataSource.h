//
//  TopicTableDataSource.h
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 1/3/14.
//  Copyright (c) 2014 Aggrey Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Topic;
@interface TopicTableDataSource : NSObject<UITableViewDataSource>
@property (nonatomic) NSArray *topics;
- (Topic *)topicForIndexPath:(NSIndexPath *)indexPath;
@end
