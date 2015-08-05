//
//  Medication.m
//  RATracking
//
//  Created by Yu Song on 8/5/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "Medication.h"

@implementation Medication

+(NSMutableArray *)getMyMedications:(NSString *)patient_id{
    NSMutableArray *res = [[NSMutableArray alloc] init];
    NSString *params = [NSString stringWithFormat:@"patient_id=%@", patient_id];
    NSString *result_str = [Get getRequest:[SERVER_URL stringByAppendingString:@"medications/?"] withParams: params];
    NSMutableArray *result_arr = [NSJSONSerialization JSONObjectWithData:[JSONHandler StringToData:result_str] options:NSJSONReadingMutableContainers error:nil];
    return result_arr;
}

+(NSDictionary*)constructParamsForRailsRESTCall:(NSString *)med_name withRouteName:(NSString *)route_name withDosage:(NSString *)dosage withDaysOfTreatment:(NSString *)days_of_treatment withTimesPerDay:(NSString *)times_per_day withTimes:(NSString *)times{
    
    NSMutableDictionary *res_dic = [[NSMutableDictionary alloc] initWithObjects:@"" forKeys:@"patient_prescription"];
    [res_dic setObject:@"" forKey:@"patient_prescription_item"];
    
    return nil;
}

+(NSDictionary *)getDrugNameByDrugId:(NSString *)drug_name{
    
}
@end
