//
//  Friends.h
//  DriftBottle
//
//  Created by admin on 15-3-6.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Friends : NSManagedObject

@property (nonatomic, retain) NSNumber * userId;
@property (nonatomic, retain) NSNumber * friendId;
@property (nonatomic, retain) NSString * friendName;

@end
