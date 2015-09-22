//
//  UpdateViewController.h
//  RATracking
//
//  Created by Yu Song on 9/22/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+SharedUIMethods.h"
#import "File.h"
#import "Manifest.h"

@interface UpdateViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *old_password;
@property (weak, nonatomic) IBOutlet UITextField *neo_password;
@property (weak, nonatomic) IBOutlet UITextField *password_confirm;
@property (weak, nonatomic) IBOutlet UIButton *update_btn;


- (IBAction)update_action:(id)sender;
@end
