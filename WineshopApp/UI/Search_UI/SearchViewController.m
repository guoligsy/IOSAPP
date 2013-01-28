//
//  SearchViewController.m
//  WineshopApp
//
//  Created by sy on 1/7/13.
//
//

#import "SearchViewController.h"
#import "SelectionListViewController.h"
#import "ChooseCityViewController.h"
#import "LocationViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize priceStr,starStr,cityName,areaName;

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
        self.title = @"查找";
        NSString *iconName = [NSString stringWithFormat:@"searchItem.png"];
        NSString *iconNameHL = [NSString stringWithFormat:@"searchItem.png"];
        UITabBarItem *barItem  = [[UITabBarItem alloc] initWithTitle:@"查找" image:[UIImage imageNamed:iconName] tag:0];
        if ([barItem respondsToSelector:@selector(setFinishedSelectedImage:withFinishedUnselectedImage:)]) {
            [barItem setFinishedSelectedImage:[UIImage imageNamed:iconNameHL] withFinishedUnselectedImage:[UIImage imageNamed:iconName]];
        }
        self.tabBarItem = barItem;
        [barItem release];
        
//        self.navigationItem.leftBarButtonItem = nil;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self.leftBtn setHidden:YES];
    self.navigationItem.title = @"果粒特惠酒店";
    
    CGRect tRect = self.view.bounds;
    tRect.origin.x = 5;
    tRect.origin.y = 5;
    tRect.size.width -= 10;
    tRect.size.height = 340;
    searchTabel = [[UITableView alloc] initWithFrame:tRect style:UITableViewStyleGrouped];
    searchTabel.delegate = self;
    searchTabel.dataSource = self;
    [searchTabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:searchTabel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (starStr != nil) {
        if (starLabel) {
            [starLabel setText:starStr];
        }
    }
    
    if (priceStr != nil) {
        if (priceLabel) {
            [priceLabel setText:priceStr];
        }
    }
    
    if (cityName != nil) {
        if (cityLabel) {
            [cityLabel setText:cityName];
        }
    }
    
    if (areaName != nil) {
        if (areaLabel) {
            [areaLabel setText:areaName];
        }
    }
}

- (void)btnClick
{

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(void)addDatePicker{
    if (!backView) {
        backView = [[UIImageView alloc]initWithFrame:CGRectMake(0,  150 + (isIPHONE5?88:0), self.view.frame.size.width, 40)];
        [backView setBackgroundColor:[UIColor blackColor]];
        UIButton* cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton setBackgroundImage:[UIImage imageNamed:@"NavBtn_WithTitle_Normal.jpg"] forState:UIControlStateNormal];
        [cancelButton setBackgroundImage:[UIImage imageNamed:@"NavBtn_WithTitle_Sel.jpg"] forState:UIControlStateHighlighted];
        UIButton* OKButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [OKButton setBackgroundImage:[UIImage imageNamed:@"NavBtn_WithTitle_Normal.jpg"] forState:UIControlStateNormal];
        [OKButton setBackgroundImage:[UIImage imageNamed:@"NavBtn_WithTitle_Sel.jpg"] forState:UIControlStateHighlighted];
        
        [cancelButton setFrame:CGRectMake(5, 3, 70, 34)];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitle:@"取消" forState:UIControlStateHighlighted];
        [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [cancelButton addTarget:self action:@selector(closePicker) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:cancelButton];
        
        [OKButton setFrame:CGRectMake(backView.frame.size.width - 75, 3, 70, 34)];
        [OKButton setTitle:@"确定" forState:UIControlStateNormal];
        [OKButton setTitle:@"确定" forState:UIControlStateHighlighted];
        [OKButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [OKButton addTarget:self action:@selector(pickerOKAction:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:OKButton];
        
        datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, backView.frame.origin.y + 40 , self.view.frame.size.width, self.view.frame.size.height - (backView.frame.origin.y + 40))];
        [datePicker setDatePickerMode:UIDatePickerModeDate];
    }
    
        [self.view addSubview:backView];
        [self.view addSubview:datePicker];
}

//关闭当前pickerView
-(void)closePicker{
    [backView removeFromSuperview];
    [datePicker removeFromSuperview];
}
//selected date by pickerView
-(void)pickerOKAction:(id)sender{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *confromTimespStr = [formatter stringFromDate:datePicker.date];
    datestr = [NSString stringWithFormat:@"%@",confromTimespStr];
    [formatter release];
    
    if (cellIndex == 1) {
        [checkInTimeLabel setText:datestr];
    }
    else
    {
        [leaveTimeLabel setText:datestr];
    }
    
    [self closePicker];
}

#pragma mark -
#pragma mark tableviewDelegate & datasource
///////// datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"searchCell";
    UITableViewCell *searchCell = [searchTabel dequeueReusableCellWithIdentifier:cellID];
    
    if (!searchCell) {
        searchCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 80, 30)];
        [tagLabel setBackgroundColor:[UIColor clearColor]];
        [tagLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
        [tagLabel setTag:9990];
        [searchCell.contentView addSubview:tagLabel];
    }
    
    UILabel *label = (UILabel *)[searchCell.contentView viewWithTag:9990];
    switch (indexPath.row) {
        case 0:
        {
            [label setText:@"入住城市："];
            if (!cityLabel) {
                cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(87, 5, 208, 30)];
                [searchCell.contentView addSubview:cityLabel];
                [cityLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                [cityLabel setBackgroundColor:[UIColor clearColor]];
                [cityLabel setText:@"上海"];
            }
        }
            break;
            
        case 1:
        {
            [label setText:@"入住日期："];
            
            if (!checkInTimeLabel) {
                checkInTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(87, 5, 208, 30)];
                [searchCell.contentView addSubview:checkInTimeLabel];
                [checkInTimeLabel setText:@"2012-12-05"];
                [checkInTimeLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                [checkInTimeLabel setBackgroundColor:[UIColor clearColor]];
            }
        }
            break;
            
        case 2:
        {
            [label setText:@"离店日期："];
            
            if (!leaveTimeLabel) {
                leaveTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(87, 5, 208, 30)];
                [searchCell.contentView addSubview:leaveTimeLabel];
                [leaveTimeLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                [leaveTimeLabel setBackgroundColor:[UIColor clearColor]];
                [leaveTimeLabel setText:@"2012-12-07"];
            }
        }
            break;
            
        case 3:
        {
            [label setText:@"价格："];
            
            if (!priceLabel) {
                priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(87, 5, 208, 30)];
                [searchCell.contentView addSubview:priceLabel];
                [priceLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                [priceLabel setBackgroundColor:[UIColor clearColor]];
                [priceLabel setText:@"不限"];
            }
        }
            break;
            
        case 4:
        {
            [label setText:@"星级："];
            
            if (!starLabel) {
                starLabel = [[UILabel alloc] initWithFrame:CGRectMake(87, 5, 208, 30)];
                [searchCell.contentView addSubview:starLabel];
                [starLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                [starLabel setBackgroundColor:[UIColor clearColor]];
                [starLabel setText:@"不限"];
            }
        }
            break;
            
        case 5:
        {
            [label setText:@"行政区划："];
            
            if (!areaLabel) {
                areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(87, 5, 208, 30)];
                [searchCell.contentView addSubview:areaLabel];
                [areaLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                [areaLabel setBackgroundColor:[UIColor clearColor]];
                [areaLabel setText:@"不限"];
            }
        }
            break;
            
        case 6:
        {
            [label setText:@"关键字："];
            
            if (!wineInfoTF) {
                wineInfoTF = [[UITextField alloc] initWithFrame:CGRectMake(87, 5, 208, 30)];
                wineInfoTF.delegate = self;
                [searchCell.contentView addSubview:wineInfoTF];
                [wineInfoTF setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                [wineInfoTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
                [wineInfoTF setPlaceholder:@"酒店名称/酒店地址"];
            }
        }
            break;
            
        default:
            break;
    }
        
    
    return searchCell;
}
//////// delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            ChooseCityViewController *cityListVC = [[ChooseCityViewController alloc] init];
            [self.navigationController pushViewController:cityListVC animated:YES];
            [cityListVC release];
        }
            break;
            
        case 1:
        case 2:
        {
            cellIndex = indexPath.row;
            [self addDatePicker];
        }
            break;
            
        case 3:
        case 4:
        {
            SelectionListViewController *selListVC = [[SelectionListViewController alloc] init];
            if (indexPath.row == 3) {
                selListVC.navigationItem.title = @"价格" ;
            }
            else if(indexPath.row == 4)
            {
                selListVC.navigationItem.title = @"星级" ;
            }
            [self.navigationController pushViewController:selListVC animated:YES];
            [selListVC release];
        }
            break;
            
        case 5:
        {
            LocationViewController *locationVC = [[LocationViewController alloc] init];
            [self.navigationController pushViewController:locationVC animated:YES];
            [locationVC release];
        }
            break;
            
        default:
            break;
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;//根据状态判断
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, searchTabel.frame.size.width, 50)] autorelease];
    
    UIButton *logBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [logBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footView addSubview:logBtn];
    
    [logBtn setFrame:CGRectMake(5, 5, footView.frame.size.width - 10,40)];
    [logBtn setBackgroundImage:[UIImage imageNamed:@"YBigBtnImg.jpg"] forState:UIControlStateNormal];
    [logBtn setBackgroundImage:[UIImage imageNamed:@"YBigBtnImg_Sel.jpg"] forState:UIControlStateHighlighted];
    [logBtn setTitle:@"查找酒店" forState:UIControlStateNormal];
    [logBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    return footView;
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
