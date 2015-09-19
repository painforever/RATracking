//
//  BackJointViewController.h
//  RATracking
//
//  Created by Yu Song on 9/17/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+SharedUIMethods.h"

@interface BackJointViewController : UIViewController <JKPopMenuViewSelectDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *bodyImageView;
@property (strong, nonatomic) IBOutlet UIButton *up;
@property (strong, nonatomic) IBOutlet UIButton *mid;
@property (strong, nonatomic) IBOutlet UIButton *down;

@property (strong, readwrite, nonatomic) REMenu *menu;
@property (strong, nonatomic) NSString *selected_part;
@property (strong, nonatomic) IBOutlet UIButton *actions_btn;

@property (strong, nonatomic) NSArray *buttons;
@property (strong, nonatomic) NSArray *parts_text;

- (IBAction)toggleMenu:(id)sender;
@end
