//
//  BackJointViewController.m
//  RATracking
//
//  Created by Yu Song on 9/17/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "BackJointViewController.h"

@interface BackJointViewController ()

@end

@implementation BackJointViewController

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

-(void)initControls{
    self.selected_part = @"";
    self.up.layer.cornerRadius = 10.0f;
    self.mid.layer.cornerRadius = 10.0f;
    self.down.layer.cornerRadius = 10.0f;
    self.menu = [[REMenu alloc] initWithItems:[self actionsInJoint]];
    self.buttons = @[self.up, self.mid, self.down];
    self.parts_text = @[@"back_up", @"back_mid", @"back_down"];
    int i = 0;
    for (UIButton *btn in self.buttons) {
        btn.tag = i;
        i+=1;
        [btn addTarget:self action:@selector(onClick:) forControlEvents: UIControlEventTouchUpInside];
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
                                                       if ([self.selected_part isEqualToString:@""]) {
                                                           [self showAlert:@"no body part selected." withMessage:@"You have to select a part of your body."];
                                                           return;
                                                       }
                                                       view.selected_part = self.selected_part;
                                                       [self presentPopupViewController:view animated:YES completion:nil];
                                                   }];
    return @[joint];
}

- (IBAction)toggleMenu:(id)sender {
    if (self.menu.isOpen)
        return [self.menu close];
    [self.menu showFromNavigationController:self.navigationController];
}

-(IBAction)onClick:(id)sender{
    UIButton *clicked_btn = (UIButton *)sender;
    self.selected_part = self.parts_text[clicked_btn.tag];
    [self changeAllOtherButtonsColor: clicked_btn];
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
    [clickedBtn setBackgroundColor: [UIColor yellowColor]];
    [clickedBtn setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    for(UIButton *btn in self.buttons){
        if (clickedBtn.tag != btn.tag) {
            [btn setBackgroundColor: [UIColor redColor]];
            [btn setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}
@end
