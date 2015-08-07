//
//  RxDetailsViewController.h
//  RATracking
//
//  Created by Yu Song on 8/7/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Manifest.h"
#import "Medication.h"

@interface RxDetailsViewController : UIViewController
@property (strong, nonatomic) NSString *prescription_id;
@property (strong, nonatomic) NSString *drug_photo;
@property (strong, nonatomic) NSString *drug_name;
@property (strong, nonatomic) NSString *drug_id;

//controls
@property (strong, nonatomic) IBOutlet UIImageView *drug_image;
@property (strong, nonatomic) IBOutlet UILabel *drug_name_label;
@property (strong, nonatomic) IBOutlet UILabel *composite_label;
@property (strong, nonatomic) IBOutlet UILabel *side_effects;
@property (strong, nonatomic) IBOutlet UITextView *intro_view;

@end
