//
//  NewEventFormViewController.m
//  RATracking
//
//  Created by Yu Song on 8/7/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "NewEventFormViewController.h"

@implementation NewEventFormViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self loadMyDrugs];
    [self initControls];
}
- (IBAction)submit_action:(id)sender {
    if (![self validateUserInputs])
        return;
    [[AdverseEventReporting getAFManager] POST:[SERVER_URL stringByAppendingString:@"adverse_event_reportings"] parameters:@{@"adverse_event_reporting": @{@"drug_id": self.selected_drug_id, @"patient_id": patient_id, @"side_effects": self.event_name.text, @"notes": self.notes.text, @"created_at": [JSONHandler NSDateToString:[NSDate date]]}} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self showAlert:@"Report success" withMessage:@"Adverse event submitted success!"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma validation of user inputs
-(BOOL)validateUserInputs{
    if ([[self trim: self.med_name.text] length] == 0) {
        [self showAlert:@"Medication cannot be blank" withMessage:@"Medication name cannot be blank!"];
        return NO;
    }
    else if([[self trim: self.event_name.text] length] == 0){
        [self showAlert:@"Event name cannot be blank" withMessage:@"Event name cannot be blank!"];
        return NO;
    }
    return YES;
}

#pragma load the drugs that currently taking
-(void)loadMyDrugs{
    [[Medication getAFManager] GET:[SERVER_URL stringByAppendingString:@"medications"] parameters:@{@"patient_id": patient_id} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *res_arr = (NSMutableArray *)responseObject;
        NSMutableDictionary *tmp_dic = [[NSMutableDictionary alloc] init];
        for(NSDictionary *obj in res_arr){
            tmp_dic[obj[@"drug_name"]] = @1;
        }
        self.med_arr = [tmp_dic allKeys];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {}];
}

#pragma init controls
-(void)initControls{
    self.title = @"New adverse event";
    //pickers
    self.med_picker = [[UIPickerView alloc] init];self.event_name_picker = [[UIPickerView alloc] init];
    self.med_picker.delegate = self;self.event_name_picker.delegate = self;
    self.med_picker.dataSource = self;self.event_name_picker.dataSource = self;
    self.med_picker.showsSelectionIndicator = YES;self.event_name_picker.showsSelectionIndicator = YES;
    UIBarButtonItem *med_name_done_button = [[UIBarButtonItem alloc]
                                             initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                             target:self action:@selector(done_for_med_name:)];
    UIBarButtonItem *route_name_done_button = [[UIBarButtonItem alloc]
                                               initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                               target:self action:@selector(done_for_event_name:)];
    UIToolbar *medNametoolBar = [[UIToolbar alloc]initWithFrame:
                                 CGRectMake(0, self.view.frame.size.height-
                                            self.med_picker.frame.size.height-50, 320, 50)];
    UIToolbar *routeNametoolBar = [[UIToolbar alloc]initWithFrame:
                                   CGRectMake(0, self.view.frame.size.height-
                                              self.event_name_picker.frame.size.height-50, 320, 50)];
    
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
    self.event_name.inputView = self.event_name_picker;
    self.event_name.inputAccessoryView = routeNametoolBar;
    self.med_name.delegate = self;
    self.event_name.delegate = self;
}

#pragma mark - Text field delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([self.event_name isEqual:textField]) {
        
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.med_name isEqual: textField]) {
        NSDictionary *drug_dic = [Medication getDrugIdByDrugName: self.med_name.text];;
        self.selected_drug_id = [drug_dic[@"drug_id"] stringValue];
        
        NSDictionary *side_effects_dic = [Medication medicationsShow: self.selected_drug_id];
        self.event_arr = [[side_effects_dic objectForKey:@"side_effects"] componentsSeparatedByString:@","];
    }
}

#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if ([self.med_picker isEqual: pickerView]){
        return [self.med_arr count];
    }
    else return [self.event_arr count];
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component{
    //[myTextField setText:[pickerArray objectAtIndex:row]];
    if ([self.med_picker isEqual: pickerView]){
        [self.med_name setText: self.med_arr[row]];
    }
    else [self.event_name setText: self.event_arr[row]];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row forComponent:(NSInteger)component{
    if ([self.med_picker isEqual: pickerView])
        return [self.med_arr objectAtIndex:row];
    else return [self.event_arr objectAtIndex:row];
    
}

-(IBAction)done_for_med_name: (UIBarButtonItem*)btn{
    [self.med_name resignFirstResponder];
}
-(IBAction)done_for_event_name: (UIBarButtonItem*)btn{
    [self.event_name resignFirstResponder];
}
@end
