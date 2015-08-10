//
//  Pharmacy.m
//  RATracking
//
//  Created by Yu Song on 8/10/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "Pharmacy.h"

static AFHTTPRequestOperationManager *manager = nil;

@implementation Pharmacy

+(AFHTTPRequestOperationManager*)getAFManager{
    if(manager==nil)
        manager=[AFHTTPRequestOperationManager manager];
    return manager;
}

@end
