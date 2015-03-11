//
//  NSUserDefaultsDao.h
//  DriftBottle
//
//  Created by admin on 15-1-23.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaultsDao : NSObject

- (NSUserDefaults *)getNSUserDefaultsObject;

- (void)addObject:(id)object forKey:(NSString *)key;
- (id)getObject:(NSString *)key;

@end
