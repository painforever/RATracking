//
//  NewEventFormViewController.h
//  RATracking
//
//  Created by Yu Song on 8/7/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Manifest.h"
#import "UIViewController+SharedUIMethods.h"

@interface NewEventFormViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
@property (strong, nonatomic) IBOutlet UITextField *med_name;
@property (strong, nonatomic) IBOutlet UITextField *event_name;
@property (strong, nonatomic) IBOutlet UITextView *notes;

//Pickers
@property (strong, nonatomic) UIPickerView *med_picker;
@property (strong, nonatomic) UIPickerView *event_name_picker;

//datas
@property (strong, nonatomic) NSArray *med_arr;
@property (strong, nonatomic) NSArray *event_arr;
@property (strong, nonatomic) NSString *selected_drug_id;

@property (strong, nonatomic) IBOutlet UIButton *submit_btn;
- (IBAction)submit_action:(id)sender;
@end
