//
//  ViewController.m
//  DriftBottle
//
//  Created by admin on 14-12-13.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "ViewController.h"
#import "TabBarViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize tabBarViewController,fishViewController,loginViewController;

//- (IBAction)click:(id)sender
//{
    //if(!self.tabBarViewController){
    //    self.tabBarViewController=[[TabBarViewController alloc] init];
       // [self.view addSubview:self.tabBarViewController.view];
   // }
 //   if(!self.fishViewController){
 //       self.fishViewController=[[FishViewController alloc] init];
 //       [self.view addSubview:self.fishViewController.view];
  //      [self.view insertSubview:self.fishViewController.view atIndex:3];
  //  }else{
  //      [self.fishViewController.view removeFromSuperview];
  //  }
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if(!self.loginViewController){
        self.loginViewController = [[LoginViewController alloc] init];
        self.loginViewController.userName.text = @"userName";
        //[self.view addSubview:self.loginViewController.view];
        [self.loginViewController.view setFrame:CGRectMake(0, 0, 100, 100)];
        [self addChildViewController:self.loginViewController];
    }
    
    
    NSLog(@"sd++%@",self.loginViewController.userName.text);
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
