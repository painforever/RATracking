//
//  Medication.m
//  RATracking
//
//  Created by Yu Song on 8/5/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "Medication.h"

static AFHTTPRequestOperationManager *manager = nil;

@implementation Medication

+(AFHTTPRequestOperationManager*)getAFManager{
    if(manager==nil)
        manager=[AFHTTPRequestOperationManager manager];
    return manager;
}

+(NSMutableArray *)getMyMedications:(NSString *)patient_id{
    NSMutableArray *res = [[NSMutableArray alloc] init];
    NSString *params = [NSString stringWithFormat:@"patient_id=%@", patient_id];
    NSString *result_str = [Get getRequest:[SERVER_URL stringByAppendingString:@"medications/?"] withParams: params];
    NSMutableArray *result_arr = [NSJSONSerialization JSONObjectWithData:[JSONHandler StringToData:result_str] options:NSJSONReadingMutableContainers error:nil];
    return result_arr;
}

+(NSDictionary*)constructParamsForRailsRESTCall:(NSString *)med_name withRouteName:(NSString *)route_name withDosage:(NSString *)dosage withDaysOfTreatment:(NSString *)days_of_treatment withTimesPerDay:(NSString *)times_per_day withTimes:(NSString *)times withDrugId:(NSString *)drug_id{
    
    NSMutableDictionary *res_dic = [[NSMutableDictionary alloc] initWithObjects:@"" forKeys:@"patient_prescription"];
    [res_dic setObject:@"" forKey:@"patient_prescription_item"];
    
    return nil;
}

+(NSDictionary *)getDrugIdByDrugName:(NSString *)drug_name{
    NSString *params = [NSString stringWithFormat:@"drug_name=%@", drug_name];
    NSString *res_str = [Get getRequest:[SERVER_URL stringByAppendingString:@"medications/find_by_drug_name"] withParams: params];
    if([res_str isEqualToString:@"failed"]) return nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:[JSONHandler StringToData:res_str] options:NSJSONReadingMutableContainers error:nil];
    return res;
}
@end
