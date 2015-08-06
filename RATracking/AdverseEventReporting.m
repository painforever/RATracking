//
//  AdverseEventReporting.m
//  RATracking
//
//  Created by Yu Song on 8/5/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "AdverseEventReporting.h"

static AFHTTPRequestOperationManager *manager = nil;

@implementation AdverseEventReporting
+(AFHTTPRequestOperationManager*)getAFManager{
    if(manager==nil)
        manager=[AFHTTPRequestOperationManager manager];
    return manager;
}

@end
