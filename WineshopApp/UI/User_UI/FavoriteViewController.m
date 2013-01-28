//
//  FavoriteViewController.m
//  WineshopApp
//
//  Created by gsy on 13-1-24.
//
//

#import "FavoriteViewController.h"

@interface FavoriteViewController ()

@end

@implementation FavoriteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    self.navigationItem.title = @"我的收藏";
    [self.rightBtn setImage:nil forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"退出" forState:UIControlStateNormal];
    
    CGRect tRect = self.view.bounds;
    tRect.origin.x = 5;
    tRect.origin.y = 5;
    tRect.size.width -= 10;
    tRect.size.height = 90;
    
    collectTable = [[UITableView alloc] initWithFrame:tRect style:UITableViewStyleGrouped];
    collectTable.delegate = self;
    collectTable.dataSource = self;
    [collectTable setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:collectTable];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark -
#pragma mark tableviewDelegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"collectCell";
    UITableViewCell *userCollectCell = [collectTable dequeueReusableCellWithIdentifier:cellID];
    
    if (!userCollectCell) {
        userCollectCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
    }
    
    [userCollectCell.textLabel setText:@"上海浦东香格里拉大酒店"];
    [userCollectCell.detailTextLabel setText:@"富城路33号"];
    
    return userCollectCell;
}
//////// delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
