//
//  ThrowViewController.h
//  DriftBottle
//
//  Created by admin on 14-12-15.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThrowViewController : UIViewController

-(NSDictionary *) GetBottleDicWithUserId:(NSString *) userId bottleType:(NSString *) bottleType messageText:(NSString *) message;
@end
