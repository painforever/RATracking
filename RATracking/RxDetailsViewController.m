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
    self.drug_image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: self.drug_photo]]];
}
@end
