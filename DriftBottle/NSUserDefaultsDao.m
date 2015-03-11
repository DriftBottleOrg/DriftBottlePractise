//
//  NSUserDefaultsDao.m
//  DriftBottle
//
//  Created by admin on 15-1-23.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "NSUserDefaultsDao.h"

@interface NSUserDefaultsDao()
@property (strong, nonatomic)NSUserDefaults *nsUserDefaults;
@end

@implementation NSUserDefaultsDao
@synthesize nsUserDefaults = _nsUserDefaults;

- (NSUserDefaults *)nsUserDefaults
{
    if(!_nsUserDefaults){
        _nsUserDefaults = [NSUserDefaults standardUserDefaults];
    }
    return _nsUserDefaults;
}

- (NSUserDefaults *)getNSUserDefaultsObject
{
    return self.nsUserDefaults;
}

- (void)addObject:(id)object forKey:(NSString *)key
{
    NSLog(@"addObject forKey");
    [self.nsUserDefaults setObject:object forKey:key];
    [self.nsUserDefaults synchronize];
}

- (void)removeObject:(id)object forKey:(NSString *)key
{
    //[self.nsUserDefaults ]
}

- (id)getObject:(NSString *)key
{
    return [self.nsUserDefaults objectForKey:key];
}

@end
