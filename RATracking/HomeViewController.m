
//
//  HomeViewController.m
//  RATracking
//
//  Created by Yu Song on 7/28/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "HomeViewController.h"

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initControls];
    self.table_data = [Medication getMyMedications: patient_id];
    [self.tableView reloadData];
}

#pragma menu for left top
- (IBAction)toggleMenu: (id)sender
{
    if (self.menu.isOpen)
        return [self.menu close];
    [self.menu showFromNavigationController:self.navigationController];
}

- (IBAction)actions_action:(id)sender {
    [self quickStart];
}

#pragma mark App JKPopMenuViewSelectDelegate
- (void)popMenuViewSelectIndex:(NSInteger)index
{
    NSLog(@"%d", index);
    //[self pushToViewController: @"AdverseEventViewController"];
}

-(void)initControls{
    self.title = @"Rx History";
    [self.menu close];
    self.menu = [[REMenu alloc] initWithItems:[self actionsInRxHistory]];
    [self.menu setClosePreparationBlock:^{
        NSLog(@"Menu will close");
    }];
    [self.menu setCloseCompletionHandler:^{
        NSLog(@"Menu did close");
    }];
}

#pragma table stuff
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.table_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"med_row";
    MedHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[MedHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    NSDictionary *med_row_dic = [self.table_data objectAtIndex: indexPath.row];
    cell.drug_name_label.text = med_row_dic[@"drug_name"];
    cell.created_at_label.text = [NSString stringWithFormat:@"Date: %@", med_row_dic[@"date_prescribed"]];
    NSString *drug_photo = [NSString stringWithFormat:@"%@", med_row_dic[@"drug_photo"]];
    if ([[self trim: drug_photo] length] == 0 || drug_photo == NULL) {
        drug_photo = @"http://bipolarhappens.com/bhblog/wp-content/uploads/med-question6.gif";
    }
    cell.drug_image_view.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: drug_photo]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
