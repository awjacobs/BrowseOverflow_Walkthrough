//
//  BrowseOverflowViewControllerTests.m
//  BrowseOverflow
//
//  Created by Aggrey Jacobs on 12/30/13.
//  Copyright (c) 2013 Aggrey Jacobs. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BrowseOverflowViewController.h"
#import <objc/runtime.h>
#import "EmptyTableViewDataSource.h"
#import "EmptyTableViewDelegate.h"

@interface BrowseOverflowViewControllerTests : XCTestCase
{
    BrowseOverflowViewController *viewController;
    UITableView *tableView;
}
@end

@implementation BrowseOverflowViewControllerTests

- (void)setUp
{
    [super setUp];
    viewController = [[BrowseOverflowViewController alloc]init];
    tableView = [[UITableView alloc]init];
    viewController.tableView = tableView;
}

- (void)testViewControllerHasATableViewProperty {
    objc_property_t tableViewProperty = class_getProperty([viewController class], "tableView");
    XCTAssertTrue(tableViewProperty != NULL, @"BrowseOverflowViewController needs a table view");
}

- (void)testViewControllerHasADataSourceProperty {
    objc_property_t dataSourceProperty = class_getProperty([viewController class], "dataSource");
    XCTAssertTrue(dataSourceProperty != NULL, @"BrowseOverflowViewController needs a data source");
}

- (void)testViewControllerHasATableViewDelegateProperty {
    objc_property_t delegateProperty = class_getProperty([viewController class], "tableViewDelegate");
    XCTAssertTrue(delegateProperty != NULL, @"BrowseOverflowViewController needs a tableview delegate");
}

- (void)testViewControllerConnectsDataSourceInViewDidLoad {
    id <UITableViewDataSource> dataSource = [[EmptyTableViewDataSource alloc]init];
    viewController.dataSource = dataSource;
    [viewController viewDidLoad];
    XCTAssertEqualObjects([tableView dataSource], dataSource, @"View controller should have set the table view's data source");
}

- (void)testViewControllerConnectsDelegateInViewDidLoad {
    id <UITableViewDelegate> delegate = [[EmptyTableViewDelegate alloc]init];
    viewController.tableViewDelegate = delegate;
    [viewController viewDidLoad];
    XCTAssertEqualObjects([tableView delegate], delegate, @"View controller should have set the table view's delegate");
}
@end
