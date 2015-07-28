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

@interface HomeViewController : UIViewController <JKPopMenuViewSelectDelegate>
@property (strong, nonatomic) IBOutlet UIButton *actions_btn;
- (IBAction)actions_action:(id)sender;

@end
