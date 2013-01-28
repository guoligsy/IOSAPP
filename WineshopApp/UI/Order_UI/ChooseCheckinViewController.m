//
//  ChooseCheckinViewController.m
//  WineshopApp
//
//  Created by sy on 1/28/13.
//
//

#import "ChooseCheckinViewController.h"

@interface ChooseCheckinViewController ()

@end

@implementation ChooseCheckinViewController

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
    [self.rightBtn setHidden:YES];
    self.navigationItem.title = @"选择入住人";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    CGRect tRect = self.view.bounds;
    tRect.origin.x = 5;
    tRect.origin.y = 5;
    tRect.size.width -= 10;
    tRect.size.height = 170;
    chooseListTable = [[UITableView alloc] initWithFrame:tRect style:UITableViewStyleGrouped];
    chooseListTable.dataSource = self;
    chooseListTable.delegate = self;
    [chooseListTable setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:chooseListTable];

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
    static NSString *cellID = @"ChooseList";
    UITableViewCell *chooseCell = [chooseListTable dequeueReusableCellWithIdentifier:cellID];
    
    if (!chooseCell) {
        chooseCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(33, 5, 66, 30)];
        [tagLabel setBackgroundColor:[UIColor clearColor]];
        [tagLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
        [tagLabel setAdjustsFontSizeToFitWidth:YES];
        [tagLabel setTag:9990];
        [chooseCell.contentView addSubview:tagLabel];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 8, 26, 25)];
        [imgView setBackgroundColor:[UIColor clearColor]];
        [imgView setTag:9991];
        [chooseCell.contentView addSubview:imgView];
        
        UIButton *imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(265, 3, 30, 35)];
        imgBtn.tag = 9992;
        [imgBtn setImage:[UIImage imageNamed:@"Delete.jpg"] forState:UIControlStateNormal];
        [imgBtn setImage:[UIImage imageNamed:@"Delete_Sel.jpg"] forState:UIControlStateHighlighted];
        [chooseCell.contentView addSubview:imgBtn];
        [imgBtn addTarget:self action:@selector(delAction:) forControlEvents:UIControlStateHighlighted];
    }
    
    UILabel *label = (UILabel *)[chooseCell.contentView viewWithTag:9990];
    UIImageView *iconImg = (UIImageView *)[chooseCell.contentView viewWithTag:9991];
    UIButton *delBtn = (UIButton *)[chooseCell.contentView viewWithTag:9992];
    
    switch (indexPath.row) {
        case 0:
        {
            [delBtn setHidden:YES];
            [label setText:@"新增入住人"];
            [iconImg setImage:[UIImage imageNamed:@"AddNewer.jpg"]];
        }
            break;
            
        case 1:
        {
            [label setText:@"张三"];
            [iconImg setImage:[UIImage imageNamed:@"AddStatusCheck.jpg"]];
        }
            break;
            
        case 2:
        {
            [label setText:@"李四"];
            [iconImg setHidden:YES];
        }
            
        default:
            break;
    }
    
    return chooseCell;
}

//////// delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    float height = 40.0;
    return height;//根据状态判断
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, chooseListTable.frame.size.width, 40)] autorelease];
    [footView setBackgroundColor:[UIColor clearColor]];
    
    UIButton *footBtnOne = [UIButton buttonWithType:UIButtonTypeCustom];
    [footBtnOne setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footBtnOne addTarget:self action:@selector(footBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:footBtnOne];
    
    [footBtnOne setFrame:CGRectMake(15, 3, chooseListTable.frame.size.width - 30,35)];
    [footBtnOne setBackgroundImage:[UIImage imageNamed:@"YBigBtnImg.jpg"] forState:UIControlStateNormal];
    [footBtnOne setBackgroundImage:[UIImage imageNamed:@"YBigBtnImg_Sel.jpg"] forState:UIControlStateHighlighted];
    [footBtnOne setTitle:@"确认" forState:UIControlStateNormal];
    
    return footView;
}

- (void)footBtnClick:(id)sender
{

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
