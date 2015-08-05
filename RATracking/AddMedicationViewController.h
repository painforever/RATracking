//
//  AddMedicationViewController.h
//  RATracking
//
//  Created by Yu Song on 8/4/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Manifest.h"
#import "UIViewController+SharedUIMethods.h"

@interface AddMedicationViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource,UIPickerViewDelegate>
//Pickers
@property (strong, nonatomic) UIPickerView *med_picker;
@property (strong, nonatomic) UIPickerView *route_name_picker;
//text fields
@property (strong, nonatomic) IBOutlet UITextField *med_name;
@property (strong, nonatomic) IBOutlet UITextField *route_name;
@property (strong, nonatomic) IBOutlet UITextField *dosage;
@property (strong, nonatomic) IBOutlet UITextField *days_of_treatment;
@property (strong, nonatomic) IBOutlet UITextField *times_per_day;
@property (strong, nonatomic) IBOutlet UITextField *times;

//buttons
@property (strong, nonatomic) IBOutlet UIButton *submit;

//steppers
@property (strong, nonatomic) IBOutlet UIStepper *days_of_treatment_stepper;
@property (strong, nonatomic) IBOutlet UIStepper *times_per_day_stepper;
//steppers' actions
- (IBAction)days_of_treatment_action:(UIStepper*)sender;
- (IBAction)times_per_day_action:(UIStepper *)sender;

//button actions
- (IBAction)submit_action:(id)sender;


@end
