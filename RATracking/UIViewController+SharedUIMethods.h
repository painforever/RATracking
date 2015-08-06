//
//  UIViewController+SharedUIMethods.h
//  TrackPacker
//
//  Created by Yu Song on 7/21/15.
//  Copyright (c) 2015 TrackPacker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THProgressView.h"
#include "REMenu.h"
#import "JKPopMenuItem.h"
#import "JKPopMenuView.h"

//ViewControllers that needed
#import "AddMedicationViewController.h"

#define DEFAULT_BLUE [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]
static const CGSize progressViewSize = { 100.0f, 10.0f };

@interface UIViewController (SharedUIMethods)
@property (strong, readwrite, nonatomic) REMenu *menu;

-(void)showAlert: (NSString *)title withMessage: (NSString *)msg;
-(void)jumpToViewController: (NSString *)ViewControllerClass;
-(void)pushToViewController: (NSString *)viewControllerClass;
-(void)pushToViewControllerAlwaysWithNavBar: (NSString *)viewControllerClass;

//all kindd of actions in different views
-(NSArray *)actionsInRxHistory;
-(NSArray *)actionsInAdverseEvent;
-(NSArray *)actionsInJoint;

//6 icons popup menu
-(void)quickStart;

//trim whitespace
-(NSString *)trim: (NSString *)str;
//check whether is number
-(BOOL)isNnumber: (NSString *)input;
//clear all the inputs fields
-(void)clearAllTextFields: (NSArray *)text_fields;
@end
