//
//  PharmacyDetailsViewController.m
//  RATracking
//
//  Created by Yu Song on 8/10/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "PharmacyDetailsViewController.h"

@implementation PharmacyDetailsViewController
{
    CLLocationManager *locationManager;
    
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"Pharmacy Details";
    NSString *location = self.address;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder geocodeAddressString:location
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     if (placemarks && placemarks.count > 0) {
                         CLPlacemark *topResult = [placemarks objectAtIndex:0];
                         
                         //long and lat
                         NSLog(@"lat: %f", topResult.location.coordinate.latitude);
                         NSLog(@"long: %f", topResult.location.coordinate.longitude);
                         
                         MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                         MKCoordinateRegion region = self.mapView.region;
                         region.center = placemark.region.center;
                         region.span.longitudeDelta /= 1200.0;
                         region.span.latitudeDelta /= 1200.0;
                         [self.mapView setRegion:region animated:YES];
                         [self.mapView addAnnotation:placemark];
                         
                     }
                 }
     ];
    self.pharmacy_name_label.text = [NSString stringWithFormat:@"Pharmacy Name: %@", self.pharmacy_name];
    self.address_label.text = [NSString stringWithFormat:@"Address: %@", self.address];
    
}
@end
