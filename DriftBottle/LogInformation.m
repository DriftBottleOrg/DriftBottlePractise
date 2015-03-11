//
//  LogInformation.m
//  DriftBottle
//
//  Created by admin on 15-3-6.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "LogInformation.h"

@interface LogInformation()
@property (strong, nonatomic)NSString *userName;
@property (strong, nonatomic)NSString *passWord;

@end

@implementation LogInformation
@synthesize userName = _userName,passWord = _passWord;

- (void)setUserName:(NSString *)userName
{
    _userName = userName;
}
- (void)setPassWord:(NSString *)passWord
{
    _passWord = passWord;
}

- (NSString *)userName
{
    return _userName;
}
- (NSString *)passWord
{
    return _passWord;
}
@end
