//
//  TabBarViewController.m
//  DriftBottle
//
//  Created by admin on 14-12-17.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "TabBarViewController.h"
#import "Reachability.h"
#import "Bottle.h"
#import "Message.h"
#import "NSUserDefaultsDao.h"
#import "UserInfo.h"
#import <sqlite3.h>
#import "CoreDataManagement.h"
#import "Test2.h"
#import "Accessory.h"
#import "MMM.h"

@interface TabBarViewController ()
@property (strong, nonatomic)NSUserDefaultsDao *nsUserDefaultsDao;
@end

@implementation TabBarViewController
@synthesize nsUserDefaultsDao = _nsUserDefaultsDao;
- (NSUserDefaultsDao *)nsUserDefaultsDao
{
    if(!_nsUserDefaultsDao){
        _nsUserDefaultsDao = [[NSUserDefaultsDao alloc] init];
    }
    return _nsUserDefaultsDao;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [(UITabBarItem *)[self.tabBar.items objectAtIndex:0] setTitle:NSLocalizedString(@"fish", nil)];
    [(UITabBarItem *)[self.tabBar.items objectAtIndex:1] setTitle:NSLocalizedString(@"send", nil)];
    [(UITabBarItem *)[self.tabBar.items objectAtIndex:2] setTitle:NSLocalizedString(@"myBottle", nil)];
    [(UITabBarItem *)[self.tabBar.items objectAtIndex:3] setTitle:NSLocalizedString(@"friends", nil)];
    //判断网络类型，wifi/3G4G
    Reachability *netReach = [Reachability reachabilityForLocalWiFi];
    switch ([netReach currentReachabilityStatus]) {
        case NotReachable:
            NSLog(@"can't reach net");
            break;
        case ReachableViaWiFi:
            NSLog(@"net type:wifi");
            break;
        case ReachableViaWWAN:
            NSLog(@"net type:3G/4G");
            break;
        default:
            break;
    }
    // Do any additional setup after loading the view.
    
    [self saveBottle];
    //[self saveUserForDB];
}

//一开始的时候手动载入两个漂流瓶
- (void)saveBottle
{
//    sqlite3 *database;
//    sqlite3_open([[self dbPath] UTF8String], &database);
//    char *createSQL
    NSLog(@"savaBottle");
    
    CoreDataManagement *dataManager = [[CoreDataManagement alloc] init];
//    NSManagedObjectContext *context = [dataManager createDbContext];
//    
//    NSEntityDescription *mmmEntity = [NSEntityDescription entityForName:@"MMM" inManagedObjectContext:context];
//    MMM *mmm = [[MMM alloc] initWithEntity:mmmEntity insertIntoManagedObjectContext:context];
//
//    
//    NSEntityDescription *userInfoEntity = [NSEntityDescription entityForName:@"UserInfo" inManagedObjectContext:context];
//    UserInfo *Tom = [[UserInfo alloc] initWithEntity:userInfoEntity insertIntoManagedObjectContext:context];
//    UserInfo *Mike = [[UserInfo alloc] initWithEntity:userInfoEntity insertIntoManagedObjectContext:context];
//  
//    
//    NSEntityDescription *bottleEntity = [NSEntityDescription entityForName:@"Bottle" inManagedObjectContext:context];
//    Bottle *bottle0 = [[Bottle alloc] initWithEntity:bottleEntity insertIntoManagedObjectContext:context];
//    Bottle *bottle1 = [[Bottle alloc] initWithEntity:bottleEntity insertIntoManagedObjectContext:context];
//
//    
//    NSEntityDescription *messageEntity = [NSEntityDescription entityForName:@"Message" inManagedObjectContext:context];
//    Message *message00 = [[Message alloc] initWithEntity:messageEntity insertIntoManagedObjectContext:context];
//    Message *message11 = [[Message alloc] initWithEntity:messageEntity insertIntoManagedObjectContext:context];
//  
//    
//    NSEntityDescription *accessoryEntity = [NSEntityDescription entityForName:@"Accessory" inManagedObjectContext:context];
//    Accessory *accessory000 = [[Accessory alloc] initWithEntity:accessoryEntity insertIntoManagedObjectContext:context];
//    Accessory *accessory111 = [[Accessory alloc] initWithEntity:accessoryEntity insertIntoManagedObjectContext:context];
  
    
//    NSLog(@"saveBottle end");
//    [Tom setValue:@"Tom" forKey:@"userName"];
//    [Tom setValue:[NSNumber numberWithInt:1] forKey:@"userId"];
//    [Tom setValue:@"Tom cooper" forKey:@"realName"];
//    [Tom setValue:@"Anhui" forKey:@"userAddress"];
//    [Tom setValue:[NSNumber numberWithInt:1] forKey:@"log_UserId"];
//    [Tom setValue:@"ON" forKey:@"state"];
//    
////    Tom.userName = @"Tom";
////    Tom.userId = [NSNumber numberWithInt:1];
////    Tom.realName = @"Tom Cooper";
////    Tom.userAddress = @"Anhui";
////    Tom.log_UserId = [NSNumber numberWithInt:1];
////    Tom.state = @"ON";
//    
//    Mike.userName = @"Mike";
//    Mike.userId = [NSNumber numberWithInt:2];
//    Mike.realName = @"Mike Jakson";
//    Mike.userAddress = @"ShangHai";
//    Mike.log_UserId = [NSNumber numberWithInt:2];
//    Mike.state = @"ON";
//    
//    accessory000.accessoryId = [NSNumber numberWithInt:000];
//    accessory000.accessoryType = [NSNumber numberWithInt:0];
//    accessory000.accessoryURL = @"baidu.com";
//    message00.accessoryId = accessory000.accessoryId;
//    message00.messageId = [NSNumber numberWithInt:00];
//    message00.messageType = [NSNumber numberWithInt:0];
//    [message00 setValue:Tom.userId forKey:@"senderUserId"];
//    //message00.senderUserId = Tom.userId;
//    
//    //Bottle *bot = [[Bottle alloc] init];
//    //[bottle0 print:@"nihao"];
//    bottle0.bottleId = [NSNumber numberWithInt:0];
//    [bottle0 setValue:Tom.userId forKey:@"userId"];
//    //bottle0.userId = Tom.userId;
//    bottle0.bottleType = [NSNumber numberWithInt:0];
//    [bottle0 setValue:Tom.userId forKey:@"senderUserId"];
//    //bottle0.senderUserId = Tom.userId;
//    [message00 setValue:bottle0.bottleId forKey:@"bottleId"];
//    //message00.bottleId = bottle0.bottleId;
//
//    accessory111.accessoryId = [NSNumber numberWithInt:11];
//    accessory111.accessoryType = [NSNumber numberWithInt:0];
//    accessory111.accessoryURL = @"sina.com";
//    message11.accessoryId = accessory111.accessoryId;
//    message11.messageId = [NSNumber numberWithInt:11];
//    message11.messageType = [NSNumber numberWithInt:0];
//    [message11 setValue:Mike.userId forKey:@"senderUserId"];
//    //message11.senderUserId = Mike.userId;
//    bottle1.bottleId = [NSNumber numberWithInt:1];
//    [bottle1 setValue:Mike.userId forKey:@"userId"];
//    //bottle1.userId = Mike.userId;
//    bottle1.bottleType = [NSNumber numberWithInt:1];
//    [bottle1 setValue:Mike.userId forKey:@"senderUserId"];
//    //bottle1.senderUserId = Mike.userId;
//    [message11 setValue:bottle1.bottleId forKey:@"bottleId"];
    //message11.bottleId = bottle1.bottleId;

//    NSMutableArray *userInfoArray = [[NSMutableArray alloc] init];
//    NSMutableArray *bottleArray = [[NSMutableArray alloc] init];
//    NSMutableArray *accessoryArray = [[NSMutableArray alloc] init];
//    NSMutableArray *messageArray = [[NSMutableArray alloc] init];
//    [userInfoArray addObject:Tom];
//    [userInfoArray addObject:Mike];
//    [bottleArray addObject:bottle0];
//    [bottleArray addObject:bottle1];
//    [accessoryArray addObject:accessory000];
//    [accessoryArray addObject:accessory111];
//    [messageArray addObject:message00];
//    [messageArray addObject:message11];
    
//    [dataManager insertCoreData:Tom toTable:@"UserInfo"];
//    [dataManager insertCoreData:Mike toTable:@"UserInfo"];
//    [dataManager insertCoreData:bottle0 toTable:@"Bottle"];
//    [dataManager insertCoreData:bottle1 toTable:@"Bottle"];
//    [dataManager insertCoreData:message00 toTable:@"Message"];
//    [dataManager insertCoreData:message11 toTable:@"Message"];
//    [dataManager insertCoreData:accessory000 toTable:@"Accessory"];
//    [dataManager insertCoreData:accessory111 toTable:@"Accessory"];
    
    
    
    
    
//    mmm.id = [NSNumber numberWithInt:1];
//    mmm.name = @"mmmmmmmm";
//    [dataManager insertCoreData:mmm toTable:@"MMM"];
    
//    [dataManager insertUserInfoWithUserId:[NSNumber numberWithInt:0] andLog_UserId:[NSNumber numberWithInt:0] andUserName:@"Tom" andRealName:@"Tom Cooper" andUserAddress:@"Anhui" andState:@"ON"];
//    [dataManager insertUserInfoWithUserId:[NSNumber numberWithInt:1] andLog_UserId:[NSNumber numberWithInt:1] andUserName:@"Mike" andRealName:@"Mike Alan" andUserAddress:@"Shanghai" andState:@"ON"];
//    
//    [dataManager insertBottleWithBottleId:[NSNumber numberWithInt:10] andUserId:[NSNumber numberWithInt:0] andBottleType:[NSNumber numberWithInt:1] andSenderUserId:[NSNumber numberWithInt:0]];
//    [dataManager insertBottleWithBottleId:[NSNumber numberWithInt:20] andUserId:[NSNumber numberWithInt:1] andBottleType:[NSNumber numberWithInt:2] andSenderUserId:[NSNumber numberWithInt:1]];
//    
//    [dataManager insertMessageWithBottleId:[NSNumber numberWithInt:10] andMessageId:[NSNumber numberWithInt:100] andMessageType:[NSNumber numberWithInt:1] andSenderUserId:[NSNumber numberWithInt:0] andAccessoryId:[NSNumber numberWithInt:1000]];
//    [dataManager insertMessageWithBottleId:[NSNumber numberWithInt:20] andMessageId:[NSNumber numberWithInt:200] andMessageType:[NSNumber numberWithInt:2] andSenderUserId:[NSNumber numberWithInt:1] andAccessoryId:[NSNumber numberWithInt:3000]];
//    
//    [dataManager insertAccessoryWithBottleId:[NSNumber numberWithInt:10] andMessageId:[NSNumber numberWithInt:100] andAccessoryId:[NSNumber numberWithInt:1000] andAccessoryType:[NSNumber numberWithInt:1] andAccessoryURL:@"www.baidu.com"];
//    [dataManager insertAccessoryWithBottleId:[NSNumber numberWithInt:20] andMessageId:[NSNumber numberWithInt:200] andAccessoryId:[NSNumber numberWithInt:3000] andAccessoryType:[NSNumber numberWithInt:2] andAccessoryURL:@"www.sina.com"];
    
    NSLog(@"tabBar end");
    
}


- (NSString*)dbPath
{
    return @"";
}


//- (void)saveUserForDB
//{
//    NSLog(@"DB1");
////    Test2 *test = [[Test2 alloc] init];
////    test.name = @"testName";
////    test.gender = @"male";
//    UserInfo *Tom = [[UserInfo alloc] init];
//    [Tom setUserId:1];
//    [Tom setLogId:1];
//    [Tom setUserName:@"Tom"];
//    [Tom setRealName:@"Tom Weise"];
//    [Tom setAddress:@"China"];
//    //UIImage *image = [UIImage imageNamed:@"headPicture"];
//    //[Tom setHeadPicture:image];
//    CoreDataManagement *dataManager = [[CoreDataManagement alloc] init];
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    //[array addObject:Tom];
//    //[array addObject:test];
//    //[dataManager insertCoreData:array];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Test2" inManagedObjectContext:[dataManager managedObjectContext]];
//    
//    Test2 *test2 = [[Test2 alloc] initWithEntity:entity insertIntoManagedObjectContext:[dataManager managedObjectContext]];
//    test2.name = @"Haha";
//    test2.gender = @"female";
//    [array addObject:test2];
//    [dataManager insertCoreData:array];
//    NSLog(@"DB3");
//    
//    NSMutableArray *array2 = [[NSMutableArray alloc] init];
//    array2 = [dataManager selectData:2 andOffset:0];
//    NSLog(@"%@",array2);
//
//}


@end
