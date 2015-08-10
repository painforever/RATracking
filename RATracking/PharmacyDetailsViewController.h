//
//  PharmacyDetailsViewController.h
//  RATracking
//
//  Created by Yu Song on 8/10/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface PharmacyDetailsViewController : UIViewController <MKMapViewDelegate>
@property (strong, nonatomic) NSString *pharmacy_name;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *pharmacy_name_label;
@property (strong, nonatomic) IBOutlet UILabel *address_label;

@end
