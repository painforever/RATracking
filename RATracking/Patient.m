//
//  Patient.m
//  new_green_box
//
//  Created by Yu on 12/4/14.
//  Copyright (c) 2014 Yu. All rights reserved.
//

#import "Patient.h"

@implementation Patient

+(NSString* )LogOut:(NSString *)user_id{
    NSString *str=[[NSString alloc] initWithFormat:@"user_id=%@", user_id];
    return [Post postRequest:[SERVER_URL stringByAppendingString:@"users/logout.json"] withParams:str];
}

+(NSString*)getMyDrugs:(NSString *)patient_id{
    NSString *res=[[NSString alloc] initWithFormat:@"patient_id=%@&user_id=%@", patient_id, user_id];
    return [Get getRequest:[SERVER_URL stringByAppendingString:@"users/get_my_drugs?"] withParams: res];
}

+(NSString *)eatDrug:(NSString *)prescription_instance_id withPatientID:(NSString*)patient_id{
    NSString *param=[[NSString alloc] initWithFormat:@"prescription_item_id=%@&patient_id=%@&user_id=%@", prescription_instance_id, patient_id, user_id];
    return [Post postRequest:[SERVER_URL stringByAppendingString:@"medications/eat_drug.json"] withParams:param];
}

+(NSString *)getSingleDrugInfo:(NSString *)drug_id{
    NSString *params=[[NSString alloc] initWithFormat:@"drug_id=%@&user_id=%@", drug_id, user_id];
    return [Get getRequest:[SERVER_URL stringByAppendingString:@"medications/get_single_drug?"] withParams:params];
}

+(NSString *)doReport:(NSString *)patient_id withDrugID:(NSString *)drug_id withSideEffects:(NSString *)side_effect{
    NSString *params=[[NSString alloc] initWithFormat:@"patient_id=%@&drug_id=%@&side_effects=%@&user_id=%@", patient_id, drug_id, side_effect, user_id];
    return [Post postRequest:[SERVER_URL stringByAppendingString:@"reports/add_report"] withParams:params];
}

+ (NSDate *) getDate:(NSString *)str{
    NSDateFormatter *formater=[[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate=[formater stringFromDate:[NSDate date]];
    stringFromDate=[[stringFromDate stringByAppendingString:@" "] stringByAppendingString:str];
    NSDate *date=[formater dateFromString:stringFromDate];
    return date;
}

+(NSString*)finishTakingDrug:(NSString *)prescription_instance_id{
    NSString *param=[[NSString alloc] initWithFormat:@"prescription_instance_id=%@&user_id=%@", prescription_instance_id, user_id];
    return [Post postRequest:[SERVER_URL stringByAppendingString:@"medications/finish_taking_drug.json"]withParams: param];
}

+(NSMutableArray *)getDrugHistory:(NSString *)patient_id{
    NSString *param=[[NSString alloc] initWithFormat:@"patient_id=%@&user_id=%@", patient_id, user_id];
    NSString *res_str= [Get getRequest:[SERVER_URL stringByAppendingString:@"medications/get_drug_history?"] withParams:param];
    NSDictionary *res_dic=[NSJSONSerialization JSONObjectWithData:[JSONHandler StringToData:res_str] options:NSJSONReadingMutableContainers error:nil];
    return [res_dic objectForKey:@"result"];
}

+(NSString *)getUserID:(NSString *)patient_id{
    NSString *param=[[NSString alloc] initWithFormat:@"patient_id=%@&user_id=%@", patient_id, user_id];
    return [Get getRequest:[SERVER_URL stringByAppendingString:@"users/get_patient_user_id?"] withParams:param];
}

//getAllMyProvidersId, get all of providers that as long as they assigned me drugs
+(NSString *)getAllMyProvidersUserId: (NSString *)patient_id{
    NSString *param=[[NSString alloc] initWithFormat:@"patient_id=%@&user_id=%@", patient_id, user_id];
    return [Get getRequest:[SERVER_URL stringByAppendingString:@"providers/get_all_my_providers_user_id.json?"] withParams:param];
}

//get this patient's all unpaid prescriptions
+(NSString *)getAllMyPrescriptions: (NSString *)patient_id{
    NSString *param=[[NSString alloc] initWithFormat:@"patient_id=%@&user_id=%@", patient_id, user_id];
    return [Get getRequest:[SERVER_URL stringByAppendingString:@"prescriptions/show_rxs?"] withParams:param];
}
//get all drug that belongs to a single prescription
+(NSString*)getDrugsInPrescription:(NSString *)patient_id withPrescriptionId:(NSString *)prescription_id{
    NSString *param=[[NSString alloc] initWithFormat:@"patient_id=%@&prescription_id=%@&user_id=%@", patient_id, prescription_id, user_id];
    return [Get getRequest:[SERVER_URL stringByAppendingString:@"prescriptions/rx_details?"] withParams:param];
}

+(NSString*)pushRx:(NSString *)rx_id{
    NSString *param=[[NSString alloc] initWithFormat:@"prescription_id=%@&user_id=%@", rx_id, user_id];
    return [Post postRequest:[SERVER_URL stringByAppendingString:@"prescriptions/push_rx"] withParams:param];
}

+(NSDictionary*)getMyProfile:(NSString*)user_id{
    NSString *param=[[NSString alloc] initWithFormat:@"user_id=%@", user_id];
    NSString *res=[Get getRequest:[SERVER_URL stringByAppendingString:@"users/get_my_profile.json?"] withParams: param];
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:[JSONHandler StringToData:res] options:NSJSONReadingMutableContainers error:nil];
    return dic;
}

+(NSString*)updatePassword:(NSString*)new_password withOldPassword:(NSString *)old_password withEmail:(NSString *)email throughUserID:(NSString *)user_id{
    NSString *param=[[NSString alloc] initWithFormat:@"new_password=%@&old_password=%@&email=%@&user_id=%@", new_password, email, user_id];
    return [Post postRequest:[SERVER_URL stringByAppendingString:@"users/update_password"] withParams:param];
}

+(NSString*)eatNonOralDrug:(NSString *)prescription_instance_id withPatientID:(NSString *)patient_id withScores:(NSString*)scores{
    NSString *param=[[NSString alloc] initWithFormat:@"prescription_instance_id=%@&patient_id=%@&scores=%@&user_id=%@", prescription_instance_id, patient_id, scores, user_id];
    return [Post postRequest:[SERVER_URL stringByAppendingString:@"medications/eat_non_oral_drug.json"] withParams:param];
}

+(NSString *)signUp:(NSString *)email withPassword:(NSString *)password withFirstName:(NSString *)first_name withLastName:(NSString *)last_name{
    NSString *param=[[NSString alloc] initWithFormat:@"email=%@&password=%@&first_name=%@&last_name=%@&token=%@", email, password, first_name, last_name, @"sfeklw8384j2j254jojvg2g1"];
    return [Post postRequest:[SERVER_URL stringByAppendingString:@"users/patient_signup"] withParams:param];
}

+(NSString *)checkEmailRepeat:(NSString *)email{
    NSString *param=[[NSString alloc] initWithFormat:@"email=%@&user_id=%@", email, user_id];
    NSString *res=[Get getRequest:[SERVER_URL stringByAppendingString:@"users/check_email_repeat.json?"] withParams: param];
    return res;
}

+(NSString*)take_clozapine_and_report:(NSString *)patient_id withWBC:(NSString *)wbc withANC:(NSString *)anc{
    NSString *param=[[NSString alloc] initWithFormat:@"&patient_id=%@&wbc=%@&anc=%@&user_id=%@", patient_id, wbc, anc, user_id];
    return [Post postRequest:[SERVER_URL stringByAppendingString:@"medications/take_clozapine_and_report.json"] withParams:param];
}

+(NSString *)getEditableProfileData:(NSString *)user_id{
    NSString *param=[[NSString alloc] initWithFormat:@"user_id=%@", user_id];
    return [Get getRequest:[SERVER_URL stringByAppendingString:@"users/get_editable_profile.json?"] withParams:param];
}

+(NSString *)updateEditableProfileData:(NSString *)user_id withNSDicParams: (NSDictionary*)dic_params{
    NSString *params=[[NSString alloc] initWithFormat:@"user_id=%@&home_address1=%@&county=%@&cell_phone_number=%@&email_address=%@&country=%@&zipcode=%@&state=%@&city=%@", user_id, [dic_params objectForKey:@"home_address1"], [dic_params objectForKey:@"county"], [dic_params objectForKey:@"cell_phone_number"], [dic_params objectForKey:@"email_address"], [dic_params objectForKey:@"country"], [dic_params objectForKey:@"zipcode"], [dic_params objectForKey:@"state"], [dic_params objectForKey:@"city"]];
    return [Post postRequest:[SERVER_URL stringByAppendingString:@"users/update_editable_profile"] withParams:params];
}

+(void)sendDeviceToken:(NSString *)user_id withDeviceToken:(NSString *)deviceToken{
    NSString *params=[NSString stringWithFormat:@"user_id=%@&device_token=%@", user_id, deviceToken];
    [Post postRequest:[SERVER_URL stringByAppendingString:@""] withParams:params];
}

//+(NSString *)getWebSocketConnectString:(NSString *)user_id withDeviceToken:(NSString *)device_token{
//    NSString *url = [NSString stringWithFormat: [WEBSOCKET_URL stringByAppendingString:@"?user_id=%@&device_token=%@"],user_id, device_token];
//    return url;
//}

+(NSString *)getPrimaryProvider{
    NSString *params = [NSString stringWithFormat:@"patient_id=%@&user_id=%@", patient_id, user_id];
    return [Get getRequest:[SERVER_URL stringByAppendingString:@"providers/get_primary_provider?"] withParams:params];
}

+(NSString *)getProvider: (NSString *)provider_npi{
    NSString *params = [NSString stringWithFormat:@"provider_npi=%@&user_id=%@", provider_npi, user_id];
    return [Get getRequest:[SERVER_URL stringByAppendingString:@"providers/get_provider?"] withParams:params];
}

+(NSString*)trim:(NSString *)str{
    NSString *trimmedString = [str stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    return trimmedString;
}
+(NSString *) fuck{
    NSString *data=[Get getRequest:@"http://www.google.com" withParams:@""];
    return data;
}
@end
