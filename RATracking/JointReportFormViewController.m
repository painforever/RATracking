//
//  JointReportFormViewController.m
//  RATracking
//
//  Created by Yu Song on 8/17/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "JointReportFormViewController.h"

@implementation JointReportFormViewController

-(void)viewDidLoad{
    [super viewDidLoad];
}
- (IBAction)tender_value_changed:(UISlider *)sender {
    NSString *changed_value = [NSString stringWithFormat:@"%d", (int)sender.value];
    self.tender_label.text = [NSString stringWithFormat:@"%@", changed_value];
}

- (IBAction)swollen_value_changed:(UISlider*)sender {
    NSString *changed_value = [NSString stringWithFormat:@"%d", (int)sender.value];
    self.swollen_label.text = [NSString stringWithFormat:@"%@", changed_value];
}

- (IBAction)pain_value_changed:(UISlider*)sender {
    NSString *changed_value = [NSString stringWithFormat:@"%d", (int)sender.value];
    self.pain_label.text = [NSString stringWithFormat:@"%@", changed_value];
}

- (IBAction)submit_action:(id)sender {
    [[User getAFManager] POST:[SERVER_URL stringByAppendingString:@"patients/joint_report"] parameters:@{@"part": self.selected_part, @"tender": self.tender_label.text, @"swollen": self.swollen_label.text, @"pain": self.pain_label.text, @"patient_id": patient_id} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self showAlert:@"submit success" withMessage:@"Submit joint report success!"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self showAlert:@"submit failed" withMessage:@"Submit joint report failed!"];
    }];
}
@end
