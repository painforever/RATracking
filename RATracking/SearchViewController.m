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
    cell.pharmacy_name.text = [cell_data objectForKey:@"pharmacy_name"];
    cell.address.text = [cell_data objectForKey:@"address1"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PharmacyDetailsViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"PharmacyDetailsViewController"];
    NSDictionary *dic = [self.table_data objectAtIndex:indexPath.row];
    view.pharmacy_name = dic[@"pharmacy_name"];
    view.address = [NSString stringWithFormat:@"%@ %@ %@ %@", dic[@"address1"], dic[@"address2"], dic[@"city"], dic[@"state"], dic[@"zipcode"]];
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
        NSLog(@"json: %@", responseObject);
        self.table_data = res_arr;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed");
    }];
}


@end
