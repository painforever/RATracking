//
//  SearchViewController.m
//  RATracking
//
//  Created by Yu Song on 8/6/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "SearchViewController.h"

@implementation SearchViewController
{
    double longitude;
    double latitude;
}
@synthesize locationManager;
@synthesize geocoder;


-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"Search Pharmacies";
    [self initLocationManager];
    self.searchBar.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated{
    if (geocoder == nil) {
        geocoder = [[CLGeocoder alloc] init];
    }
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.table_data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PharmacyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"search_row" forIndexPath:indexPath];
    NSDictionary *cell_data = [self.table_data objectAtIndex: indexPath.row];
    cell.pharmacy_name.text = [cell_data objectForKey:@"prvd_other_organization_name"];
    cell.address.text = [NSString stringWithFormat:@"%@ %@ %@ %@", cell_data[@"prvd_First_Line_Business_Practice_loc_addr"], cell_data[@"prvd_Business_Practice_loc_addr_City_Name"], cell_data[@"prvd_Business_Practice_loc_addr_State_Name"], cell_data[@"prvd_Business_Practice_loc_addr_Postal_Code"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PharmacyDetailsViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"PharmacyDetailsViewController"];
    NSDictionary *dic = [self.table_data objectAtIndex:indexPath.row];
    view.pharmacy_name = dic[@"prvd_other_organization_name"];
    view.address = [NSString stringWithFormat:@"%@ %@ %@ %@", dic[@"prvd_First_Line_Business_Practice_loc_addr"], dic[@"prvd_Business_Practice_loc_addr_City_Name"], dic[@"prvd_Business_Practice_loc_addr_State_Name"], dic[@"prvd_Business_Practice_loc_addr_Postal_Code"]];
    [self.navigationController pushViewController:view animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self getLocation];
    NSLog(@"search......");
    NSString *lon = [NSString stringWithFormat:@"%.8f", longitude];
    NSString *lat = [NSString stringWithFormat:@"%.8f", latitude];
    [[Medication getAFManager] GET:[SERVER_URL stringByAppendingString:@"pharmacies/find_pharmacies"] parameters:@{@"pharmacy_name": searchBar.text, @"longitude": lon, @"latitude": lat} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *res_arr = (NSMutableArray *)responseObject;
        [self getNearbyPharmacies: res_arr];
        //[self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed");
    }];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //NSLog(@"pipipi: %@", [locations.lastObject description]);
    CLLocation *loc = [locations lastObject];
    latitude = loc.coordinate.latitude;
    longitude = loc.coordinate.longitude;
}

-(void)initLocationManager{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
        [locationManager requestAlwaysAuthorization];
    }
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}

-(CLLocationCoordinate2D)getLocation{
    CLLocationCoordinate2D coordinate = [[locationManager location] coordinate];
    latitude = coordinate.latitude;
    longitude = coordinate.longitude;
    NSString *latitude = [NSString stringWithFormat:@"%.8f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%.8f", coordinate.longitude];
    return coordinate;
}

//filter to get nearby pharmacies
-(NSString *)getAddress: (NSDictionary *)dic{
    return [NSString stringWithFormat:@"%@ %@ %@ %@", dic[@"prvd_First_Line_Business_Practice_loc_addr"], dic[@"prvd_Business_Practice_loc_addr_City_Name"], dic[@"prvd_Business_Practice_loc_addr_State_Name"], dic[@"prvd_Business_Practice_loc_addr_Postal_Code"]];
}

-(CLLocation *)getMyCLLocation{
    NSLog(@"current lat and long are : %f %f", latitude, longitude);
    return [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
}

-(NSMutableArray *)getNearbyPharmacies: (NSMutableArray *)allPharmacies{
    self.nearbyPharmaciesArray = [[NSMutableArray alloc] init];
    for (NSDictionary *pharmacy in allPharmacies) {
        NSString *address = [self getAddress:pharmacy];
        NSLog(@"address is : %@", address);
        [geocoder geocodeAddressString: address
                     completionHandler:^(NSArray* placemarks, NSError* error){
                         if (placemarks && placemarks.count > 0) {
                             CLPlacemark *topResult = [placemarks objectAtIndex:0];
                             //just to print to see long and lat
                             //NSLog(@"lat: %f", topResult.location.coordinate.latitude);
                             //NSLog(@"long: %f", topResult.location.coordinate.longitude);
                             NSLog(@"distance: %.8f", [[self getMyCLLocation] distanceFromLocation:topResult.location]);
                             if ([[self getMyCLLocation] distanceFromLocation:topResult.location] < 1000000) {
                                 [self.nearbyPharmaciesArray addObject: pharmacy];
                                 self.table_data = self.nearbyPharmaciesArray;
                                 [self.tableView reloadData];
                             }
                             NSLog(@"pharmacy I like: %@", [self.nearbyPharmaciesArray description]);
                         }
                     }
         ];
    }
    return self.nearbyPharmaciesArray;
}


@end
