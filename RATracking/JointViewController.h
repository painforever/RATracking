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
@property (strong, nonatomic) IBOutlet UIButton *neck;
@property (strong, nonatomic) IBOutlet UIButton *left_shoulder;
@property (strong, nonatomic) IBOutlet UIButton *right_shoulder;
@property (strong, nonatomic) IBOutlet UIButton *left_arm_joint;
@property (strong, nonatomic) IBOutlet UIButton *right_arm_joint;
@property (strong, nonatomic) IBOutlet UIButton *left_hand;
@property (strong, nonatomic) IBOutlet UIButton *right_hand;
@property (strong, nonatomic) IBOutlet UIButton *left_root_leg;
@property (strong, nonatomic) IBOutlet UIButton *right_root_leg;
@property (strong, nonatomic) IBOutlet UIButton *left_leg_joint;
@property (strong, nonatomic) IBOutlet UIButton *right_leg_joint;
@property (strong, nonatomic) IBOutlet UIButton *left_feet;
@property (strong, nonatomic) IBOutlet UIButton *right_feet;

@property (strong, nonatomic) NSMutableArray *all_buttons;

//non controls
@property (strong, nonatomic) NSString *selected_part;
@property (strong, nonatomic) NSMutableDictionary *all_parts;


- (IBAction)actions_action:(id)sender;
- (IBAction)toggleMenu:(id)sender;
@end
