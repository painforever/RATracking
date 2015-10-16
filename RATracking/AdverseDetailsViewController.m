//
//  AdverseDetailsViewController.m
//  RATracking
//
//  Created by Yu Song on 8/6/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "AdverseDetailsViewController.h"

@implementation AdverseDetailsViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self styleImageView:self.drug_photo withBorderColor:[UIColor blackColor].CGColor withCornerRadius:20.0f withBorderWidth:1.0f];
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(320, self.view.frame.size.height+200)];
    if (self.drug_photo_url)
        self.drug_photo.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: self.drug_photo_url]]];
    
    else self.drug_photo.image = [UIImage imageNamed:@"drug_default.jpg"];
    NSLog(@"url: %@", self.drug_photo_url);
    
    [[AdverseEventReporting getAFManager] GET:[NSString stringWithFormat:@"%@%@%@", SERVER_URL, @"adverse_event_reportings/",self.adverse_event_reporting_id] parameters:@{} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *res_arr = (NSMutableArray *)responseObject;
        //NSLog(@"des: %@", [res_arr description]);
        NSDictionary *ad = res_arr[0];
        NSDictionary *rx = res_arr[1];
        self.drug_start_time.text = [NSString stringWithFormat:@"Date prescribed: %@", [rx[@"date_prescribed"] substringToIndex: 10]];
        self.dosage.text = [NSString stringWithFormat:@"Dosage: %@", ad[@"dosage"]];
        self.notes.text = [NSString stringWithFormat:@"Notes: %@", ad[@"notes"]];
        self.date_reported.text = self.date_reported_str;
        self.event_names.text = self.event_names_str;
        self.related_drug.text = self.related_drug_str;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed");
    }];
}

@end
