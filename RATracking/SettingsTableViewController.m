
//
//  SettingsTableViewController.m
//  RATracking
//
//  Created by Yu Song on 9/22/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "SettingsTableViewController.h"

@implementation SettingsTableViewController

-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)viewDidLoad{
    self.table_data = @[@"Settings", @"Log out"];
    [self.tableView reloadData];
}

#pragma table stuff
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.table_data count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"settings";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = self.table_data[indexPath.row];
    return cell;
}
@end
