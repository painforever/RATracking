//
//  JointPositionTableViewController.h
//  RATracking
//
//  Created by Yu Song on 9/17/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JointViewController.h"
#import "BackJointViewController.h"
#import "FingersJointsViewController.h"

@interface JointPositionTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *positions;
@end
