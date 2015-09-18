//
//  FingersJointsViewController.h
//  RATracking
//
//  Created by Yu Song on 9/17/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+SharedUIMethods.h"

@interface FingersJointsViewController : UIViewController <JKPopMenuViewSelectDelegate>
@property (strong, readwrite, nonatomic) REMenu *menu;
@property (strong, nonatomic) NSString *selected_part;
@property (strong, nonatomic) IBOutlet UIButton *actions_btn;


- (IBAction)toggleMenu:(id)sender;

@end
