//
//  ParametersVerify.h
//  DriftBottle
//
//  Created by CheerChen on 15-3-11.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParametersVerify : NSObject
//邮箱校验
+ (BOOL) validateEmail:(NSString *)email;
//手机号码校验
+ (BOOL) validateMobile:(NSString *)mobile;
//密码校验，不包含非法字符，由数字、字母、下划线组成
+ (BOOL) validatePassword:(NSString *)passWord;
@end
