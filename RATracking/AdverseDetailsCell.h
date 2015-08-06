//
//  AdverseDetailsCell.h
//  RATracking
//
//  Created by Yu Song on 8/6/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdverseDetailsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *drug_photo;
@property (strong, nonatomic) IBOutlet UILabel *event_name_label;
@property (strong, nonatomic) IBOutlet UILabel *report_date_label;

@end
