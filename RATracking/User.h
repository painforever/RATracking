//
//  User.h
//  RATracking
//
//  Created by Yu Song on 7/28/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import <AFNetworking.h>

@interface User : NSObject
+(AFHTTPRequestOperationManager*)getAFManager;

+(NSString *)login: (NSString *)email withPassword: (NSString *)password;
@end
