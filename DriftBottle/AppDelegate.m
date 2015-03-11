//
//  AppDelegate.m
//  DriftBottle
//
//  Created by admin on 14-12-13.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //监听网络状态，当网络状态发生改变时，通知给默认通知中心。
    
    //使用通知中心监听 kReachabilityChangedNotification通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    //获取Reachability对象
    Reachability* netReach =[Reachability reachabilityForLocalWiFi];
    //让该Reachability对象启动 被监听
    [netReach startNotifier];
    // Override point for customization after application launch.
    return YES;
}
-(void) reachabilityChanged:(NSNotification *) note
{
    //通过 通知对象 获取被监听的Reachability对象
    Reachability *curReach = [note object];
    //获取 Reachability对象的网络状态。
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if(status ==NotReachable)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"网络已断开" delegate:nil cancelButtonTitle:@"YES" otherButtonTitles: nil];
        [alert show];
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
