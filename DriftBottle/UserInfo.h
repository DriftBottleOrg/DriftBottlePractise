//
//  UserInfo.h
//  DriftBottle
//
//  Created by admin on 15-3-6.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserInfo : NSManagedObject

@property (nonatomic, retain) NSNumber * log_UserId;
@property (nonatomic, retain) NSString * realName;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * userAddress;
@property (nonatomic, retain) NSNumber * userId;
@property (nonatomic, retain) NSString * userName;

@end
