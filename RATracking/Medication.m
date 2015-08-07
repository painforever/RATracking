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

//+(NSMutableArray *)getMyMedications:(NSString *)patient_id{
//    NSMutableArray *res = [[NSMutableArray alloc] init];
//    NSString *params = [NSString stringWithFormat:@"patient_id=%@", patient_id];
//    NSString *result_str = [Get getRequest:[SERVER_URL stringByAppendingString:@"medications/?"] withParams: params];
//    NSMutableArray *result_arr = [NSJSONSerialization JSONObjectWithData:[JSONHandler StringToData:result_str] options:NSJSONReadingMutableContainers error:nil];
//    return result_arr;
//}

+(NSDictionary*)constructParamsForRailsRESTCall:(NSString *)med_name withRouteName:(NSString *)route_name withDosage:(NSString *)dosage withDaysOfTreatment:(NSString *)days_of_treatment withTimesPerDay:(NSString *)times_per_day withTimes:(NSString *)times withDrugId:(NSString *)drug_id{
    
    NSMutableDictionary *res_dic = [[NSMutableDictionary alloc] initWithObjects:@[@"", @""] forKeys:@[@"patient_prescription", @"patient_prescription_item"]];
    
    [res_dic setObject:@{@"route_name": route_name, @"dosage": dosage, @"days_of_treatment": days_of_treatment, @"times_per_day": times_per_day, @"time_of_day": times, @"drug_id": drug_id, @"is_finished":@"no"} forKey:@"patient_prescription_item"];
    
    [res_dic setObject:@{@"patient_id": patient_id, @"date_prescribed": [JSONHandler NSDateToString:[NSDate date]]} forKey:@"patient_prescription"];
    return res_dic;
}

+(NSDictionary *)getDrugIdByDrugName:(NSString *)drug_name{
    NSString *params = [NSString stringWithFormat:@"drug_name=%@", drug_name];
    NSString *res_str = [Get getRequest:[SERVER_URL stringByAppendingString:@"medications/find_by_drug_name/?"] withParams: params];
    if([res_str isEqualToString:@"failed"]) return nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:[JSONHandler StringToData:res_str] options:NSJSONReadingMutableContainers error:nil];
    return res;
}

+(NSDictionary *)medicationsShow:(NSString *)drug_id{
    NSLog(@"url: %@", [[SERVER_URL stringByAppendingString:@"medications/"] stringByAppendingString: drug_id]);
    NSString *params = [NSString stringWithFormat:@"drug_id=%@", drug_id];
    NSString *res = [Get getRequest:[[SERVER_URL stringByAppendingString:@"medications/"] stringByAppendingString: drug_id] withParams: params];
    NSLog(@"res_dic: %@", res);
    NSDictionary *dic = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:[JSONHandler StringToData: res] options:NSJSONReadingMutableContainers error:nil];
    return dic;
}
@end
