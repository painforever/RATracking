//
//  MedHistoryCell.h
//  RATracking
//
//  Created by Yu Song on 8/5/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedHistoryCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *drug_name_label;
@property (strong, nonatomic) IBOutlet UILabel *created_at_label;
@property (strong, nonatomic) IBOutlet UIImageView *drug_image_view;

@end
