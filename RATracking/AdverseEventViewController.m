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
@end
