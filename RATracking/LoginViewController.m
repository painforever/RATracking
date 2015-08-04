//
//  LoginViewController.m
//  RATracking
//
//  Created by Yu Song on 7/28/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.email.delegate = self;
    self.password.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login_action:(id)sender {
//    [[User getAFManager] POST: [SERVER_URL stringByAppendingString:@"sessions"] parameters:@{@"email": self.email.text, @"password": self.password.text} success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if ([operation.response statusCode] == 201){
//            [self pushToViewControllerAlwaysWithNavBar: @"HomeViewController"];
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if ([operation.response statusCode] == 500) [self showAlert:@"Email/Password is wrong!" withMessage:@"Email or password is wrong!"];
//    }];
    //[self pushToViewControllerAlwaysWithNavBar: @"HomeViewController"];
    UITabBarController *tabBarController = [self.storyboard instantiateViewControllerWithIdentifier:@"tabBarController"];
    AppDelegate *ddd = [UIApplication sharedApplication].delegate;
    [ddd.window setRootViewController: tabBarController];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}

-(void)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
}
@end
