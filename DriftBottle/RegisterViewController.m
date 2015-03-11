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
#define URL_REGISTER @"http://192.168.0.108:8080/driftBottle/Friends/myresource/registUser"

@interface RegisterViewController ()

@property (strong, nonatomic) IBOutlet UITextField *userNameOutlet;
@property (strong, nonatomic) IBOutlet UITextField *passWordOutlet;
@property (strong, nonatomic) IBOutlet UITextField *passWordAgainOutlet;



//@property (strong, nonatomic)LogInformation *logInformation;
@property (strong, nonatomic) LogInformation *logInformation;
@property (strong, nonatomic)TabBarViewController *tabBarViewController;


@end

@implementation RegisterViewController

-(UserService *) userService{
    if(!_userService){
        _userService = [[UserService alloc] init];
    }
    return _userService;
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
    NSString *userName = self.userNameOutlet.text;
    NSString *passWord = self.passWordOutlet.text;
    NSString *passWordAgain = self.passWordAgainOutlet.text;
    
    self.userService.delegate = self;
    if([passWord isEqualToString:passWordAgain])
    {
        if([self.userService verifyName:userName andPassword:passWord])
        {
            NSURL *url = [NSURL URLWithString:URL_REGISTER];
            __weak  ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
            
            [request setPostValue:userName forKey:@"userName"];
            [request setPostValue:passWord forKey:@"passwd"];
            
            [request setRequestMethod:@"POST"];
            [request setTimeOutSeconds:20];
            
            request.delegate = self;
            request.tag = 100;
            @try {
                [request startAsynchronous];
            }
            @catch (NSException *exception) {
                [self showAlertWithTitle:@"提示" Message:@"注册失败，请稍后再试" CancelButton:nil OtherButton:@"OK",nil];
            }
            
            
            [request setCompletionBlock:^{
                NSString *responseStr = [request responseString];
                NSLog(@"%@",responseStr);// return UserId
                [self goToTabBarViewController];
            }];
            
            [request setFailedBlock:^{
                [self showAlertWithTitle:@"提示" Message:@"注册失败，请稍后再试" CancelButton:nil OtherButton:@"OK",nil];
                NSError *error = [request error];
                NSLog(@"%@",[error localizedDescription]);
                return;
            }];
            //当服务器内部错误的时候，应该怎么提示。
//            NSError *err = [request error];
//            if(!err)
//            {
//                 [self showAlertWithTitle:@"提示" Message:@"注册失败，请稍后再试" CancelButton:nil OtherButton:@"OK",nil];
//                return;
//            }
            
                //跳转到主界面————捞瓶子的界面
               //
            
        }
    
    }
    else
    {
       
        //如果输入两次密码不等，弹出提示框
        [self showAlertWithTitle:nil Message:@"两次输入密码不相同" CancelButton:nil OtherButton:@"OK",nil];
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
    NSData * returnData = [[NSData alloc] init];
   
        returnData = [NSURLConnection sendSynchronousRequest:request
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

//弹出提示框
-(void) showAlertWithTitle:(NSString *) title Message:(NSString *)message CancelButton:(NSString *)cancelButton OtherButton:(NSString *) otherButton, ...
{
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:title
                                                       message:message
                                                      delegate:self
                                             cancelButtonTitle:cancelButton
                                             otherButtonTitles:otherButton, nil];
    [alerView show];

}
#pragma mark -----实现协议方法--------
-(void) userService:(UserService *)userService ParametersError:(ErrorType)errorType
{
    switch (errorType) {
        case NullUserNameError:
        case NullPasswordError:
            [self showAlertWithTitle:@"提示" Message:@"用户名或密码不能为空" CancelButton:nil OtherButton:@"OK",nil];
            break;
        case UserNameError:
            [self showAlertWithTitle:@"提示" Message:@"用户名必须是11位手机号" CancelButton:nil OtherButton:@"OK",nil];
            break;
        case PasswordError:
            [self showAlertWithTitle:@"提示" Message:@"密码不能包含特殊字符" CancelButton:nil OtherButton:@"OK",nil];
            break;
            
        default:
            break;
    }
    
}



@end
