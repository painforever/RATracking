//
//  RxTableViewController.h
//  RATracking
//
//  Created by Yu Song on 9/29/15.
//  Copyright © 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+SharedUIMethods.h"
#import "Manifest.h"
#import "MedHistoryCell.h"
#import "RxDetailsViewController.h"

@interface RxTableViewController : UITableViewController<JKPopMenuViewSelectDelegate>

@property (strong, nonatomic) IBOutlet UIButton *actions_btn;
@property (strong, readwrite, nonatomic) REMenu *menu;
@property (strong, nonatomic) NSMutableArray *table_data;
@property (weak, nonatomic) RxDetailsViewController *details;
@property (nonatomic) int selected_index;


- (IBAction)actions_action:(id)sender;
- (IBAction)toggleMenu:(id)sender;
@end
