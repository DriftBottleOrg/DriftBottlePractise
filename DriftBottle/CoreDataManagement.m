//
//  CoreDataManagement.m
//  DriftBottle
//
//  Created by admin on 15-3-5.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "CoreDataManagement.h"
#import "MMM.h"
#import "Bottle.h"
#import "Message.h"
#import "Accessory.h"
@implementation CoreDataManagement
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize context;

-(NSManagedObjectContext *)createDbContext{
    if(!self.context){
    //NSManagedObjectContext *context;
    //打开模型文件，参数为nil则打开包中所有模型文件并合并成一个
    NSManagedObjectModel *model=[NSManagedObjectModel mergedModelFromBundles:nil];
    //创建解析器
    NSPersistentStoreCoordinator *storeCoordinator=[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    //创建数据库保存路径
    NSString *dir=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    //NSLog(@"%@",dir);
    NSString *path=[dir stringByAppendingPathComponent:@"myDatabase.db"];
    NSURL *url=[NSURL fileURLWithPath:path];
    //添加SQLite持久存储到解析器
    NSError *error;
    [storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if(error){
        NSLog(@"数据库打开失败！错误:%@",error.localizedDescription);
    }else{
        self.context=[[NSManagedObjectContext alloc] init];
        self.context.persistentStoreCoordinator=storeCoordinator;
        //NSLog(@"数据库打开成功！");
    }
    }
    return self.context;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TestModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TestModel.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        //abort();
    }
    
    return _persistentStoreCoordinator;
}

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
//    if (_managedObjectContext != nil) {
//        return _managedObjectContext;
//    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.获取Documents路径
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

//插入数组数据
- (void)insertCoreData:(MMM *)object toTable:(NSString *)tableName
{
    //NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObjectContext *context2 = [self createDbContext];
//    for (UserInfo *info in dataArray) {
//        UserInfo *userInfo = [NSEntityDescription insertNewObjectForEntityForName:TableName inManagedObjectContext:context];
//        userInfo.userId = info.userId;
//        userInfo.logId = info.logId;
//        userInfo.userName = info.userName;
//        userInfo.address = info.address;
//        userInfo.realName = info.realName;
//        
//        NSError *error;
//        if(![context save:&error])
//        {
//            NSLog(@"不能保存：%@",[error localizedDescription]);
//        }
//    }for (id info in dataArray) {
        //id object2 = [NSEntityDescription insertNewObjectForEntityForName:tableName inManagedObjectContext:context];
//        test.name = @"Mike";
//        test.gender = @"male";
        //object2 = object;
    MMM *mmm = [NSEntityDescription insertNewObjectForEntityForName:@"MMM" inManagedObjectContext:context2];
    //mmm = object;
    mmm.id = [NSNumber numberWithInt:10];
    mmm.name = @"xiaohuozi";
        NSError *error;
        if(![context2 save:&error])
        {
            NSLog(@"不能保存：%@",[error localizedDescription]);
        }
}
//插入用户信息
- (void)insertUserInfoWithUserId:(NSNumber *)userId andLog_UserId:(NSNumber *)log_UserId andUserName:(NSString *)userName andRealName:(NSString *)realName andUserAddress:(NSString *)userAddress andState:(NSString *)state
{
     NSManagedObjectContext *context2 = [self createDbContext];
    UserInfo *userInfo = [NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:context2];
    userInfo.userId = userId;
    userInfo.log_UserId = log_UserId;
    userInfo.userName = userName;
    userInfo.realName = realName;
    userInfo.userAddress = userAddress;
    userInfo.state = state;
    NSError *error;
    if(![context2 save:&error])
    {
        NSLog(@"不能保存：%@",[error localizedDescription]);
    }
}
//插入瓶子
- (void)insertBottleWithBottleId:(NSNumber *)bottleId andUserId:(NSNumber *)userId andBottleType:(NSNumber *)bottleType andSenderUserId:(NSNumber *)senderUserId
{
    NSManagedObjectContext *context2 = [self createDbContext];
    Bottle *bottle = [NSEntityDescription insertNewObjectForEntityForName:@"Bottle" inManagedObjectContext:context2];
    bottle.bottleId = bottleId;
    bottle.userId = userId;
    bottle.bottleType = bottleType;
    bottle.senderUserId =senderUserId;
    NSError *error;
    if(![context2 save:&error])
    {
        NSLog(@"不能保存：%@",[error localizedDescription]);
    }

}
//插入message
- (void)insertMessageWithBottleId:(NSNumber *)bottleId andMessageId:(NSNumber *)messageId andMessageType:(NSNumber *)messageType andSenderUserId:(NSNumber *)senderUserId andAccessoryId:(NSNumber *)accessoryId
{
    NSManagedObjectContext *context2 = [self createDbContext];
    Message *message = [NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:context2];
    message.bottleId = bottleId;
    message.messageId = messageId;
    message.messageType = messageType;
    message.senderUserId = senderUserId;
    message.accessoryId = accessoryId;
    NSError *error;
    if(![context2 save:&error])
    {
        NSLog(@"不能保存：%@",[error localizedDescription]);
    }
}
//插入附件
- (void)insertAccessoryWithBottleId:(NSNumber *)bottleId andMessageId:(NSNumber *)messageId andAccessoryId:(NSNumber *)accessoryId andAccessoryType:(NSNumber *)accessoryType andAccessoryURL:(NSString *)accessoryURL
{
    NSManagedObjectContext *context2 = [self createDbContext];
    Accessory *accessory = [NSEntityDescription insertNewObjectForEntityForName:@"Accessory" inManagedObjectContext:context2];
    accessory.bottleId =bottleId;
    accessory.messageId = messageId;
    accessory.accessoryId = accessoryId;
    accessory.accessoryType = accessoryType;
    accessory.accessoryURL = accessoryURL;
    NSError *error;
    if(![context2 save:&error])
    {
        NSLog(@"不能保存：%@",[error localizedDescription]);
    }
}
//查询
- (NSMutableArray*)selectData:(int)pageSize andOffset:(int)currentPage fromTable:(NSString *)tableName withCondition:(NSString *)condition
{
    
    NSLog(@"select");
    NSManagedObjectContext *context = [self createDbContext];
    
    // 限定查询结果的数量
    //setFetchLimit
    // 查询的偏移量
    //setFetchOffset
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    if(pageSize != 0){
//    [fetchRequest setFetchLimit:pageSize];
//    [fetchRequest setFetchOffset:currentPage];
//    }
    fetchRequest.predicate = [NSPredicate predicateWithFormat:condition];

    NSEntityDescription *entity = [NSEntityDescription entityForName:[NSString stringWithFormat:@"%@",tableName] inManagedObjectContext:context];
    //NSLog(@"entity is %@",entity);
    [fetchRequest setEntity:entity];

    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *resultArray = [NSMutableArray array];
    
    NSLog(@"resulr length is %lu",(unsigned long)[resultArray count]);
    for (id info in fetchedObjects) {
       // NSLog(@"id:%@", info.userId);
        //NSLog(@"title:%@", info.name);
        [resultArray addObject:info];
    }
    return resultArray;
}

//删除
-(void)deleteData
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Test" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:entity];
    NSError *error = nil;
    NSArray *datas = [context executeFetchRequest:request error:&error];
    if (!error && datas && [datas count])
    {
        for (NSManagedObject *obj in datas)
        {
            [context deleteObject:obj];
        }
        if (![context save:&error])
        {
            NSLog(@"error:%@",error);
        }
    }
}
//更新
- (void)updateData:(NSNumber *)objectId withItem:(NSString *)item
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
//    NSPredicate *predicate = [NSPredicate
//                              predicateWithFormat:@"newsid like[cd] %@",newsId];
    NSPredicate *predicate2 = [NSPredicate
                              predicateWithFormat:@"%@ like[cd] %@",item,objectId];
    //首先你需要建立一个request
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Test" inManagedObjectContext:context]];
    [request setPredicate:predicate2];//这里相当于sqlite中的查询条件，具体格式参考苹果文档
    
    //https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/Predicates/Articles/pCreating.html
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:request error:&error];//这里获取到的是一个数组，你需要取出你要更新的那个obj
//    for (UserInfo *info in result) {
//        info.userName = islook;
//    }
    
    //保存
    if ([context save:&error]) {
        //更新成功
        NSLog(@"更新成功");
    }
}
@end
