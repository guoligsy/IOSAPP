//
//  LocationViewController.m
//  WineshopApp
//
//  Created by sy on 1/28/13.
//
//

#import "LocationViewController.h"
#import "SearchViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

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
    self.navigationItem.title = @"位置区域";
    [self.rightBtn setHidden:YES];
    
    CGRect tRect = self.view.bounds;
//    tRect.origin.y += 50;
//    tRect.size.height -= 50;
    listView = [[UITableView alloc] initWithFrame:tRect style:UITableViewStylePlain];
    listView.delegate = self;
    listView.dataSource = self;
    [self.view addSubview:listView];
    [listView setBackgroundColor:[UIColor clearColor]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    locationArr = [[NSArray alloc] initWithObjects:@"不限",@"黄浦区",@"徐汇区",@"静安区",@"长宁区",@"虹口区",@"宝山区", nil ];
}

#pragma mark UITableviewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return [locationArr count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CityCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:
                                                CellIdentifier];
    
    if (cell==nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:CellIdentifier] autorelease];
        UILabel *cellTLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 11, 275, 30)];
        [cellTLabel setBackgroundColor:[UIColor clearColor]];
        cellTLabel.textColor = [UIColor colorWithRed:99/255.0 green:89/255.0 blue:89/255.0 alpha:1];
        cellTLabel.font = [UIFont boldSystemFontOfSize:16];
        cellTLabel.tag = 9999;
        [cell addSubview:cellTLabel];
        [cell.textLabel setHidden:YES];
        [cellTLabel release];
    }
    
        NSString *cityName = [locationArr objectAtIndex:indexPath.row];
        UILabel *label = (UILabel *)[cell viewWithTag:9999];
        [label setText:cityName];
        cell.detailTextLabel.text = nil;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark UITableviewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    int i = [self.navigationController.viewControllers count];
    if (i>=2) {
        UIViewController *viewController = (UIViewController *)[self.navigationController.viewControllers objectAtIndex:(i-2)];
        if ([viewController isKindOfClass:[SearchViewController class]]) {
                ((SearchViewController *)viewController).areaName = [locationArr objectAtIndex:indexPath.row];
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
