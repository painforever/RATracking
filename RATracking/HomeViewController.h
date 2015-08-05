//
//  HomeViewController.h
//  RATracking
//
//  Created by Yu Song on 7/28/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+SharedUIMethods.h"
#import "Manifest.h"
#import "MedHistoryCell.h"


@interface HomeViewController : UIViewController <JKPopMenuViewSelectDelegate, UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIButton *actions_btn;
@property (strong, readwrite, nonatomic) REMenu *menu;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *table_data;


- (IBAction)actions_action:(id)sender;
- (IBAction)toggleMenu:(id)sender;
@end
