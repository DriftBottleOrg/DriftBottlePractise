//
//  Message.h
//  DriftBottle
//
//  Created by admin on 15-3-6.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Message : NSManagedObject

@property (nonatomic, retain) NSNumber * accessoryId;
@property (nonatomic, retain) NSNumber * bottleId;
@property (nonatomic, retain) NSNumber * messageId;
@property (nonatomic, retain) NSNumber * messageType;
@property (nonatomic, retain) NSNumber * senderUserId;

@end
