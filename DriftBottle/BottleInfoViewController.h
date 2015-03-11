//
//  BottleInfoViewController.h
//  DriftBottle
//
//  Created by admin on 15-1-21.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bottle.h"

@interface BottleInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property  NSUInteger *index;
@property NSString *status;
@property NSNumber *bottleId;
- (void)setBottle:(Bottle *)bottle;
- (Bottle *)bottle;

@end
