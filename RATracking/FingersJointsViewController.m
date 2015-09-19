//
//  FingersJointsViewController.m
//  RATracking
//
//  Created by Yu Song on 9/17/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "FingersJointsViewController.h"

@interface FingersJointsViewController ()

@end

@implementation FingersJointsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initControls];
    [self setUpCWPopUp];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)actionsInJoint{
    REMenuItem *joint = [[REMenuItem alloc] initWithTitle:@"Report pain of joints"
                                                 subtitle:@"Let us know your pain of all kinds of joints anytime."
                                                    image:[UIImage imageNamed:@"Icon_Home"]
                                         highlightedImage:nil
                                                   action:^(REMenuItem *item) {
                                                       NSLog(@"Item: %@", item);
                                                       JointReportFormViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"JointReportFormViewController"];
                                                       view.view.frame = CGRectMake(0, 0, self.view.frame.size.width-50, self.view.frame.size.height-150);
                                                       if ([self.selected_part isEqualToString:@""]) {
                                                           [self showAlert:@"no body part selected." withMessage:@"You have to select a part of your hand."];
                                                           return;
                                                       }
                                                       view.selected_part = self.selected_part;
                                                       [self presentPopupViewController:view animated:YES completion:nil];
                                                   }];
    return @[joint];
}

-(void)initControls{
    self.selected_part = @"";
    self.menu = [[REMenu alloc] initWithItems:[self actionsInJoint]];
    self.all = @{@"left_5th_up": self.left_5th_up, @"left_5th_mid": self.left_5th_mid, @"left_5th_down": self.left_5th_down,
                       @"left_4th_up": self.left_4th_up, @"left_4th_mid": self.left_4th_mid, @"left_4th_down": self.left_4th_down,
                       @"left_3th_up": self.left_3th_up, @"left_3th_mid": self.left_3th_mid, @"left_3th_down": self.left_3th_down,
                       @"left_2th_up": self.left_2th_up, @"left_2th_mid": self.left_2th_mid, @"left_2th_down": self.left_2th_down,
                       @"left_1th_up": self.left_1th_up, @"left_1th_down": self.left_1th_down,
                       @"right_5th_up": self.right_5th_up, @"right_5th_mid": self.right_5th_mid, @"right_5th_down": self.right_5th_down,
                       @"right_4th_up": self.right_4th_up, @"right_4th_mid": self.right_4th_mid, @"right_4th_down": self.right_4th_down,
                       @"right_3th_up": self.right_3th_up, @"right_3th_mid": self.right_3th_mid, @"right_3th_down": self.right_3th_down,
                       @"right_2th_up": self.right_2th_up, @"right_2th_mid": self.right_2th_mid, @"right_2th_down": self.right_2th_down,
                       @"right_1th_up": self.right_1th_up, @"right_1th_down": self.right_1th_down};
    self.buttons_text = [self.all allKeys];
    self.buttons_self = [self.all allValues];
    
    int i=0;
    for (UIButton *btn in self.buttons_self) {
        btn.tag = i;
        [btn addTarget:self action:@selector(onClick:) forControlEvents: UIControlEventTouchUpInside];
        i+=1;
    }
}

-(IBAction)onClick:(id)sender{
    UIButton *clicked_button = (UIButton *)sender;
    self.selected_part = self.buttons_text[clicked_button.tag];
    //hight the selected part
    [self changeAllOtherButtonsColor: clicked_button];
}

- (IBAction)toggleMenu:(id)sender {
    if (self.menu.isOpen)
        return [self.menu close];
    [self.menu showFromNavigationController:self.navigationController];
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

-(void)changeAllOtherButtonsColor:(UIButton*)clickedBtn{
    [clickedBtn setBackgroundImage:[UIImage imageNamed:@"Yellow_icon.svg.png"] forState: UIControlStateNormal];
    for(UIButton *btn in self.buttons_self){
        if (clickedBtn.tag != btn.tag) {
            [btn setBackgroundImage:[UIImage imageNamed:@"red_button.png"] forState:UIControlStateNormal];
        }
    }
}
@end
