//
//  NormalBottleViewController.m
//  DriftBottle
//
//  Created by admin on 14-12-25.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "NormalBottleViewController.h"
#import "Bottle.h"
#import "Message.h"
#import "NSUserDefaultsDao.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "CoreDataManagement.h"
#import "Accessory.h"

@interface NormalBottleViewController ()
@property (strong, nonatomic) IBOutlet UIButton *AddAccessory;
@property (strong, nonatomic) IBOutlet UIButton *Cancel;
@property (strong, nonatomic) IBOutlet UIButton *Send;

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) NSUserDefaultsDao *nsUserDefaultsDao;
@property (strong, nonatomic)NSMutableArray *accessorysArray;
@end

@implementation NormalBottleViewController
@synthesize nsUserDefaultsDao = _nsUserDefaultsDao,accessorysArray = _accessorysArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.AddAccessory setTitle:NSLocalizedString(@"addAccessory", nil) forState:UIControlStateNormal];
    [self.Cancel setTitle:NSLocalizedString(@"cancel", nil) forState:UIControlStateNormal];
    [self.Send setTitle:NSLocalizedString(@"send", nil) forState:UIControlStateNormal];
    // Do any additional setup after loading the view.
    //[self.textView setBackgroundColor:[UIColor yellowColor]];
    [self.textView setTextColor:[UIColor redColor]];
    //[self addAccessorys];
    
}

- (NSUserDefaultsDao *)nsUserDefaultsDao
{
    if(!_nsUserDefaultsDao){
        _nsUserDefaultsDao = [[NSUserDefaultsDao alloc] init];
    }
    return _nsUserDefaultsDao;
}

- (NSMutableArray *)accessorysArray
{
    if(!_accessorysArray){
        _accessorysArray = [[NSMutableArray alloc] init];
    }
    return _accessorysArray;
}

//发送瓶子
- (IBAction)send:(id)sender {
    CoreDataManagement *dataManager = [[CoreDataManagement alloc] init];
    
    NSEntityDescription *bottleEntity = [NSEntityDescription entityForName:@"Bottle" inManagedObjectContext:[dataManager managedObjectContext]];
    Bottle *bottle = [[Bottle alloc] initWithEntity:bottleEntity insertIntoManagedObjectContext:[dataManager managedObjectContext]];

    NSEntityDescription *messageEntity = [NSEntityDescription entityForName:@"Message" inManagedObjectContext:[dataManager managedObjectContext]];
    Message *message = [[Message alloc] initWithEntity:messageEntity insertIntoManagedObjectContext:[dataManager managedObjectContext]];
    
    NSEntityDescription *accessoryEntity = [NSEntityDescription entityForName:@"Accessory" inManagedObjectContext:[dataManager managedObjectContext]];
    Accessory *accessory = [[Accessory alloc] initWithEntity:accessoryEntity insertIntoManagedObjectContext:[dataManager managedObjectContext]];
    
    NSLog(@"send");
    accessory.accessoryId = [NSNumber numberWithInt:2];
    accessory.accessoryType = [NSNumber numberWithInt:1];
    accessory.accessoryURL = nil;
    NSLog(@"send end1");
    
    bottle.bottleId = [NSNumber numberWithInt:2];
    bottle.userId = [NSNumber numberWithInt:0];
    bottle.bottleType = [NSNumber numberWithInt:1];
    bottle.senderUserId = [NSNumber numberWithInt:0];
    NSLog(@"send end2");
    
    message.accessoryId = accessory.accessoryId;
    message.bottleId = bottle.bottleId;
    message.messageId = [NSNumber numberWithInt:2];
    message.messageType = [NSNumber numberWithInt:2];
    message.senderUserId = [NSNumber numberWithInt:0];
    NSLog(@"send end3");

    NSMutableArray *bottleArray = [[NSMutableArray alloc] init];
    NSMutableArray *accessoryArray = [[NSMutableArray alloc] init];
    NSMutableArray *messageArray = [[NSMutableArray alloc] init];
    [bottleArray addObject:bottle];
    [accessoryArray addObject:accessory];
    [messageArray addObject:message];
    
    [dataManager insertCoreData:bottleArray toTable:@"Bottle"];
    [dataManager insertCoreData:accessoryArray toTable:@"Accessory"];
    [dataManager insertCoreData:messageArray toTable:@"Message"];
    
    
}

- (IBAction)pick:(id)sender {
    
    if ([self isPhotoLibraryAvailable]){
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        [controller setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];// 设置类型
        //NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        //if ([self canUserPickPhotosFromPhotoLibrary]){
           // [mediaTypes addObject:( NSString *)kUTTypeImage];
        //}
        //if ([self canUserPickVideosFromPhotoLibrary]){
           // [mediaTypes addObject:( NSString *)kUTTypeMovie];
        //}
        UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypePhotoLibrary;
        controller.sourceType = sourcheType;
        controller.delegate = self;
        controller.allowsEditing = YES;
        [self.navigationController presentModalViewController:controller animated:YES];
        //[controller release];
        //[mediaTypes release];
        
    }
}

// 相册是否可用
- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary];
}

// 是否可以在相册中选择视频
//- (BOOL) canUserPickVideosFromPhotoLibrary{
//    return [self cameraSupportsMedia:( NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//}
//
//// 是否可以在相册中选择视频
//- (BOOL) canUserPickPhotosFromPhotoLibrary{
//    return [self cameraSupportsMedia:( NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//}
//选中并返回后
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //打印出字典中的内容
    //NSLog(@"get the media info: %@", info);
    //获取媒体类型
    NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //判断是静态图像还是视频
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        //获取用户编辑之后的图像
        UIImage* editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        //将该图像保存到媒体库中
       // UIImageWriteToSavedPhotosAlbum(editedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        [self.accessorysArray addObject:editedImage];
    }else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        //获取视频文件的url
        NSURL* mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
        //创建ALAssetsLibrary对象并将视频保存到媒体库
//        ALAssetsLibrary* assetsLibrary = [[ALAssetsLibrary alloc] init];
//        [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:mediaURL completionBlock:^(NSURL *assetURL, NSError *error) {
//            if (!error) {
//                NSLog(@"captured video saved with no error.");
//            }else
//            {
//                NSLog(@"error occured while saving the video:%@", error);
//            }
//        }];
//        [assetsLibrary release];
        [self.accessorysArray addObject:mediaURL];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self addAccessorys];
}
//取消选择
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"cancle");
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//增加附件视图
- (void)addAccessorys
{
    NSLog(@"count is %lu",(unsigned long)[self.accessorysArray count]);
    UIView *view = [self.view viewWithTag:2000];
    if(view){
        [view removeFromSuperview];
    }
    if(!([self.accessorysArray count] == 0)){
        NSLog(@"inininin");
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(30, 380, 210, 60)];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.tag = 2000;
    [self.view addSubview:tableView];
    }
}
//这个方法返回该有几个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.accessorysArray count];
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
    cell.textLabel.text = [NSString stringWithFormat:@"附件%lu",(unsigned long)row];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(160, 0, 40, cell.frame.size.height)];
    [button setTitle:@"删除" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    button.tag = row;
    [button addTarget:self action:@selector(deleteAccessory:) forControlEvents:UIControlEventTouchUpInside];
    
    //[self.view addSubview:button];
    [cell.contentView addSubview:button];
    return cell;
}
- (void)deleteAccessory:(UIButton *)sender
{
    NSLog(@"delete");
    [self.accessorysArray removeObjectAtIndex:sender.tag];
    NSLog(@"delete111");
    [self addAccessorys];
}

@end
