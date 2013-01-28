//
//  ChooseCityViewController.m
//  WineshopApp
//
//  Created by sy on 1/28/13.
//
//

#import "ChooseCityViewController.h"
#import "SearchViewController.h"

@interface ChooseCityViewController ()

@end

@implementation ChooseCityViewController

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
    self.navigationItem.title = @"选择城市";
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320,44)];
	_searchBar.placeholder = @"请输入城市名";
	_searchController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar
                                                          contentsController:self];
    
	[_searchController setDelegate:self];
	[_searchController setSearchResultsDelegate:self];
	[_searchController setSearchResultsDataSource:self];
//    [self.view addSubview:_searchBar] ;
    
    CGRect tRect = self.view.bounds;
    tRect.origin.x = 5;
    tRect.origin.y = 5;
    tRect.size.width -= 10;
    tRect.size.height -= 50;
    cityListTable = [[UITableView alloc] initWithFrame:tRect style:UITableViewStyleGrouped];
    cityListTable.delegate = self;
    cityListTable.dataSource = self;
    [cityListTable setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:cityListTable];
    
    cityList = [[NSArray alloc] initWithObjects:@"上海",@"北京",@"广州",@"深圳",@"香港",@"三亚",@"厦门",@"青岛",@"杭州",@"郑州",@"合肥",@"南阳",@"信阳",@"武汉",@"黄冈",@"临沂",@"苏州",@"南京",@"大连", nil];
    
    filterCityList = [[NSMutableArray alloc] initWithCapacity:[cityList count]];
	[filterCityList addObjectsFromArray:cityList];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark UITableviewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (tableView == self.searchDisplayController.searchResultsTableView){
//        return [filterCityList count];
//    }else{
        return [cityList count];
//    }
    
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
    }
    
//    if(tableView == self.searchDisplayController.searchResultsTableView){
//        NSString *cityName = [filterCityList objectAtIndex:indexPath.row];
//        UILabel *label = (UILabel *)[cell viewWithTag:9999];
//        [label setText:cityName];
//    }
//    else{
        NSString *cityName = [cityList objectAtIndex:indexPath.row];
        UILabel *label = (UILabel *)[cell viewWithTag:9999];
        [label setText:cityName];
        cell.detailTextLabel.text = nil;
//    }
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
//            if(tableView == self.searchDisplayController.searchResultsTableView){
//                ((SearchViewController *)viewController).cityName = [filterCityList objectAtIndex:indexPath.row];
//            }
//            else 
//            {
                ((SearchViewController *)viewController).cityName = [cityList objectAtIndex:indexPath.row];
//            }
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark UIDisplayDelegate 
-(void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{
    controller.searchResultsTableView.layer.contents = (id)[UIImage imageNamed:@"backgroundView.png"].CGImage;
    controller.searchResultsTableView.backgroundColor = [UIColor clearColor];
    controller.searchResultsTableView.separatorColor = [UIColor colorWithRed:185/255.0 green:186/255.0 blue:181/255.0 alpha:1];
    [_searchBar setShowsCancelButton:YES animated:NO];
    for(UIView *subView in _searchBar.subviews){
        if([subView isKindOfClass:[UIButton class]]){
            [(UIButton*)subView setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    
    [filterCityList removeAllObjects]; // First clear the filtered array.
    
    for (NSString *a in cityList)
    {
		NSComparisonResult result = [a compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
		if (result == NSOrderedSame)
		{
			[filterCityList addObject:a];
		}
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
