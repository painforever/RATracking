//
//  SearchViewController.h
//  RATracking
//
//  Created by Yu Song on 8/6/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Manifest.h"
#import "PharmacyCell.h"
#import "PharmacyDetailsViewController.h"

@interface SearchViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSMutableArray *table_data;
@property (strong, nonatomic) NSMutableArray *searchResult;
@end
