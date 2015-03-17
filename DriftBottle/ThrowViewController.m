//
//  ThrowViewController.m
//  DriftBottle
//
//  Created by admin on 14-12-15.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "ThrowViewController.h"
#define  URL_THROWBOTTLE @"http://192.168.0.108:8080/driftBottle/Friends/mybottle/sendNewBottle"
@interface ThrowViewController ()
@property (strong, nonatomic) IBOutlet UIButton *NormalBottle;
@property (strong, nonatomic) IBOutlet UIButton *WishBottle;
@property (strong, nonatomic) IBOutlet UIButton *QuestionBottle;

@end

@implementation ThrowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.NormalBottle setTitle:NSLocalizedString(@"normalBottle", nil) forState:UIControlStateNormal];
    [self.WishBottle setTitle:NSLocalizedString(@"wishBottle", nil) forState:UIControlStateNormal];
    [self.QuestionBottle setTitle:NSLocalizedString(@"questionBottle", nil) forState:UIControlStateNormal];
    
    //send bottle Json
    //NSDictionary *bottleDic = [self GetBottleDicWithUserId:  bottleType:<#(NSString *)#> messageText:<#(NSString *)#>]
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ----GetBottleDic-----

-(NSDictionary *) GetBottleDicWithUserId:(NSString *) userId bottleType:(NSString *) bottleType messageText:(NSString *) message
{
    NSMutableDictionary *dic  = [NSMutableDictionary dictionary];
    [dic setValue:userId forKey:@"userId"];
    [dic setValue:bottleType forKey:@"bottleType"];
    [dic setValue:message forKey:@"massageText"];
    
    return [NSDictionary dictionaryWithDictionary:dic];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
