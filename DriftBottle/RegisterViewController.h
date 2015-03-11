//
//  RegisterViewController.h
//  DriftBottle
//
//  Created by admin on 14-12-17.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserService.h"
#import "ASIFormDataRequest.h"

@interface RegisterViewController : UIViewController <UserServiceDelegate>

@property (nonatomic, strong) UserService *userService;

@end
