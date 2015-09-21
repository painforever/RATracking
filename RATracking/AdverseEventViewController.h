//
//  AdverseEventViewController.h
//  RATracking
//
//  Created by Yu Song on 8/4/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+SharedUIMethods.h"
#import "AdverseDetailsCell.h"
#import "AdverseDetailsViewController.h"

@interface AdverseEventViewController : UIViewController <JKPopMenuViewSelectDelegate , UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) REMenu *menu;
@property (strong, nonatomic) NSMutableArray *table_data;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) UIImageView *selected_image_view;


- (IBAction)actions_action:(id)sender;
- (IBAction)toggleMenu:(id)sender;
@end
