
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
@end
