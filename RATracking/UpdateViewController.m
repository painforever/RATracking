//
//  UpdateViewController.m
//  RATracking
//
//  Created by Yu Song on 9/22/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "UpdateViewController.h"
@interface UpdateViewController()
//all left views
@property (weak, nonatomic) UIImageView *emailIcon;
@property (weak, nonatomic) UIImageView *passIcon;
@property (weak, nonatomic) UIImageView *confirmIcon;

@property (weak, nonatomic) UIView *emailContainer;
@property (weak, nonatomic) UIView *passContainer;
@property (weak, nonatomic) UIView *confirmContainer;

@end
@implementation UpdateViewController
-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)viewDidLoad{
    self.email.leftView = [self setLeftViewForTextfields:@"envelope.png" withContainerScale:45 withImageIconScale:24 withUITextField:self.email];
    self.old_password.leftView = [self setLeftViewForTextfields:@"account.png" withContainerScale:45 withImageIconScale:24 withUITextField:self.old_password];
    self.neo_password.leftView = [self setLeftViewForTextfields:@"settings.png" withContainerScale:45 withImageIconScale:24 withUITextField:self.neo_password];
    self.password_confirm.leftView = [self setLeftViewForTextfields:@"settings.png" withContainerScale:45 withImageIconScale:24 withUITextField:self.password_confirm];
    self.email.text = [File readFileByName: REMEMBERED_EMAIL_FILENAME];
}

- (IBAction)update_action:(id)sender {
    if (![self validateUserInput])
        return;
    
    [[User getAFManager] POST:[SERVER_URL stringByAppendingString:@"users/update_password"] parameters:@{@"user_id": user_id, @"new_password": self.neo_password.text, @"email": self.email.text} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self showAlert:@"Update success" withMessage:@"Update success!"];
        [self resetLocalFile:self.email.text withPassword: self.neo_password.text];
        self.old_password.text = @"";
        self.neo_password.text = @"";
        self.password_confirm.text = @"";
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed");
    }];
}

-(BOOL)validateUserInput{
    NSArray *inputs = @[self.email, self.old_password, self.neo_password, self.password_confirm];
    for (UITextField *input in inputs) {
        if ([[self trim: input.text] length] == 0) {
            NSString *alert_msg = [NSString stringWithFormat:@"%@ cannot be blank.", input.placeholder];
            [self showAlert: alert_msg withMessage:alert_msg];
            return NO;
        }
    }
    
    //validate old password
    NSString *previous_pass = [File readFileByName: REMEMBERED_PASS_FILENAME];
    if (![previous_pass isEqualToString: self.old_password.text]) {
        [self showAlert:@"Password is not correct as the previous one!" withMessage:@"Please make sure to input the correct previous password."];
        return NO;
    }
    //validate password confirm
    if (![self.neo_password.text isEqualToString: self.password_confirm.text]) {
        [self showAlert:@"Password does not match!" withMessage:@"Please make sure that 2 passwords are same!"];
        return NO;
    }
    return YES;
}


@end
