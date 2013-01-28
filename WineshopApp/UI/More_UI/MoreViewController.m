//
//  MoreViewController.m
//  WineshopApp
//
//  Created by sy on 1/7/13.
//
//

#import "MoreViewController.h"
#import "FeedBackViewController.h"
#import "HelpViewController.h"
#import "AboutUsViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"更多";
        NSString *iconName = [NSString stringWithFormat:@"moreItem.png"];
        NSString *iconNameHL = [NSString stringWithFormat:@"moreItem.png"];
        UITabBarItem *barItem  = [[UITabBarItem alloc] initWithTitle:@"更多" image:[UIImage imageNamed:iconName] tag:0];
        if ([barItem respondsToSelector:@selector(setFinishedSelectedImage:withFinishedUnselectedImage:)]) {
            [barItem setFinishedSelectedImage:[UIImage imageNamed:iconNameHL] withFinishedUnselectedImage:[UIImage imageNamed:iconName]];
        }
        self.tabBarItem = barItem;
        [barItem release];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self.leftBtn setHidden:YES];
    
    CGRect tRect = self.view.bounds;
    tRect.origin.x = 5;
    tRect.origin.y = 5;
    tRect.size.width -= 10;
    tRect.size.height = 140;
    
    moreTabel = [[UITableView alloc] initWithFrame:tRect style:UITableViewStyleGrouped];
    moreTabel.delegate = self;
    moreTabel.dataSource = self;
    [moreTabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:moreTabel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark -
#pragma mark tableviewDelegate & datasource
///////// datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"moreCell";
    UITableViewCell *moreCell = [moreTabel dequeueReusableCellWithIdentifier:cellID];
    
    if (!moreCell) {
        moreCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        moreCell.selectionStyle=UITableViewCellSelectionStyleNone;
        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, moreCell.frame.size.width - 10, 30)];
        [tagLabel setBackgroundColor:[UIColor clearColor]];
        [tagLabel setTag:9990];
        [moreCell.contentView addSubview:tagLabel];
    }
    
    UILabel *label = (UILabel *)[moreCell.contentView viewWithTag:9990];
    switch (indexPath.row) {
        case 0:
        {
            [label setText:@"帮助"];
        }
            break;
            
        case 1:
        {
            [label setText:@"反馈"];
        }
            break;
            
        case 2:
        {
            [label setText:@"关于我们"];
        }
            break;
            
        default:
            break;
    }
    
    return moreCell;
}
//////// delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            HelpViewController *helpVC = [[HelpViewController alloc] init];
            [self.navigationController pushViewController:helpVC animated:YES];
            [helpVC release];
        }
            break;
            
        case 1:
        {
            FeedBackViewController *feedBackVC = [[FeedBackViewController alloc] init];
             feedBackVC.navigationItem.title = @"反馈";
            [self.navigationController pushViewController:feedBackVC animated:YES];
            [feedBackVC release];
        }
            break;
            
        case 2:
        {
            AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc] init];
            [self.navigationController pushViewController:aboutUsVC animated:YES];
            [aboutUsVC release];
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
