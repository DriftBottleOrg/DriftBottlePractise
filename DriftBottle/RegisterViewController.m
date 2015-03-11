//
//  RegisterViewController.m
//  DriftBottle
//
//  Created by admin on 14-12-17.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "RegisterViewController.h"
#import "TabBarViewController.h"
#import "LogInformation.h"

@interface RegisterViewController ()

@property (strong, nonatomic) IBOutlet UITextField *userNameOutlet;
@property (strong, nonatomic) IBOutlet UITextField *passWordOutlet;
@property (strong, nonatomic) IBOutlet UITextField *passWordAgainOutlet;

@property (strong, nonatomic)NSString *userName;
@property (strong, nonatomic)NSString *passWord;
@property (strong, nonatomic)NSString *passWordAgain;

//@property (strong, nonatomic)LogInformation *logInformation;
@property (strong, nonatomic) LogInformation *logInformation;
@property (strong, nonatomic)TabBarViewController *tabBarViewController;


@end

@implementation RegisterViewController


- (NSString *)userName{
    if(!_userName){
        _userName = self.userNameOutlet.text;
    }
    return _userName;
}

- (NSString *)passWord
{
    if(!_passWord){
        _passWord = self.passWordOutlet.text;
    }
    return _passWord;
}

- (NSString *)passWordAgain
{
    if(!_passWordAgain){
        _passWordAgain = self.passWordAgainOutlet.text;
    }
    return _passWordAgain;
}

- (TabBarViewController *)tabBarViewController
{
    if(!_tabBarViewController){
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _tabBarViewController = [storyBoard instantiateViewControllerWithIdentifier:@"tabBarViewController"];
    }
    return _tabBarViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)Register:(id)sender {
        NSLog(@"asas %d",[self.passWord isEqualToString:self.passWordAgain]);
    if([self.passWord isEqualToString:self.passWordAgain])
    {
        if(!self.logInformation){
            self.logInformation = [[LogInformation alloc] init];
            self.logInformation.userName = self.userName;
            self.logInformation.passWord = self.passWord;
            
            //存储用户的用户名和密码
            [self storeUserNameAndPassWord:self.logInformation];
            
            //跳转到主界面————捞瓶子的界面
            [self goToTabBarViewController];
        }
    }else{
        
        //如果输入两次密码不等，弹出提示框
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:nil
                                                           message:@"输入的用户名或密码有误"
                                                          delegate:self
                                                 cancelButtonTitle:@"Cancel"
                                                 otherButtonTitles:@"OK", nil];
        [alerView show];

    }
}

- (void)storeUserNameAndPassWord:(LogInformation *)userNameAndPassWord
{
    
    //ASIFormDataRequest *rq = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"ww.baidu.com"]];
    //NSString *postStr = [NSString stringWithFormat:@"body=%@",userNameAndPassWord];
    NSString *postStr = @"this is my post";
    NSData *postData = [postStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    //NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSURLResponse * response = nil;
    NSError * error = nil;
    
    [request setURL:[NSURL URLWithString:@"http://192.168.0.105:8080/driftBottle_0400/Friends/myresource/add"]];
    [request setHTTPMethod:@"POST"];
    
    //NSMutableData *data = [[NSMutableData alloc] init];
    //[data setValue:userNameAndPassWord forKey:@"uAndP"];
    [request setHTTPBody:postData];
    
    NSData * returnData = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    
    NSString *string = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"error is %@",error);
    if(error == nil){
    
    NSLog(@"return data to String is %@",string);
    }
    
}

- (void)goToTabBarViewController
{
    //UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   // self.fishViewController = [storyBoard instantiateViewControllerWithIdentifier:@"fish"];
    
    
    //[self.navigationController pushViewController:self.fishViewController animated:YES];
    //[self presentViewController:self.tabBarViewController animated:YES completion:nil];
    //self.fishViewController.view.backgroundColor = [UIColor blueColor];
    //[self.view.window sendSubviewToBack:self.view];
    [self.view addSubview:self.tabBarViewController.view];
    //[self addChildViewController:self.tabBarViewController];
    
}




@end
