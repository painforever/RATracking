//
//  AddMedicationViewController.h
//  RATracking
//
//  Created by Yu Song on 8/4/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Manifest.h"

@interface AddMedicationViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource,UIPickerViewDelegate>
//Pickers
@property (strong, nonatomic) UIPickerView *med_picker;
@property (strong, nonatomic) UIPickerView *med_route_name;
//text fields
@property (strong, nonatomic) IBOutlet UITextField *med_name;
@property (strong, nonatomic) IBOutlet UITextField *route_name;
@property (strong, nonatomic) IBOutlet UITextField *dosage;
@property (strong, nonatomic) IBOutlet UITextField *days_of_treatment;
@property (strong, nonatomic) IBOutlet UITextField *times_per_day;
@property (strong, nonatomic) IBOutlet UITextField *times;

//buttons
@property (strong, nonatomic) IBOutlet UIButton *med_name_done;
@property (strong, nonatomic) IBOutlet UIButton *route_name_done;
@property (strong, nonatomic) IBOutlet UIButton *time_done;
@property (strong, nonatomic) IBOutlet UIButton *submit;

//steppers
@property (strong, nonatomic) IBOutlet UIStepper *days_of_treatment_stepper;
@property (strong, nonatomic) IBOutlet UIStepper *times_per_day_stepper;
//steppers' actions
- (IBAction)days_of_treatment_action:(id)sender;
- (IBAction)times_per_day_action:(id)sender;

//button actions
- (IBAction)med_name_done_action:(id)sender;
- (IBAction)route_name_done_action:(id)sender;
- (IBAction)times_done_action:(id)sender;
- (IBAction)submit_action:(id)sender;


@end
