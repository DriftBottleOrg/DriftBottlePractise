//
//  ViewController.h
//  DriftBottle
//
//  Created by admin on 14-12-13.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarViewController.h"
#import "FishViewController.h"
#import "LoginViewController.h"

@interface ViewController : UIViewController

@property (strong, nonatomic)TabBarViewController *tabBarViewController;
@property (strong, nonatomic)FishViewController *fishViewController;
@property (strong, nonatomic)LoginViewController *loginViewController;

//- (IBAction)click:(id)sender;

@end

