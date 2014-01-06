//
//  BrowseOverflowViewController.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/30/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import "BrowseOverflowViewController.h"
#import "TopicTableDelegate.h"

@interface BrowseOverflowViewController ()

@end

@implementation BrowseOverflowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self.tableViewDelegate;
    self.tableView.dataSource = self.dataSource;
    self.tableViewDelegate.tableDataSource = self.dataSource;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
