
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
    self.title = @"Overview of reports";
    // Do any additional setup after loading the view, typically from a nib.
    
    PieLayer* pieLayer = [[PieLayer alloc] init];
    pieLayer.frame = CGRectMake((self.view.bounds.size.width/2)-150, (self.view.bounds.size.height/2)-150, 300, 300);
    [pieLayer addValues:@[[PieElement pieElementWithValue:5.0 color:[UIColor redColor]],
                          [PieElement pieElementWithValue:4.0 color:[UIColor grayColor]],
                          [PieElement pieElementWithValue:7.0 color:[UIColor greenColor]]] animated:YES];
    [self.view.layer addSublayer:pieLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actions_action:(id)sender {
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSInteger i = 1; i < 7; i++) {
        NSString *string = [NSString stringWithFormat:@"icon%ld",i];
        JKPopMenuItem *item = [JKPopMenuItem itemWithTitle:string image:[UIImage imageNamed:string]];
        [array addObject:item];
    }
    JKPopMenuView *jkpop = [JKPopMenuView menuViewWithItems:array];
    jkpop.delegate = self;
    [jkpop show];
}

#pragma mark App JKPopMenuViewSelectDelegate
- (void)popMenuViewSelectIndex:(NSInteger)index
{
    NSLog(@"%d", index);
    [self pushToViewController: @"ReportViewController"];
}
@end
