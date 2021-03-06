//
//  UIViewController+SharedUIMethods.m
//  TrackPacker
//
//  Created by Yu Song on 7/21/15.
//  Copyright (c) 2015 TrackPacker. All rights reserved.
//

#import "UIViewController+SharedUIMethods.h"

@implementation UIViewController (SharedUIMethods)

-(void)showAlert: (NSString *)title withMessage: (NSString *)msg{
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:title
                                                     message:msg
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles: nil];
    [alert show];
}

-(void)jumpToViewController: (NSString *)ViewControllerClass{
    UIViewController *view = [self.storyboard instantiateViewControllerWithIdentifier: ViewControllerClass];
    [self presentViewController:view animated:YES completion:nil];
}

-(void)pushToViewController:(NSString *)viewControllerClass{
    UIViewController *view = [self.storyboard instantiateViewControllerWithIdentifier: viewControllerClass];
    [self.navigationController pushViewController:view animated:YES];
}

-(void)pushToViewControllerAlwaysWithNavBar:(NSString *)viewControllerClass{
    UIViewController *myViewController = [self.storyboard instantiateViewControllerWithIdentifier: viewControllerClass];
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:myViewController];
    //now present this navigation controller modally
    [self presentViewController:navigationController animated:YES completion:^{}];
}

@end
