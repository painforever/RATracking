//
//  JointViewController.m
//  RATracking
//
//  Created by Yu Song on 8/4/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "JointViewController.h"

@implementation JointViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initControls];
    [self setUpCWPopUp];
}

#pragma menu for left top
- (IBAction)toggleMenu: (id)sender
{
    if (self.menu.isOpen)
        return [self.menu close];
    [self.menu showFromNavigationController:self.navigationController];
}

- (IBAction)actions_action:(id)sender {
    [self quickStart];
}

#pragma mark App JKPopMenuViewSelectDelegate
- (void)popMenuViewSelectIndex:(NSInteger)index{
    NSLog(@"%d", index);
}

-(void)initControls{
    [self.menu close];
    self.title = @"Joint Report";
    self.menu = [[REMenu alloc] initWithItems:[self actionsInJoint]];
    self.all_buttons = @[self.neck, self.left_shoulder, self.right_shoulder, self.left_arm_joint, self.right_arm_joint, self.left_hand, self.right_hand, self.left_root_leg, self.right_root_leg, self.left_leg_joint, self.right_leg_joint, self.left_feet, self.right_feet];
    int i = 0;
    for (UIButton *btn in self.all_buttons) {
        btn.tag = i;
        i+=1;
        [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
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
                                                       [self presentPopupViewController:view animated:YES completion:nil];
                                                   }];
    return @[joint];
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

-(IBAction)onClick:(id)sender{
    UIButton *btn = (UIButton*)sender;
    NSLog(@"btn: %d", [btn tag]);
    [self changeAllOtherButtonsColor:btn];
}

-(void)changeAllOtherButtonsColor:(UIButton*)clickedBtn{
    [clickedBtn setBackgroundImage:[UIImage imageNamed:@"Yellow_icon.svg.png"] forState: UIControlStateNormal];
    for(UIButton *btn in self.all_buttons){
        if (clickedBtn.tag != btn.tag) {
            [btn setBackgroundImage:[UIImage imageNamed:@"red_button.png"] forState:UIControlStateNormal];
        }
    }
}
@end
