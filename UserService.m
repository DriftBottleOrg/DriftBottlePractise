//
//  UserService.m
//  DriftBottle
//
//  Created by CheerChen on 15-3-11.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "UserService.h"

@implementation UserService


-(BOOL) verifyName:(NSString *) userName
{
    if(userName.length == 0)
    {
        [self.delegate userService:self ParametersError:NullUserNameError];
        return NO;
    }
    if(![ParametersVerify validateMobile:userName])
    {   //校验用户名格式：必须是手机号
        [self.delegate userService:self ParametersError:UserNameError];
        return NO;
    }
    
    [self.delegate userService:self ParametersError:NoError];
    return YES;
}
-(BOOL) verifyName:(NSString *)userName andPassword:(NSString *) password
{
    if(userName.length == 0)
    {
        [self.delegate userService:self ParametersError:NullUserNameError];
        return NO;
    }
    if(password.length == 0)
    {
        [self.delegate userService:self ParametersError:NullPasswordError];
        return NO;
    }
    
    if(![ParametersVerify validateMobile:userName])
    {   //校验用户名格式：必须是手机号
        [self.delegate userService:self ParametersError:UserNameError];
        return NO;
    }
    if(![ParametersVerify validatePassword:password])
    {
        [self.delegate userService:self ParametersError:PasswordError];
        return NO;
    }
    
    [self.delegate userService:self ParametersError:NoError];
    return YES;
    
}
@end
