//
//  ParametersVerify.m
//  DriftBottle
//
//  Created by CheerChen on 15-3-11.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "ParametersVerify.h"

@implementation ParametersVerify

/**
 *  邮箱校验
 *
 *  @param email 邮箱
 *
 *  @return 校验输入的用户名是否为邮箱
 */
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
/**
 *  手机号码校验
 *
 *  @param mobile 手机号码
 *
 *  @return 校验是否是手机号码：由13、15、17、18开头
 */
+ (BOOL) validateMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
    
}
/**
 *  密码校验
 *
 *  @param passWord 密码
 *
 *  @return 密码是否由数字、字符、下划线组成
 */
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[0-9a-zA-Z_]+$";
    NSPredicate *passWordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWordRegex];
    return [passWordTest evaluateWithObject:passWord];
}
@end
