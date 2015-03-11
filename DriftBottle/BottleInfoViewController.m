//
//  BottleInfoViewController.m
//  DriftBottle
//
//  Created by admin on 15-1-21.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "BottleInfoViewController.h"
#import "Bottle.h"
#import "Message.h"
#import "NSUserDefaultsDao.h"
#import "CoreDataManagement.h"

@interface BottleInfoViewController ()
@property (strong, nonatomic) Bottle *bottle;
@property (strong, nonatomic) NSMutableArray *messageArray;
@property (strong, nonatomic) IBOutlet UITableView *messageTable;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) NSUserDefaultsDao *nsUserDefaultsDao;
@property (strong, nonatomic) IBOutlet UIButton *Reply;
@property (strong, nonatomic) NSMutableArray *messageIdArray;
//@property (strong, nonatomic) NSString *bottleId;
@end

@implementation BottleInfoViewController
@synthesize bottle = _bottle,messageArray = _messageArray,index,status,bottleId;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareForTable];
    [self setTitle:NSLocalizedString(@"info", nil)];
    [self.Reply setTitle:NSLocalizedString(@"reply", nil) forState:UIControlStateNormal];
}


- (void)setBottle:(Bottle *)bottle
{
    //_bottle = bottle;
    _bottle.bottleId = bottle.bottleId;
    _bottle.bottleType= bottle.bottleType;
    _bottle.userId = bottle.userId;
    _bottle.senderUserId= bottle.senderUserId;
    NSLog(@"bottle.bottleId----%@;bottle.bottleType------%@",bottle.bottleId,bottle.bottleType);
    self.bottleId = bottle.bottleId;
}
- (Bottle *)bottle
{
    NSLog(@"++++++++bottle.bottleId----%@;bottle.bottleType------%@",_bottle.bottleId,_bottle.bottleType);
    if(!_bottle){
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:nil
                                                           message:@"内容为空"
                                                          delegate:self
                                                 cancelButtonTitle:@"Cancel"
                                                 otherButtonTitles:nil, nil];
        [alerView show];
        return nil;
    }
    return _bottle;
}
- (void)setMessageArray:(NSMutableArray *)messageArray
{
    _messageArray = messageArray;
}
- (NSMutableArray *)messageArray
{
    if(!_messageArray)
    {
        _messageArray = [[NSMutableArray alloc] init];
    }
    return _messageArray;
}
- (NSUserDefaultsDao *)nsUserDefaultsDao
{
    if(!_nsUserDefaultsDao){
        _nsUserDefaultsDao = [[NSUserDefaultsDao alloc] init];
    }
    return _nsUserDefaultsDao;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.messageIdArray count];
    //NSInteger i = 3;
    //return i;
}


- (void)prepareForTable
{
    
    
    
    //NSEntityDescription *bottleEntity = [NSEntityDescription entityForName:@"Bottle" inManagedObjectContext:[dataManager managedObjectContext]];
//    Bottle *bottle = [[Bottle alloc] initWithEntity:bottleEntity insertIntoManagedObjectContext:[dataManager managedObjectContext]];
//    bottle = [self.bottleArray objectAtIndex:row];
    NSLog(@"after segue the bottle id is -----------%@;status is -------- %@",self.bottleId,self.status);
    NSString *condition = [NSString stringWithFormat:@"bottleId = %@",self.bottleId];
    NSLog(@"after condition");
    
    CoreDataManagement *dataManager = [[CoreDataManagement alloc] init];
    NSMutableArray *messageMutableArray = [dataManager selectData:1 andOffset:1 fromTable:@"Message" withCondition:condition];
    self.messageIdArray = [[NSMutableArray alloc] init];
    for (Message *message in messageMutableArray){
        [self.messageIdArray addObject:message.messageId];
    }
    //self.messageArray = messageMutableArray;
    double height = [messageMutableArray count]*44;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 164, 320, height) style:UITableViewStylePlain];
    //tableView.dataSource = self;
    //tableView.delegate = self;
    [tableView setBackgroundColor:[UIColor grayColor]];
    self.messageTable = tableView;
    self.messageTable.dataSource = self;
    self.messageTable.delegate = self;
    self.messageTable.tag = 2000;
    [self.view addSubview:self.messageTable];
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellWithIdentifier];
    }
    NSUInteger row = [indexPath row];
    
    CoreDataManagement *dataManager = [[CoreDataManagement alloc] init];
    NSString *condition = [NSString stringWithFormat:@"messageId == %@",[self.messageIdArray objectAtIndex:row]];
    NSMutableArray *messageMutableArray = [dataManager selectData:1 andOffset:1 fromTable:@"Message" withCondition:condition];
    Message *message = [messageMutableArray objectAtIndex:0];
    cell.textLabel.text = [NSString stringWithFormat:@"nihao %@",message.accessoryId];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",message.messageType];
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSLog(@"row is %lu,index is %@",(unsigned long)row,indexPath);
    return indexPath;
}

//回复
- (IBAction)reply:(id)sender {
    CoreDataManagement *dataManager = [[CoreDataManagement alloc] init];
    
    NSEntityDescription *messageEntity = [NSEntityDescription entityForName:@"Message" inManagedObjectContext:[dataManager managedObjectContext]];
    Message *message = [[Message alloc] initWithEntity:messageEntity insertIntoManagedObjectContext:[dataManager managedObjectContext]];
    message.messageId = [NSNumber numberWithInt:10];
    message.messageType = [NSNumber numberWithInt:1010];
    message.accessoryId = [NSNumber numberWithInt:0];
    message.bottleId = self.bottleId;
    message.senderUserId = [NSNumber numberWithInt:0];
//    if([self.status isEqualToString:@"Received"]){
//        NSMutableArray *mutableBottleArray = [self.nsUserDefaultsDao getObject:@"ReceivedBottleArray"];
//        [mutableBottleArray replaceObjectAtIndex:self.index withObject:bottleData];
//        [self.nsUserDefaultsDao addObject:mutableBottleArray forKey:@"ReceivedottleArray"];
//    }else if([self.status isEqualToString:@"Posted"]){
//        NSMutableArray *mutableBottleArray = [self.nsUserDefaultsDao getObject:@"PostedBottleArray"];
//        [mutableBottleArray replaceObjectAtIndex:self.index withObject:bottleData];
//        [self.nsUserDefaultsDao addObject:mutableBottleArray forKey:@"PostedBottleArray"];
//    }
    UIView *view = [self.view viewWithTag:2000];
    [view removeFromSuperview];
    self.textView.text = nil;
    [self prepareForTable];
    //[self.friendsTable reloadData];
    //[mutableBottleArray removeObjectAtIndex:self.index];
    //[mutableBottleArray addObjec]
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//    NSArray *subViews = [self.view subviews];
//    for(UIView *view in subViews){
//        [view removeFromSuperview];
//    }
//}
@end
