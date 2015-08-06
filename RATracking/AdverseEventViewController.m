//
//  AdverseEventViewController.m
//  RATracking
//
//  Created by Yu Song on 8/4/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "AdverseEventViewController.h"

@implementation AdverseEventViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initControls];
    [[AdverseEventReporting getAFManager] GET:[SERVER_URL stringByAppendingString:@"adverse_event_reportings"] parameters:@{@"patient_id": patient_id} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.table_data = (NSMutableArray *)responseObject;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed");
    }];
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
    [self.menu close];
    self.title = @"Adverse Events";
    self.menu = [[REMenu alloc] initWithItems:[self actionsInAdverseEvent]];
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
    static NSString *simpleTableIdentifier = @"adverse_row";
    AdverseDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[AdverseDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    NSDictionary *report_row_dic = [self.table_data objectAtIndex: indexPath.row];
    cell.event_name_label.text = report_row_dic[@"side_effects"];
    cell.report_date_label.text = report_row_dic[@"created_at"];
    NSString *drug_photo = [NSString stringWithFormat:@"%@", report_row_dic[@"drug_photo"]];
    if ([[self trim: drug_photo] length] == 0 || drug_photo == NULL) {
        drug_photo = @"http://bipolarhappens.com/bhblog/wp-content/uploads/med-question6.gif";
    }
    cell.drug_photo.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: drug_photo]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *selected_report_dic = [self.table_data objectAtIndex: indexPath.row];
    AdverseDetailsViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"AdverseDetailsViewController"];
    
    view.date_reported_str = [NSString stringWithFormat:@"Date reported: %@", selected_report_dic[@"created_at"]];
    view.event_names_str = [NSString stringWithFormat:@"Event name: %@", selected_report_dic[@"side_effects"]];
    view.related_drug_str = [NSString stringWithFormat:@"Related drug: %@", selected_report_dic[@"drug_name"]];
    
    view.drug_photo_url = selected_report_dic[@"drug_photo"];
    view.drug_id = selected_report_dic[@"drug_id"];
    view.adverse_event_reporting_id = selected_report_dic[@"id"];
    [self.navigationController pushViewController:view animated:YES];
}
@end
