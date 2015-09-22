//
//  Patient.h
//  new_green_box
//
//  Created by Yu on 12/4/14.
//  Copyright (c) 2014 Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "Post.h"
#import "Get.h"
#import "JSONHandler.h"

@interface Patient : NSObject

+(NSString *)LogOut:(NSString*)user_id;
+(NSString *)getMyDrugs:(NSString*)patient_id;
+(NSString *)eatDrug:(NSString*)prescription_instance_id withPatientID:(NSString*)patient_id;
+(NSString *)getSingleDrugInfo:(NSString *)drug_id;
+(NSString *)doReport:(NSString*)patient_id withDrugID:(NSString*)drug_id withSideEffects:(NSString*)side_effect;
+(NSString *)getDate:(NSString*)str;
+(NSString *)finishTakingDrug:(NSString *)prescription_instance_id;
+(NSMutableArray *)getDrugHistory: (NSString*)patient_id;
+(NSString *)getUserID:(NSString *)patient_id;
+(NSString *)getAllMyProvidersUserId:(NSString *)patient_id;
+(NSString *)getAllMyPrescriptions: (NSString*)patient_id;
+(NSString *)getDrugsInPrescription: (NSString*)patient_id withPrescriptionId:(NSString*)prescription_id;
+(NSString *)pushRx: (NSString*)rx_id;
+(NSArray*)getMyProfile:(NSString*)user_id;
+(NSString*)updatePassword:(NSString*)new_password withOldPassword: (NSString *)old_password withEmail:(NSString*)email throughUserID:(NSString*)user_id;
+(NSString*)eatNonOralDrug:(NSString*)prescription_instance_id withPatientID:(NSString*)patient_id withScores:(NSString*)scores;
+(NSString*)signUp:(NSString *)email withPassword:(NSString *)password withFirstName:(NSString*)first_name withLastName:(NSString *)last_name;

+(NSString *)checkEmailRepeat: (NSString *)email;
+(NSString *)take_clozapine_and_report: (NSString *)patient_id withWBC:(NSString*)wbc withANC:(NSString*)anc;
+(NSString *)getEditableProfileData: (NSString *)user_id;
+(NSString *)updateEditableProfileData:(NSString *)user_id withNSDicParams: (NSDictionary*)dic_params;
//+(void)sendDeviceToken: (NSString *)user_id withDeviceToken: (NSString *)deviceToken;
+(NSString *)getWebSocketConnectString:(NSString *)user_id withDeviceToken:(NSString *)device_token;
+(NSString *)getPrimaryProvider;
+(NSString *)getProvider: (NSString *)provider_npi;
+(NSString *)trim: (NSString*)str;
+(NSString *)fuck;
@end
