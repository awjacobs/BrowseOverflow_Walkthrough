//
//  BrowseOverflowViewController.h
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/30/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowseOverflowViewController : UIViewController
@property (strong) UITableView *tableView;
@property (strong) id<UITableViewDataSource> dataSource;
@property (strong) id<UITableViewDelegate> tableViewDelegate;
@end
