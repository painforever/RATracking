//
//  Constants.h
//  RATracking
//
//  Created by Yu Song on 7/28/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject
extern NSString *SERVER_URL;
extern NSString *user_id;
extern NSString *patient_id;
extern NSString *full_name;
extern NSString *BASE_URL;

//non control properties
extern NSArray *med_name_arr;
extern NSArray *route_name_arr;

//url for upload photos for drugs
extern NSString * photo_upload_url;
@end
