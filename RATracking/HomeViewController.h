//
//  HomeViewController.h
//  RATracking
//
//  Created by Yu Song on 7/28/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKPopMenuItem.h"
#import "JKPopMenuView.h"
#import "ReportViewController.h"
#import "UIViewController+SharedUIMethods.h"
#import "Manifest.h"
#include "REMenu.h"

@interface HomeViewController : UIViewController <JKPopMenuViewSelectDelegate>
@property (strong, nonatomic) IBOutlet UIButton *actions_btn;
@property (strong, readwrite, nonatomic) REMenu *menu;
- (IBAction)actions_action:(id)sender;
- (IBAction)toggleMenu:(id)sender;
@end
