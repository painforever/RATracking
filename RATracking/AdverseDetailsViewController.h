//
//  AdverseDetailsViewController.h
//  RATracking
//
//  Created by Yu Song on 8/6/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Manifest.h"
#import "UIViewController+SharedUIMethods.h"

@interface AdverseDetailsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *drug_photo;
@property (strong, nonatomic) IBOutlet UILabel *date_reported;
@property (strong, nonatomic) IBOutlet UILabel *event_names;
@property (strong, nonatomic) IBOutlet UILabel *related_drug;
@property (strong, nonatomic) IBOutlet UILabel *drug_start_time;
@property (strong, nonatomic) IBOutlet UILabel *dosage;
@property (strong, nonatomic) IBOutlet UILabel *notes;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

//non component
@property (strong, nonatomic) NSString *drug_id;
@property (strong, nonatomic) NSString *adverse_event_reporting_id;
@property (strong, nonatomic) NSString *drug_photo_url;
@property (strong, nonatomic) NSString *date_reported_str;
@property (strong, nonatomic) NSString *event_names_str;
@property (strong, nonatomic) NSString *related_drug_str;
@end
