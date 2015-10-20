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
    [self setUpCWPopUp];
    [self styleLoginControls];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login_action:(id)sender {
    [[User getAFManager] POST: [SERVER_URL stringByAppendingString:@"sessions"] parameters:@{@"email": self.email.text, @"password": self.password.text} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([operation.response statusCode] == 201){
            NSDictionary *res_dic = (NSDictionary *)responseObject;
            [self assignAllConstants:res_dic];
            if (self.switcher.on) {
                [self storeAccount];
            }
            UITabBarController *tabBarController = [self.storyboard instantiateViewControllerWithIdentifier:@"tabBarController"];
            AppDelegate *ddd = [UIApplication sharedApplication].delegate;
            [ddd.window setRootViewController: tabBarController];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([operation.response statusCode] == 500) [self showAlert:@"Email/Password is wrong!" withMessage:@"Email or password is wrong!"];
    }];
    
    med_name_arr = @[@"Abatacept", @"Etanercept", @"Tofacitinib", @"Adalimumab", @"Rituximab", @"Golimumab", @"Infliximab", @"Anakinra", @"Tocilizumab"];
    route_name_arr = @[@"ORAL", @"SHOOT"];
    
//    UITabBarController *tabBarController = [self.storyboard instantiateViewControllerWithIdentifier:@"tabBarController"];
//    AppDelegate *ddd = [UIApplication sharedApplication].delegate;
//    [ddd.window setRootViewController: tabBarController];
}

- (IBAction)signup_action:(id)sender {
    SignUpViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    view.view.frame = CGRectMake(0, 0, self.view.frame.size.width-50, self.view.frame.size.height-150);
    [self presentPopupViewController:view animated:YES completion:nil];
    
}

- (IBAction)switcher_value_changed:(id)sender {
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}

-(void)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
}

//assign Constants
-(void)assignAllConstants: (NSDictionary *)dic{
    patient_id = dic[@"patient_id"];
    user_id = dic[@"user_id"];
    full_name = [NSString stringWithFormat:@"%@ %@", dic[@"fname"], dic[@"lname"]];
}

//CWPopup
-(void)setUpCWPopUp{
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopup)];
    tapRecognizer.numberOfTapsRequired = 2;
    tapRecognizer.delegate = self;
    self.useBlurForPopup = YES;
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)dismissPopup {
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{}];
    }
}

#pragma styles for controls
-(void)styleLoginControls{
    UIImageView* usernameIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    usernameIconImage.image = [UIImage imageNamed:@"envelope.png"];
    UIView* usernameIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    usernameIconContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [usernameIconContainer addSubview:usernameIconImage];
    
    UIImageView *passwordIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    passwordIconImage.image = [UIImage imageNamed:@"account.png"];
    UIView *passwordIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    passwordIconContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [passwordIconContainer addSubview: passwordIconImage];
    
    self.email.leftViewMode = UITextFieldViewModeAlways;
    self.email.leftView = usernameIconContainer;
    self.password.leftViewMode = UITextFieldViewModeAlways;
    self.password.leftView = passwordIconContainer;
}

#pragma methods for remembering password

//this method must be called after userDefault data synced
-(void)storeAccount{
    if (![File fileExistsByName: REMEMBERED_EMAIL_FILENAME]) {
        [File deleteFileByName:REMEMBERED_EMAIL_FILENAME];
        [File deleteFileByName:REMEMBERED_PASS_FILENAME];
        [File deleteFileByName:REMEMBERED_USER_DATA];
    }
    [File createFileByName: REMEMBERED_EMAIL_FILENAME];[File writeToFileByName: REMEMBERED_EMAIL_FILENAME withContent: self.email.text];
    [File createFileByName: REMEMBERED_PASS_FILENAME];[File writeToFileByName: REMEMBERED_PASS_FILENAME withContent: self.password.text];
    NSArray *user_data_arr = @[user_id, patient_id, full_name];
    [File createFileByName: REMEMBERED_USER_DATA];[File writeToFileByName: REMEMBERED_USER_DATA withContent: [user_data_arr componentsJoinedByString:@","]];
}
@end
