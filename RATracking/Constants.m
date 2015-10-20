//
//  Constants.m
//  RATracking
//
//  Created by Yu Song on 7/28/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "Constants.h"

@implementation Constants

NSString * photo_upload_url=@"http://10.0.80.62:3000/ra/medications/upload_drug_photo";
NSString *BASE_URL = @"http://10.0.80.62:3000";
NSString *SERVER_URL = @"http://10.0.80.62:3000/ra/";


//NSString *BASE_URL = @"http://127.0.0.1:3000";
//NSString *SERVER_URL = @"http://127.0.0.1:3000/ra/";
//NSString * photo_upload_url=@"http://127.0.0.1:3000/ra/medications/upload_drug_photo";


NSString *user_id = @"";
NSString *full_name = @"";
NSString *patient_id = @"";

NSString *email = @"";
NSString *password = @"";

//non control properties
NSArray *med_name_arr;
NSArray *route_name_arr;




NSString *default_drug_photo = @"http://bipolarhappens.com/bhblog/wp-content/uploads/med-question6.gif";

NSString *REMEMBERED_EMAIL_FILENAME = @"email.txt";;
NSString *REMEMBERED_PASS_FILENAME = @"pass.txt";
NSString *REMEMBERED_USER_DATA = @"user_data.txt";
@end
