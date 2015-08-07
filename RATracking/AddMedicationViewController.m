
//
//  AddMedicationViewController.m
//  RATracking
//
//  Created by Yu Song on 8/4/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//
//http://bipolarhappens.com/bhblog/wp-content/uploads/med-question6.gif  default drug photo

#import "AddMedicationViewController.h"

@implementation AddMedicationViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initControls];
}
- (IBAction)days_of_treatment_action:(UIStepper *)sender {
    self.days_of_treatment.text = [NSString stringWithFormat:@"%d", (int)sender.value];
}

- (IBAction)times_per_day_action:(UIStepper *)sender {
    self.times_per_day.text = [NSString stringWithFormat:@"%d", (int)sender.value];
}

- (IBAction)submit_action:(id)sender {
    if (![self validateUserInputs])
        return;
    NSDictionary *drug = [Medication getDrugIdByDrugName: [self trim: self.med_name.text]];
    if (drug == nil) {
        [self showAlert:@"No such drug." withMessage:@"There no such drug."];
        return;
    }
    NSDictionary *param_to_post = [Medication constructParamsForRailsRESTCall: self.med_name.text withRouteName:self.route_name.text withDosage:self.dosage.text withDaysOfTreatment:self.days_of_treatment.text withTimesPerDay:self.times_per_day.text withTimes:self.times.text withDrugId: drug[@"drug_id"]];
    
    [Medication getAFManager].requestSerializer = [AFJSONRequestSerializer serializer];
    [[Medication getAFManager] POST:[SERVER_URL stringByAppendingString:@"patient_prescriptions"] parameters:param_to_post success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self showAlert:@"Medication added." withMessage:[NSString stringWithFormat:@"%@ add success!", self.med_name.text]];
        //clear all the inputs fields
        [self clearAllTextFields:@[self.med_name, self.route_name, self.dosage, self.days_of_treatment, self.times_per_day, self.times]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self showAlert:@"Medication add failed." withMessage:@"Medication add failed!"];
    }];
}

#pragma text field delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}
-(void)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
}

#pragma init controls
-(void)initControls{
    self.title = @"Add New Medication";
    //pickers
    self.med_picker = [[UIPickerView alloc] init];self.route_name_picker = [[UIPickerView alloc] init];
    self.med_picker.delegate = self;self.route_name_picker.delegate = self;
    self.med_picker.dataSource = self;self.route_name_picker.dataSource = self;
    self.med_picker.showsSelectionIndicator = YES;self.route_name_picker.showsSelectionIndicator = YES;
    UIBarButtonItem *med_name_done_button = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                   target:self action:@selector(done_for_med_name:)];
    UIBarButtonItem *route_name_done_button = [[UIBarButtonItem alloc]
                                             initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                             target:self action:@selector(done_for_route_name:)];
    UIToolbar *medNametoolBar = [[UIToolbar alloc]initWithFrame:
                          CGRectMake(0, self.view.frame.size.height-
                                     self.med_picker.frame.size.height-50, 320, 50)];
    UIToolbar *routeNametoolBar = [[UIToolbar alloc]initWithFrame:
                          CGRectMake(0, self.view.frame.size.height-
                                     self.route_name_picker.frame.size.height-50, 320, 50)];
    
    [medNametoolBar setBarStyle:UIBarStyleBlackOpaque];
    NSArray *medNametoolbarItems = [NSArray arrayWithObjects:
                             med_name_done_button, nil];
    [medNametoolBar setItems:medNametoolbarItems];
    
    [routeNametoolBar setBarStyle:UIBarStyleBlackOpaque];
    NSArray *routeNametoolbarItems = [NSArray arrayWithObjects:
                                    route_name_done_button, nil];
    [routeNametoolBar setItems:routeNametoolbarItems];
    
    //text fields
    self.med_name.inputView = self.med_picker;
    self.med_name.inputAccessoryView = medNametoolBar;
    self.route_name.inputView = self.route_name_picker;
    self.route_name.inputAccessoryView = routeNametoolBar;
    
    self.med_name.delegate = self;
    self.route_name.delegate = self;
    //steppers
    
}

#pragma mark - Text field delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
}
#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if ([self.med_picker isEqual: pickerView]){
        return [med_name_arr count];
    }
    else return [route_name_arr count];
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component{
    //[myTextField setText:[pickerArray objectAtIndex:row]];
    if ([self.med_picker isEqual: pickerView]){
        [self.med_name setText: med_name_arr[row]];
    }
    else [self.route_name setText: route_name_arr[row]];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row forComponent:(NSInteger)component{
    if ([self.med_picker isEqual: pickerView])
        return [med_name_arr objectAtIndex:row];
    else return [route_name_arr objectAtIndex:row];
    
}

-(IBAction)done_for_med_name: (UIBarButtonItem*)btn{
    [self.med_name resignFirstResponder];
}
-(IBAction)done_for_route_name: (UIBarButtonItem*)btn{
    [self.route_name resignFirstResponder];
}

#pragma input validations
-(BOOL)validateUserInputs{
    NSString *med_name_str = [self trim: self.med_name.text];
    NSString *route_name_str = [self trim: self.route_name.text];
    NSString *days_of_treatment_str = [self trim: self.days_of_treatment.text];
    NSString *times_per_day_str = [self trim: self.times_per_day.text];
    NSArray *times_array = [self.times.text componentsSeparatedByString:@","];
    if ([med_name_str length] == 0) {
        [self showAlert:@"Medication name." withMessage:@"Medication name cannot be blank!"];
        return NO;
    }
    else if([route_name_str length] == 0){
        [self showAlert:@"Route name." withMessage:@"Route Name cannot be blank!"];
        return NO;
    }
    else if([days_of_treatment_str isEqualToString:@"0"] || ![self isNnumber: days_of_treatment_str]){
        [self showAlert:@"Days of treatment." withMessage:@"Days of treatment input is invalid, please input integer numbers."];
        return NO;
    }
    else if([times_per_day_str isEqualToString:@"0"] || ![self isNnumber: times_per_day_str]){
        [self showAlert:@"Times per day." withMessage:@"Times per day input is invalid, please input integer numbers."];
        return NO;
    }
    else if([times_array count] != [times_per_day_str integerValue] || [self.times.text length] == 0){
        [self showAlert:@"Times does not match." withMessage:@"Times and treatment count does not match, The count of times you input here must be the same as 'Times per day'."];
        return NO;
    }
    return YES;
}
@end
