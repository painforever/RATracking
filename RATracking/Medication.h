//
//  Medication.h
//  RATracking
//
//  Created by Yu Song on 8/5/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Manifest.h"

@interface Medication : NSObject

+(NSMutableArray *)getMyMedications: (NSString *)patient_id;
//construct params for Rails REST to call
+(NSDictionary *)constructParamsForRailsRESTCall:(NSString *)med_name withRouteName:(NSString *)route_name withDosage:(NSString *)dosage withDaysOfTreatment:(NSString *)days_of_treatment withTimesPerDay:(NSString *)times_per_day withTimes: (NSString *)times;

//get drug_id by drug_name
+(NSDictionary *)getDrugNameByDrugId:(NSString *)drug_name;
@end
