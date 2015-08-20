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

@interface AddMedicationViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource,UIPickerViewDelegate, UIImagePickerControllerDelegate>
//selected UIImage
@property (strong, nonatomic) UIImage *selected_UIImage;
//picture took for drug
@property (strong, nonatomic) NSString *image_filename;

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
@property (strong, nonatomic) IBOutlet UIButton *add_photo_btn;

//steppers
@property (strong, nonatomic) IBOutlet UIStepper *days_of_treatment_stepper;
@property (strong, nonatomic) IBOutlet UIStepper *times_per_day_stepper;
//steppers' actions
- (IBAction)days_of_treatment_action:(UIStepper*)sender;
- (IBAction)times_per_day_action:(UIStepper *)sender;
//scrollview
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
//images
@property (strong, nonatomic) IBOutlet UIImageView *drug_image;

//button actions
- (IBAction)submit_action:(id)sender;
- (IBAction)add_photo_action:(id)sender;


@end
