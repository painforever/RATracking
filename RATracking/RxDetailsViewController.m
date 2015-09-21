//
//  RxDetailsViewController.m
//  RATracking
//
//  Created by Yu Song on 8/7/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "RxDetailsViewController.h"

@implementation RxDetailsViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    if (self.drug_photo)
        self.drug_image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: self.drug_photo]]];
    else self.drug_image.image = [UIImage imageNamed:@"drug_default.jpg"];
    
    self.drug_name_label.text = [NSString stringWithFormat: @"Name: %@", self.drug_name];
    [self loadData];
}

-(void)loadData{
    [[Medication getAFManager] GET:[[SERVER_URL stringByAppendingString:@"patient_prescriptions/"] stringByAppendingString: self.drug_id] parameters:@{} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *res_dic = (NSDictionary *)responseObject;
        self.side_effects.text = [NSString stringWithFormat:@"side effects: %@", [res_dic objectForKey:@"side_effects"]];
        self.composite_label.text = [NSString stringWithFormat:@"composite: %@", [res_dic objectForKey:@"drug_name"]];
        self.intro_view.text = [res_dic objectForKey:@"indication"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed");
    }];
}
@end
