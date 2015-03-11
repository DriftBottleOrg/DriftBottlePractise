//
//  CoreDataManagement.h
//  DriftBottle
//
//  Created by admin on 15-3-5.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UserInfo.h"
#import "Test2.h"

@interface CoreDataManagement : NSObject
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(NSManagedObjectContext *)createDbContext;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (void)insertUserInfoWithUserId:(NSNumber *)userId andLog_UserId:(NSNumber *)log_UserId andUserName:(NSString *)userName andRealName:(NSString *)realName andUserAddress:(NSString *)userAddress andState:(NSString *)state;
- (void)insertBottleWithBottleId:(NSNumber *)bottleId andUserId:(NSNumber *)userId andBottleType:(NSNumber *)bottleType andSenderUserId:(NSNumber *)senderUserId;
- (void)insertMessageWithBottleId:(NSNumber *)bottleId andMessageId:(NSNumber *)messageId andMessageType:(NSNumber *)messageType andSenderUserId:(NSNumber *)senderUserId andAccessoryId:(NSNumber *)accessoryId;
- (void)insertAccessoryWithBottleId:(NSNumber *)bottleId andMessageId:(NSNumber *)messageId andAccessoryId:(NSNumber *)accessoryId andAccessoryType:(NSNumber *)accessoryType andAccessoryURL:(NSString *)accessoryURL;

//插入数据
- (void)insertCoreData:(id)object toTable:(NSString *)tableName;
//查询
- (NSMutableArray*)selectData:(int)pageSize andOffset:(int)currentPage fromTable:(NSString *)tableName withCondition:(NSString *)condition;
//删除
- (void)deleteData;
//更新
- (void)updateData:(NSString*)newsId withItem:(NSString *)item;
@end
