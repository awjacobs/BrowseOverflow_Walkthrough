//
//  BrowseOverflowViewController.h
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/30/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TopicTableDelegate;
@class TopicTableDataSource;

@interface BrowseOverflowViewController : UIViewController
@property (strong) UITableView *tableView;
@property (strong) TopicTableDataSource<UITableViewDataSource> *dataSource;
@property (strong) TopicTableDelegate<UITableViewDelegate> *tableViewDelegate;
@end
