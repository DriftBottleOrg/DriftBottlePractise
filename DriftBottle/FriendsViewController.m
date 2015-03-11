//
//  FriendsViewController.m
//  DriftBottle
//
//  Created by admin on 14-12-15.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "FriendsViewController.h"
#import "EditSelfViewController.h"

@interface FriendsViewController ()

@property (strong,nonatomic) NSMutableArray *friendsList;

@property (strong, nonatomic) IBOutlet UITableView *friendsTable;

@end

@implementation FriendsViewController
@synthesize give;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.friendsList count];
    //NSInteger i = 3;
    //return i;
}

//-(void)tableView:numBerOfRowsInSection
//{
//    
//}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"edit"]) {
        if([segue.destinationViewController isKindOfClass:[EditSelfViewController class]]){
            EditSelfViewController *esvc=(EditSelfViewController *)segue.destinationViewController;
            self.give=@"过来了";
            esvc.get=self.give;
           // esvc.get=@"过来了";
        }
    }
}

- (void)prepareForTable
{
    NSMutableArray *list = [NSMutableArray arrayWithObjects:@"Tom",@"Mike",@"Lucy",@"Sheldon",@"Leonard",@"Raj",@"Amy",@"Java",@"C",@"C++",@"C#",@"J2EE",@"JSP",@"Objective-C", nil];
    self.friendsList = list;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 122, 320, 397) style:UITableViewStylePlain];
    //tableView.dataSource = self;
    //tableView.delegate = self;
    [tableView setBackgroundColor:[UIColor grayColor]];
    self.friendsTable = tableView;
    self.friendsTable.dataSource = self;
    self.friendsTable.delegate = self;
    [self.view addSubview:self.friendsTable];
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellWithIdentifier];
    }
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [self.friendsList objectAtIndex:row];
//    cell.imageView.image =;
    cell.detailTextLabel.text = @"详细信息";
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSLog(@"row is %lu,index is %@",(unsigned long)row,indexPath);
    return indexPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareForTable];
   
}




@end
