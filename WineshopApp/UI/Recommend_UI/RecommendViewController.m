//
//  RecommendViewController.m
//  WineshopApp
//
//  Created by sy on 1/7/13.
//
//

#import "RecommendViewController.h"
#import "RecommendListCell.h"
#import "RecommentDetailViewController.h"

@interface RecommendViewController ()

@end

@implementation RecommendViewController

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
        self.title = @"特别推荐";
        NSString *iconName = [NSString stringWithFormat:@"specialItem.png"];
        NSString *iconNameHL = [NSString stringWithFormat:@"specialItem.png"];
        UITabBarItem *barItem  = [[UITabBarItem alloc] initWithTitle:@"特别推荐" image:[UIImage imageNamed:iconName] tag:0];
        if ([barItem respondsToSelector:@selector(setFinishedSelectedImage:withFinishedUnselectedImage:)]) {
            [barItem setFinishedSelectedImage:[UIImage imageNamed:iconNameHL] withFinishedUnselectedImage:[UIImage imageNamed:iconName]];
        }
        self.tabBarItem = barItem;
        [barItem release];
        
//        self.navigationItem.leftBarButtonItem = nil;
    }
    return self;
}

-(void)loadView{
    [super loadView];
    [self.leftBtn setHidden:YES];
    
    _recommendList = [[UITableView alloc]initWithFrame:self.view.bounds];
    _recommendList.delegate = self;
    _recommendList.dataSource = self;
    _recommendList.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_recommendList];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
#pragma mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *recommendListCellIdentifier = @"recommendListCellIdentifier";
    RecommendListCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendListCellIdentifier];
    if(nil == cell) {
        cell = [[RecommendListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recommendListCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    [cell.titleImageView setImage:[UIImage imageNamed:@"hotelImage.png"]];
    [cell.titleLabel setText:@"中华人民共和国国宾馆"];
    [cell.dateLabel setText:@"入住有效期:从2012-12-12至2012-12-15"];
    [cell.recommendReasonLabel setText:@"推荐理由:价格非常优惠"];
    [cell.detailAddressLabel setText:@"阜成路33号"];
    [cell.addressLabel setText:@"陆家嘴"];
    [cell.priceLabel setText:@"1067"];
    [cell.discountLabel setText:@"0.65折起"];
    [cell setRating:5];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 92;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RecommentDetailViewController *detailVC = [[RecommentDetailViewController alloc]initWithNibName:@"RecommentDetailViewController" bundle:nil];
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
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
