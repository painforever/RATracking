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

-(NSArray *)actionsInRxHistory{
    REMenuItem *addMedication = [[REMenuItem alloc] initWithTitle:@"Add RA Medications"
                                                    subtitle:@"add new medications that you are taking"
                                                       image:[UIImage imageNamed:@"Icon_Home"]
                                            highlightedImage:nil
                                                      action:^(REMenuItem *item) {
                                                          [self pushToViewController:@"AddMedicationViewController"];
                                                      }];
    
    return @[addMedication];
}

-(NSArray *)actionsInAdverseEvent{
    REMenuItem *addadverseEvent = [[REMenuItem alloc] initWithTitle:@"Report new adverse event"
                                                         subtitle:@"You can report any adverse event for any drugs."
                                                            image:[UIImage imageNamed:@"Icon_Home"]
                                                 highlightedImage:nil
                                                           action:^(REMenuItem *item) {
                                                               NSLog(@"Item: %@", item);
                                                           }];
    return @[addadverseEvent];
}

-(NSArray *)actionsInJoint{
    REMenuItem *joint = [[REMenuItem alloc] initWithTitle:@"Report pain of joints"
                                                           subtitle:@"Let us know your pain of all kinds of joints anytime."
                                                              image:[UIImage imageNamed:@"Icon_Home"]
                                                   highlightedImage:nil
                                                             action:^(REMenuItem *item) {
                                                                 NSLog(@"Item: %@", item);
                                                             }];
    return @[joint];
}

-(void)quickStart{
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

-(NSString *)trim: (NSString *)str{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(BOOL)isNnumber:(NSString *)input{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\d+" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *matches = [regex firstMatchInString:input options:0 range:NSMakeRange(0, input.length)];
    return matches != nil;
}
@end
