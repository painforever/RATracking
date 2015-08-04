//
//  JointViewController.h
//  RATracking
//
//  Created by Yu Song on 8/4/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+SharedUIMethods.h"

@interface JointViewController : UIViewController <JKPopMenuViewSelectDelegate>
@property (strong, readwrite, nonatomic) REMenu *menu;
- (IBAction)actions_action:(id)sender;
- (IBAction)toggleMenu:(id)sender;
@end