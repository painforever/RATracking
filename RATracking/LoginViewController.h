//
//  LoginViewController.h
//  RATracking
//
//  Created by Yu Song on 7/28/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+SharedUIMethods.h"
#import "RxTableViewController.h"
#import "Manifest.h"
#import "AppDelegate.h"
#import "SignUpViewController.h"
#import "File.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *password;

@property (strong, nonatomic) IBOutlet UIButton *signup_btn;
@property (strong, nonatomic) IBOutlet UIButton *login_btn;
@property (weak, nonatomic) IBOutlet UISwitch *switcher;

- (IBAction)login_action:(id)sender;
- (IBAction)signup_action:(id)sender;
- (IBAction)switcher_value_changed:(id)sender;
@end
