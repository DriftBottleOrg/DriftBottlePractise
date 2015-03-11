//
//  LogInformation.h
//  DriftBottle
//
//  Created by admin on 15-3-6.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogInformation : NSObject

- (void)setUserName:(NSString *)userName;
- (void)setPassWord:(NSString *)passWord;

- (NSString *)userName;
- (NSString *)passWord;
@end
