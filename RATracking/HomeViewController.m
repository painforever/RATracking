
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
    [[Medication getAFManager] GET:[SERVER_URL stringByAppendingString:@"medications/?"] parameters:@{@"patient_id": patient_id} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.table_data = (NSMutableArray *)responseObject;
        NSLog(@"wocao: %@", responseObject);
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"get med failed");
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
    NSString *drug_photo = [NSString stringWithFormat:@"%@%@", BASE_URL, med_row_dic[@"drug_photo"][@"thumb"][@"url"]];
    if ([med_row_dic[@"drug_photo"][@"thumb"][@"url"] isEqual: [NSNull null]])
        cell.drug_image_view.image = [UIImage imageNamed:@"drug_default.jpg"];
    else
        cell.drug_image_view.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: drug_photo]]];
    
    cell.drug_image_view.layer.borderWidth = 1.0f;
    cell.drug_image_view.layer.borderColor = [UIColor blackColor].CGColor;
    cell.drug_image_view.layer.cornerRadius = 20.0f;
    cell.drug_image_view.clipsToBounds = YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RxDetailsViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"RxDetailsViewController"];
    NSDictionary *data_selected = [self.table_data objectAtIndex:indexPath.row];
    view.prescription_id = [data_selected objectForKey:@"prescription_id"];
    view.drug_id = [[data_selected objectForKey:@"drug_id"] stringValue];
    view.drug_name = [data_selected objectForKey:@"drug_name"];
    //assign drug photo
    NSString *drug_photo = [NSString stringWithFormat:@"%@%@", BASE_URL, data_selected[@"drug_photo"][@"url"]];
    NSLog(@"drug_photo: %@", drug_photo);
    if ([data_selected[@"drug_photo"][@"url"] isEqual:[NSNull null]]) {
        view.drug_image.image = [UIImage imageNamed:@"drug_default.jpg"];
        view.drug_photo = nil;
    }
    else view.drug_photo = [NSString stringWithFormat:@"%@", drug_photo];
    [self.navigationController pushViewController:view animated:YES];
}
@end
