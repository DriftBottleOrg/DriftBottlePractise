//
//  AddFriendUIViewController.m
//  DriftBottle
//
//  Created by admin on 14-12-19.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "AddFriendUIViewController.h"

@interface AddFriendUIViewController ()

@end

@implementation AddFriendUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancel:(id)sender {
    NSLog(@"back");
    [self.navigationController popViewControllerAnimated:YES];
    [self returnToMainHandler:sender];
}

-(IBAction)returnToMainHandler:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
