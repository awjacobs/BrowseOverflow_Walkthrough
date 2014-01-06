//
//  EmptyTableViewDelegate.h
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 1/3/14.
//  Copyright (c) 2014 Aggrey Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TopicTableDataSource;

extern NSString *TopicTableDidSelectTopicNotification;

@interface TopicTableDelegate : NSObject<UITableViewDelegate>
@property (strong) TopicTableDataSource *tableDataSource;
@end
