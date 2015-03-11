//
//  LoginViewController.h
//  DriftBottle
//
//  Created by admin on 14-12-17.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FishViewController.h"
#import "TabBarViewController.h"

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *passWord;


@property (strong, nonatomic) FishViewController *fishViewController;
@property (strong, nonatomic) TabBarViewController *tabBarViewController;

- (IBAction)click:(id)sender;
@end
