
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
    // Do any additional setup after loading the view, typically from a nib.
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
    NSLog(@"%s",__func__);
}
@end
