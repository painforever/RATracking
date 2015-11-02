//
//  RxTableViewController.m
//  RATracking
//
//  Created by Yu Song on 9/29/15.
//  Copyright © 2015 EagleForce. All rights reserved.
//

#import "RxTableViewController.h"

@interface RxTableViewController ()

@end

@implementation RxTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initControls];
    [[Medication getAFManager] GET:[SERVER_URL stringByAppendingString:@"medications/?"] parameters:@{@"patient_id": patient_id} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.table_data = (NSMutableArray *)responseObject;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"get med failed");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self setUITableViewBackgroundImage:@"adverse_wall.jpg" withTableView:self.tableView];
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
        cell.drug_image_view.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.JPG", cell.drug_name_label.text]];
    else
        cell.drug_image_view.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: drug_photo]]];
    cell.backgroundColor = [UIColor clearColor];
    cell.drug_image_view.layer.borderWidth = 1.0f;
    cell.drug_image_view.layer.borderColor = [UIColor blackColor].CGColor;
    cell.drug_image_view.layer.cornerRadius = 20.0f;
    cell.drug_image_view.clipsToBounds = YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selected_index = (int)indexPath.row;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if ([segue.identifier isEqualToString:@"see_rx_details"]) {
//        self.details = [self.storyboard instantiateViewControllerWithIdentifier:@"RxDetailsViewController"];
//        self.details = segue.destinationViewController;
//        NSDictionary *data_selected = [self.table_data objectAtIndex: self.selected_index];
//        NSLog(@"dadsada %@", [data_selected description]);
//        self.details.prescription_id = [data_selected objectForKey:@"prescription_id"];
//        self.details.drug_id = [[data_selected objectForKey:@"drug_id"] stringValue];
//        self.details.drug_name = [data_selected objectForKey:@"drug_name"];
//        //assign drug photo
//        NSString *drug_photo = [NSString stringWithFormat:@"%@%@", BASE_URL, data_selected[@"drug_photo"][@"url"]];
//        NSLog(@"drug_photo: %@", drug_photo);
//        if ([data_selected[@"drug_photo"][@"url"] isEqual:[NSNull null]]) {
//            self.details.drug_image.image = [UIImage imageNamed:@"drug_default.jpg"];
//            self.details.drug_photo = nil;
//        }
//        else self.details.drug_photo = [NSString stringWithFormat:@"%@", drug_photo];
//    }
}

@end
