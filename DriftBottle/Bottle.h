//
//  Bottle.h
//  DriftBottle
//
//  Created by admin on 15-3-6.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Bottle : NSManagedObject

@property (nonatomic, retain) NSNumber * bottleId;
@property (nonatomic, retain) NSNumber * userId;
@property (nonatomic, retain) NSNumber * bottleType;
@property (nonatomic, retain) NSNumber * senderUserId;

@end
