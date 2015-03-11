//
//  FishViewController.m
//  DriftBottle
//
//  Created by admin on 14-12-15.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "FishViewController.h"

@interface FishViewController ()
@property (strong, nonatomic) IBOutlet UILabel *FishBottle;
@property (strong, nonatomic) IBOutlet UIButton *FishFish;

@end

@implementation FishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.FishBottle.text = NSLocalizedString(@"fishBottle", nil);
    [self.FishFish setTitle:NSLocalizedString(@"fishFish", nil) forState:UIControlStateNormal];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(40, 50, 60, 30)];
    [self.view addSubview:button];
    NSLog(@"FishViewController");
    // Do any additional setup after loading the view.
}


- (IBAction)fish:(id)sender {
    
    self.navigationController.navigationBar.userInteractionEnabled=NO;//将nav事件禁止
    
    self.tabBarController.tabBar.userInteractionEnabled=NO;//将tabbar事件禁止
    
    self.view.userInteractionEnabled=NO;//界面
    if([self.view viewWithTag:10000]){
        UIView *subView = [self.view viewWithTag:10000];
        [subView removeFromSuperview];
    }
    CGRect frame = CGRectMake(50, 100, 200, 200);
    //frame.size = [UIImage imageNamed:status].size;
    NSData *gif = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fishGif" ofType:@"gif"]];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
    webView.userInteractionEnabled = NO;
    webView.tag = 10000;
    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self.view addSubview:webView];
    [self performSelector:@selector(finishFish) withObject:nil afterDelay:4.0f];

    
}

- (void)fishBottle:(NSString *)status
{
    
    CGRect frame = CGRectMake(50, 100, 200, 200);
    //frame.size = [UIImage imageNamed:status].size;
    //NSLog(@"height is %f,width is %f",frame.size.height,frame.size.width);
    NSData *gif = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:status ofType:@"gif"]];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
    webView.userInteractionEnabled = NO;
    webView.tag = 20000;
    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self.view addSubview:webView];
    [self performSelector:@selector(fishSucceedOrNot) withObject:nil afterDelay:2.0f];
                
}

- (void)finishFish
{
    int chance = arc4random()%6 + 1;
    UIView *view = [self.view viewWithTag:10000];
    [view removeFromSuperview];
    if(chance < 4){
        [self fishBottle:@"fishFailGif"];
    }else{
        [self fishBottle:@"fishSucceedGif"];
    }
}
- (void)fishSucceedOrNot
{
    UIView *view = [self.view viewWithTag:20000];
    [view removeFromSuperview];
    self.navigationController.navigationBar.userInteractionEnabled=YES;//将nav事件激活
    
    self.tabBarController.tabBar.userInteractionEnabled=YES;//将tabbar事件激活
    
    self.view.userInteractionEnabled=YES;//界面
}



@end
