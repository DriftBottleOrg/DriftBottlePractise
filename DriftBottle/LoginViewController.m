//
//  LoginViewController.m
//  DriftBottle
//
//  Created by admin on 14-12-17.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()

@property (strong, nonatomic)RegisterViewController *registerViewControler;
@end

@implementation LoginViewController
@synthesize userName,passWord,fishViewController,tabBarViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"LoginViewController");
   
    //if(!self.tabBarViewController){
        //self.tabBarViewController = [[TabBarViewController alloc] init];
    //    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     //   self.tabBarViewController = [storyBoard instantiateViewControllerWithIdentifier:@"tabBarViewController"];
    //}
    }

- (id)getObject:(NSString *)objectId{
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyBoard instantiateViewControllerWithIdentifier:objectId];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"LoginViewController.m viewWillAppear");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)register:(id)sender {
    if(!_registerViewControler){
        _registerViewControler = (RegisterViewController *)[self getObject:@"registerViewController"];
        [self.view addSubview:_registerViewControler.view];
    }
    
    
}

- (IBAction)click:(id)sender {
    //[self httpSynchronousRequest];
    
    NSString *_userName = self.userName.text;
    NSString *_passWord = self.passWord.text;
    [self compare:_userName and:_passWord];
    
    
}

- (void)compare: (NSString *) _userName and: (NSString *) _passWord
{
    if([_userName isEqualToString:@"admin"] && [_passWord isEqualToString:@"admin"]){
        [self goToTabBarViewController];
    }else{
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:nil
                                                           message:@"输入的用户名或密码有误"
                                                          delegate:self
                                                 cancelButtonTitle:@"Cancel"
                                                 otherButtonTitles:@"OK", nil];
        [alerView show];
        //[alerView release];
    }
    
}

- (void)alertView: (UIAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"button index is %li",(long)buttonIndex);
    if(buttonIndex==1){
        NSLog(@"1");
        self.userName.text = NULL;
        self.passWord.text = NULL;
    }
}

- (void)goToTabBarViewController
{
    //UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //self.fishViewController = [storyBoard instantiateViewControllerWithIdentifier:@"fish"];
    
   
    //[self.navigationController pushViewController:self.fishViewController animated:YES];
    //[self presentViewController:self.tabBarViewController animated:YES completion:nil];
    //self.fishViewController.view.backgroundColor = [UIColor blueColor];
    //[self.view.window sendSubviewToBack:self.view];
    if(!tabBarViewController){
        tabBarViewController = (TabBarViewController *)[self getObject:@"tabBarViewController"];
        [self.view addSubview:self.tabBarViewController.view];
    }
    
    //[self addChildViewController:self.tabBarViewController];
    
}

- (void)httpSynchronousRequest{
    
    NSLog(@"http");
    
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.0.105:8080/driftBottle_0400/Friends/myresource/226"]];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                          returningResponse:&response
                                                      error:&error];
    
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
     NSLog(@"http2");
    NSLog(@"error is %@",error);
    if (error == nil)
    {
        NSLog(@"data is %@",data);
        NSLog(@"string is %@",string);
        // 处理数据
    }
}
@end
