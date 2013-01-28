//
//  SelectionListViewController.m
//  WineshopApp
//
//  Created by sy on 1/28/13.
//
//

#import "SelectionListViewController.h"
#import "SearchViewController.h"

@interface SelectionListViewController ()

@end

@implementation SelectionListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [roomListArr release];
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    [self.rightBtn setHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    CGRect tRect = self.view.bounds;
    tRect.origin.x = 5;
    tRect.origin.y = 5;
    tRect.size.width -= 10;
    tRect.size.height = 210;
    listTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    listTableView.dataSource = self;
    listTableView.delegate = self;
    [self.view addSubview:listTableView];
    listTableView.backgroundColor = [UIColor clearColor];
    
    roomListArr = [[NSArray alloc] initWithObjects:@"1间",@"2间",@"3间",@"4间", nil];
    starListArr = [[NSArray alloc] initWithObjects:@"不限",@"三星级",@"四星级",@"五星级", nil ];
    priceListArr = [[NSArray alloc] initWithObjects:@"不限",@"￥1000以下",@"￥1000~￥1500",@"￥1600~￥2000",@"￥2000以上", nil];
}

#pragma mark -
#pragma mark tableviewDelegate & datasource
///////// datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowNum = 0;
    if ([self.navigationItem.title isEqualToString:@"价格"]) {
        rowNum = [priceListArr count];
    }
    else if([self.navigationItem.title isEqualToString:@"星级"])
    {
        rowNum = [starListArr count];
    }
    else
    {
        rowNum = [roomListArr count];
    }
    
    return rowNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"ChooseList";
    UITableViewCell *chooseCell = [listTableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!chooseCell) {
        chooseCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 5, 290, 30)];
        [tagLabel setBackgroundColor:[UIColor clearColor]];
        [tagLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
        [tagLabel setAdjustsFontSizeToFitWidth:YES];
        [tagLabel setTag:9990];
        [chooseCell.contentView addSubview:tagLabel];
    }
    
    UILabel *label = (UILabel *)[chooseCell.contentView viewWithTag:9990];
    if ([self.navigationItem.title isEqualToString:@"价格"]) {
        [label setText:[priceListArr objectAtIndex:indexPath.row]];
    }
    else if([self.navigationItem.title isEqualToString:@"星级"])
    {
        [label setText:[starListArr objectAtIndex:indexPath.row]];
    }
    else
    {
        [label setText:[roomListArr objectAtIndex:indexPath.row]];
    }
    return chooseCell;
}

//////// delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int i = [self.navigationController.viewControllers count];
    if (i>=2) {
        UIViewController *viewController = (UIViewController *)[self.navigationController.viewControllers objectAtIndex:(i-2)];
        if ([viewController isKindOfClass:[SearchViewController class]]) {
            if ([self.navigationItem.title isEqualToString:@"价格"]) {
                ((SearchViewController *)viewController).priceStr = [priceListArr objectAtIndex:indexPath.row];
            }
            else if([self.navigationItem.title isEqualToString:@"星级"])
            {
               ((SearchViewController *)viewController).starStr = [starListArr objectAtIndex:indexPath.row];
            }
        }
    }

    [self.navigationController popViewControllerAnimated:YES];
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
