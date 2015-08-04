
//
//  AddMedicationViewController.m
//  RATracking
//
//  Created by Yu Song on 8/4/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "AddMedicationViewController.h"

@implementation AddMedicationViewController

- (IBAction)days_of_treatment_action:(id)sender {
}

- (IBAction)times_per_day_action:(id)sender {
}
- (IBAction)med_name_done_action:(id)sender {
}

- (IBAction)route_name_done_action:(id)sender {
}

- (IBAction)times_done_action:(id)sender {
}

- (IBAction)submit_action:(id)sender {
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
    self.med_picker = [[UIPickerView alloc] init];
    self.med_picker.delegate = self;
    self.med_picker.dataSource = self;
    self.med_picker.showsSelectionIndicator = YES;
}

#pragma mark - Text field delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
}
#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView == self.med_picker){
        return [med_name_arr count];
    }
    else return [route_name_arr count];
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    //[myTextField setText:[pickerArray objectAtIndex:row]];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    return [med_name_arr objectAtIndex:row];
    
}
@end
