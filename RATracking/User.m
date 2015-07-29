//
//  User.m
//  RATracking
//
//  Created by Yu Song on 7/28/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "User.h"

static AFHTTPRequestOperationManager *manager = nil;

@implementation User
+(AFHTTPRequestOperationManager*)getAFManager{
    if(manager==nil)
        manager=[AFHTTPRequestOperationManager manager];
    return manager;
}

//+(NSString *)login:(NSString *)email withPassword:(NSString *)password{
//    return @"";
//}
@end
