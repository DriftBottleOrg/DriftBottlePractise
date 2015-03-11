//
//  UserService.h
//  DriftBottle
//
//  Created by CheerChen on 15-3-11.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "ParametersVerify.h"

@class UserService;

typedef  enum  errorType{
    UserNameError = 0, //用户名格式错误：不是手机号
    PasswordError = 1,//密码错误：不能有特殊字符
    NullUserNameError = 2,//用户名为空
    NullPasswordError = 3,//密码为空
    NoError = 4 //没有错误
} ErrorType;

#pragma mark -----自定义协议，视图控制器实现该协议后，通过errorType，控制显示内容。
@protocol UserServiceDelegate <NSObject>

@optional
//验证用户名和密码，通过errorType判断错误类型。
-(void) userService:(UserService *)userService ParametersError:(ErrorType) errorType;


@end

#pragma mark ------设置UserService到属性和方法。
@interface UserService : NSObject

@property (nonatomic, strong) id<UserServiceDelegate> delegate;
@property (nonatomic, strong) UserInfo *user;

//验证用户名密码到合法性
-(BOOL) verifyName:(NSString *) userName;
-(BOOL) verifyName:(NSString *)userName andPassword:(NSString *) password;
@end
