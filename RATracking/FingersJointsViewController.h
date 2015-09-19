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


@property (strong, nonatomic) IBOutlet UIButton *left_5th_up;
@property (strong, nonatomic) IBOutlet UIButton *left_5th_mid;
@property (strong, nonatomic) IBOutlet UIButton *left_5th_down;

@property (strong, nonatomic) IBOutlet UIButton *left_4th_up;
@property (strong, nonatomic) IBOutlet UIButton *left_4th_mid;
@property (strong, nonatomic) IBOutlet UIButton *left_4th_down;

@property (strong, nonatomic) IBOutlet UIButton *left_3th_up;
@property (strong, nonatomic) IBOutlet UIButton *left_3th_mid;
@property (strong, nonatomic) IBOutlet UIButton *left_3th_down;

@property (strong, nonatomic) IBOutlet UIButton *left_2th_up;
@property (strong, nonatomic) IBOutlet UIButton *left_2th_mid;
@property (strong, nonatomic) IBOutlet UIButton *left_2th_down;

@property (strong, nonatomic) IBOutlet UIButton *left_1th_up;
@property (strong, nonatomic) IBOutlet UIButton *left_1th_down;


@property (strong, nonatomic) IBOutlet UIButton *right_5th_up;
@property (strong, nonatomic) IBOutlet UIButton *right_5th_mid;
@property (strong, nonatomic) IBOutlet UIButton *right_5th_down;


@property (strong, nonatomic) IBOutlet UIButton *right_4th_up;
@property (strong, nonatomic) IBOutlet UIButton *right_4th_mid;
@property (strong, nonatomic) IBOutlet UIButton *right_4th_down;

@property (strong, nonatomic) IBOutlet UIButton *right_3th_up;
@property (strong, nonatomic) IBOutlet UIButton *right_3th_mid;
@property (strong, nonatomic) IBOutlet UIButton *right_3th_down;

@property (strong, nonatomic) IBOutlet UIButton *right_2th_up;
@property (strong, nonatomic) IBOutlet UIButton *right_2th_mid;
@property (strong, nonatomic) IBOutlet UIButton *right_2th_down;

@property (strong, nonatomic) IBOutlet UIButton *right_1th_up;
@property (strong, nonatomic) IBOutlet UIButton *right_1th_down;


@property (strong, nonatomic) NSMutableDictionary *all;
@property (strong, nonatomic) NSArray *buttons_text;
@property (strong, nonatomic) NSArray *buttons_self;


- (IBAction)toggleMenu:(id)sender;

@end
