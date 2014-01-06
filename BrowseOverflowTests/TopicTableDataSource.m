//
//  TopicTableDataSource.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 1/3/14.
//  Copyright (c) 2014 Aggrey Jacobs. All rights reserved.
//

#import "TopicTableDataSource.h"
#import "Topic.h"

@implementation TopicTableDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSParameterAssert(section == 0);
    return [self.topics count];
}

NSString *topicCellReuseIdentifier = @"Topic";

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSParameterAssert([indexPath section] == 0);
    NSParameterAssert([indexPath row] < [self.topics count]);
    UITableViewCell *topicCell = [tableView dequeueReusableCellWithIdentifier:topicCellReuseIdentifier];
    if(!topicCell) {
        topicCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topicCellReuseIdentifier];
    }
    topicCell.textLabel.text = [[self topicForIndexPath:indexPath] name];
    return topicCell;
}

-(Topic *)topicForIndexPath:(NSIndexPath *)indexPath {
    return [self.topics objectAtIndex:[indexPath row]];
}
@end
