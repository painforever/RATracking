//
//  SearchViewController.h
//  RATracking
//
//  Created by Yu Song on 8/6/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UITableViewController <UISearchBarDelegate>

@property (strong, nonatomic) NSMutableArray *table_data;
@property (strong, nonatomic) NSMutableArray *searchResult;
@end
