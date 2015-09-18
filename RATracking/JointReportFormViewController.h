//
//  JointReportFormViewController.h
//  RATracking
//
//  Created by Yu Song on 8/17/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+SharedUIMethods.h"
#import "Manifest.h"

@interface JointReportFormViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISlider *tender_slider;
@property (strong, nonatomic) IBOutlet UISlider *swollen_slider;
@property (strong, nonatomic) IBOutlet UISlider *pain_slider;

@property (strong, nonatomic) IBOutlet UILabel *tender_label;
@property (strong, nonatomic) IBOutlet UILabel *swollen_label;
@property (strong, nonatomic) IBOutlet UILabel *pain_label;


//non control
@property (strong, nonatomic) NSString *selected_part;

- (IBAction)tender_value_changed:(UISlider*)sender;
- (IBAction)swollen_value_changed:(UISlider*)sender;
- (IBAction)pain_value_changed:(UISlider*)sender;
- (IBAction)submit_action:(id)sender;
@end
