
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
    NSLog(@"days of treatmentsd: %@",self.days_of_treatment.text);
    [[Medication getAFManager] POST:[SERVER_URL stringByAppendingString:@"patient_prescriptions"] parameters:param_to_post success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self showAlert:@"Medication added." withMessage:[NSString stringWithFormat:@"%@ add success!", self.med_name.text]];
        NSDictionary *added_drug_dic = (NSDictionary *)responseObject;
        //upload drug photo
        [self uploadAvatar:self.selected_UIImage withFileName: self.image_filename withPrescriptionItemID: added_drug_dic[@"prescription_item_id"]];
        
        //start to schedule notifications
        [self scheduleReminders: self.days_of_treatment.text withTimes: [self.times.text componentsSeparatedByString:@","]];
        
        //clear all the inputs fields
        [self clearAllTextFields:@[self.med_name, self.route_name, self.dosage, self.days_of_treatment, self.times_per_day, self.times]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self showAlert:@"Medication add failed." withMessage:@"Medication add failed!"];
    }];
}

- (IBAction)add_photo_action:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:NULL];
    }
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
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(400, self.view.frame.size.height+400)];
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
    self.dosage.delegate = self;
    self.days_of_treatment.delegate = self;
    self.times_per_day.delegate = self;
    self.times.delegate = self;
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

#pragma Camera
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    NSURL *url = [NSURL URLWithString: photo_upload_url];
    // And dismiss the image picker.
    [self dismissViewControllerAnimated:TRUE completion:nil];
    NSString *filename = [NSString stringWithFormat:@"%@.jpg", [JSONHandler md5:[JSONHandler microtime]]];
    self.selected_UIImage = chosenImage;
    self.image_filename = filename;
    //display image on GUI
    self.drug_image.image = chosenImage;
    NSLog(@"take photo finished!");
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void)uploadAvatar: (UIImage *)file_data withFileName: (NSString *)filename withPrescriptionItemID: (NSString *)item_id{
    NSData* imageData =  UIImageJPEGRepresentation(file_data, 1.0);
    // NSData *imageData   = [NSData dataWithContentsOfFile:filename];
    NSString *urlString = photo_upload_url;

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = [NSString stringWithFormat:@"Boundary-%@",[[NSUUID UUID] UUIDString]];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"item_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *userid = [NSString stringWithFormat:@"%@",item_id];
    [body appendData:[userid dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"drug_photo\"; filename=\"%@\"\r\n", filename]] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
}

-(void)scheduleReminders: (NSString *)days withTimes: (NSArray *)times_arr{
    int treatment_days = [days intValue];
    for (int i = 0; i < treatment_days; i++) {
        for (int j = 0; j < [times_arr count]; j++) {
            NSDate *date = [self getEntireFormattedDateByAppendingTime: times_arr[j]];
            NSLog(@"date: %@", [times_arr description]);
            //we assume that the start of taking the drug will be the day after the patient scheduling
            NSDateComponents *components= [[NSDateComponents alloc] init];
            [components setDay:i];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDate *dateIncremented= [calendar dateByAddingComponents:components toDate:date options:0];
            //start to init the Notifications
            UILocalNotification *notification = [[UILocalNotification alloc]init];
            notification.repeatInterval = NSDayCalendarUnit;
            NSString *alert_msg = [NSString stringWithFormat:@"It's time to take %@.", self.med_name.text];
            [notification setAlertBody: alert_msg];
            [notification setFireDate: dateIncremented];
            [notification setTimeZone:[NSTimeZone  defaultTimeZone]];
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        }
    }
}
@end
