//
//  SearchViewController.m
//  RATracking
//
//  Created by Yu Song on 8/6/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "SearchViewController.h"

@implementation SearchViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"Search Pharmacies";
    self.searchBar.delegate = self;
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
    cell.address.text = [NSString stringWithFormat:@"%@ %@ %@", cell_data[@"prvd_First_Line_Business_Practice_loc_addr"], cell_data[@"prvd_Business_Practice_loc_addr_City_Name"], cell_data[@"prvd_Business_Practice_loc_addr_State_Name"], cell_data[@"prvd_Business_Practice_loc_addr_Postal_Code"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PharmacyDetailsViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"PharmacyDetailsViewController"];
    NSDictionary *dic = [self.table_data objectAtIndex:indexPath.row];
    view.pharmacy_name = dic[@"prvd_other_organization_name"];
    view.address = [NSString stringWithFormat:@"%@ %@ %@", dic[@"prvd_First_Line_Business_Practice_loc_addr"], dic[@"prvd_Business_Practice_loc_addr_City_Name"], dic[@"prvd_Business_Practice_loc_addr_State_Name"], dic[@"prvd_Business_Practice_loc_addr_Postal_Code"]];
    [self.navigationController pushViewController:view animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    NSLog(@"search......");
    [[Medication getAFManager] GET:[SERVER_URL stringByAppendingString:@"pharmacies/find_pharmacies"] parameters:@{@"pharmacy_name": searchBar.text} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *res_arr = (NSMutableArray *)responseObject;
        NSLog(@"yaodian :%@", [res_arr description]);
        NSLog(@"json: %@", responseObject);
        self.table_data = res_arr;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed");
    }];
}


@end
