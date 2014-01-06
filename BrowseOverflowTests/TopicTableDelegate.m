//
//  EmptyTableViewDelegate.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 1/3/14.
//  Copyright (c) 2014 Aggrey Jacobs. All rights reserved.
//

#import "TopicTableDelegate.h"
#import "TopicTableDataSource.h"

NSString *TopicTableDidSelectTopicNotification = @"TopicTableDidSelectTopicNotification";
@implementation TopicTableDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNotification *note = [NSNotification notificationWithName:TopicTableDidSelectTopicNotification
                                                         object:[self.tableDataSource topicForIndexPath:indexPath]];
    [[NSNotificationCenter defaultCenter]postNotification:note];
}

@end
