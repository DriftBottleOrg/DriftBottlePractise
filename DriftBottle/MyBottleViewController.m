//
//  MyBottleViewController.m
//  DriftBottle
//
//  Created by admin on 14-12-15.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "MyBottleViewController.h"
#import "EditSelfViewController.h"
#import "Bottle.h"
#import "BottleInfoViewController.h"
#import "NSUserDefaultsDao.h"
#import "UserInfo.h"
#import "Message.h"
#import "CoreDataManagement.h"
#import "MMM.h"

@interface MyBottleViewController ()
@property (strong, nonatomic) IBOutlet UIButton *Received;
@property (strong, nonatomic) IBOutlet UIButton *Posted;
@property (strong, nonatomic) IBOutlet UITableView *bottleTable;
@property (strong, nonatomic) BottleInfoViewController *bottleInfoViewController;
@property (strong, nonatomic) NSUserDefaultsDao *nsUserDefaultsDao;
@property double tableHeight;
@property NSString *status;
@property (strong, nonatomic) NSMutableArray *senderUserIdArray;
@property (strong, nonatomic)NSMutableArray *bottleArray2;
@end

@implementation MyBottleViewController
@synthesize bottleInfoViewController = _bottleInfoViewController,nsUserDefaultsDao = _nsUserDefaultsDao,bottleArray2 = _bottleArray2;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.Received setTitle:NSLocalizedString(@"received", nil) forState:UIControlStateNormal];
    [self.Posted setTitle:NSLocalizedString(@"posted", nil) forState:UIControlStateNormal];
    self.navigationItem.title = NSLocalizedString(@"myBottle", nil);
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.status = @"Received";
}
- (void)viewWillAppear:(BOOL)animated
{
    //if([self.view viewWithTag:1000]){
    UIView *view = [self.view viewWithTag:1000];
    if(view){
    [view removeFromSuperview];
    NSLog(@"here");
    }
    [self prepareForTable];
}


- (void)setBottleArray2:(NSMutableArray *)bottleArray2
{
    _bottleArray2 = bottleArray2;
}
- (NSMutableArray *)bottleArray2
{
//    if(!_bottleArray2){
//        _bottleArray2 = [[NSMutableArray alloc] init];
//    }
    return _bottleArray2;
}
- (NSUserDefaultsDao *)nsUserDefaultsDao
{
    if(!_nsUserDefaultsDao){
        _nsUserDefaultsDao = [[NSUserDefaultsDao alloc] init];
    }
    return _nsUserDefaultsDao;
}

- (IBAction)Received:(id)sender {
    if(![self.status isEqualToString:@"Received"]){
        UIView *view = [self.view viewWithTag:1000];
        if(view){
            [view removeFromSuperview];
        }
        self.status = @"Received";
        [self prepareForTable];
    }
}

- (IBAction)posted:(id)sender {
    if(![self.status isEqualToString:@"Posted"]){
        UIView *view = [self.view viewWithTag:1000];
        if(view){
            [view removeFromSuperview];
        }
        self.status = @"Posted";
        [self prepareForTable];
    }
}



//从storyBoard中获取某个UIViewController
- (id)getObject:(NSString *)objectId{
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyBoard instantiateViewControllerWithIdentifier:objectId];
}

//跳转的准备工作
- (void)prepareForSegue:(NSInteger *)row
{
    CoreDataManagement *dataManager = [[CoreDataManagement alloc] init];
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    if([self.status isEqualToString:@"Received"]){
        NSString *condition = @"senderUserId == 0";
        mutableArray = [dataManager selectData:10 andOffset:0 fromTable:@"Bottle" withCondition:condition];
        NSLog(@"Received");
    }else if([self.status isEqualToString:@"Posted"]){
        NSString *condition = @"senderUserId != 0";
        mutableArray = [dataManager selectData:10 andOffset:0 fromTable:@"Bottle" withCondition:condition];
    }
    
    _bottleInfoViewController = [self getObject:@"bottleInfoViewController"];
    Bottle *bottle = [mutableArray objectAtIndex:row];
    NSLog(@"before segue the bottle id is ------------ %@",bottle.bottleId);
    [_bottleInfoViewController setBottle:bottle];
    _bottleInfoViewController.index = row;
    _bottleInfoViewController.status = self.status;
    [self.navigationController pushViewController:_bottleInfoViewController animated:YES];
}



//这个方法返回该有几个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [self.friendsList count];
    NSLog(@"count is ============ %lu",(unsigned long)[self.bottleArray2 count]);
    return [self.bottleArray2 count];
}

//为UIViewController添加TableView
- (void)prepareForTable
{
    NSLog(@"prepareForTable");
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    CoreDataManagement *dataManager = [[CoreDataManagement alloc] init];
    
    
    if([self.status isEqualToString:@"Received"]){
        NSString *condition = @"senderUserId == 0";
        mutableArray = [dataManager selectData:10 andOffset:0 fromTable:@"Bottle" withCondition:condition];
        NSLog(@"Received");
    }else if([self.status isEqualToString:@"Posted"]){
        NSString *condition = @"senderUserId != 0";
        mutableArray = [dataManager selectData:10 andOffset:0 fromTable:@"Bottle" withCondition:condition];
    }
    
   
    if(mutableArray){
        self.bottleArray2 = [[NSMutableArray alloc] init];
        self.senderUserIdArray = [[NSMutableArray alloc] init];
        for (Bottle *bottle in mutableArray) {
            [self.bottleArray2 addObject:bottle];
            [self.senderUserIdArray addObject:bottle.senderUserId];
        }
       
        Bottle *bottle = [self.bottleArray2 objectAtIndex:0];
        NSLog(@"senderUserId is %@",bottle.senderUserId);
        
        self.tableHeight = [self.bottleArray2 count]*44;
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 122, 320, self.tableHeight) style:UITableViewStylePlain];
        [tableView setBackgroundColor:[UIColor grayColor]];
        self.bottleTable = tableView;
        self.bottleTable.dataSource = self;
        self.bottleTable.delegate = self;
        self.bottleTable.tag = 1000;
        [self.view addSubview:self.bottleTable];
    }
    
}



//自动调用，设置cell的样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
    }
    NSUInteger row = [indexPath row];
    CoreDataManagement *dataManager = [[CoreDataManagement alloc] init];

    NSString *senderUserId = [self.senderUserIdArray objectAtIndex:row];
    NSLog(@"senderUserId---------%@",senderUserId);
    NSString *condition2 = [NSString stringWithFormat:@"userId == %@",senderUserId];
    NSMutableArray *userMutableArray = [[NSMutableArray alloc] init];
    userMutableArray = [dataManager selectData:10 andOffset:1 fromTable:@"UserInfo" withCondition:condition2];

    UserInfo *user = [userMutableArray objectAtIndex:0];
    NSLog(@"userId ========= %@",user.userId);
    if (userMutableArray) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"this bottle was from:", nil),user.userName];
        //cell.imageView.image = user.headPicture;
        cell.imageView.image = [UIImage imageNamed:@"headPicture1"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"headPicture1"];
    }
   
    return cell;
}

//当点击某个cell时调用
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    NSLog(@"row is %lu,index is %@",(unsigned long)row,indexPath);
    
    [self prepareForSegue:row];
   // NSLog(@"this is a click%ld",(long)row);
    return indexPath;
}

//滑动之后可以进行删除删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    if([self.status isEqualToString:@"Received"]){
        NSMutableArray *mutableBottleArray = [self.nsUserDefaultsDao getObject:@"ReceivedBottleArray"];
        [mutableBottleArray removeObjectAtIndex:row];
        [self.nsUserDefaultsDao addObject:mutableBottleArray forKey:@"ReceivedBottleArray"];
    }else if([self.status isEqualToString:@"Posted"]){
        NSMutableArray *mutableBottleArray = [self.nsUserDefaultsDao getObject:@"PostedBottleArray"];
        [mutableBottleArray removeObjectAtIndex:row];
        [self.nsUserDefaultsDao addObject:mutableBottleArray forKey:@"PostedBottleArray"];
    }
    
    UIView *view = [self.view viewWithTag:1000];
    if(view){
        [view removeFromSuperview];
        NSLog(@"here");
    }
    [self prepareForTable];
}
@end
