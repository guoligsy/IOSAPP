//
//  WSTableViewController.m
//  WineshopApp
//
//  Created by sy on 1/7/13.
//
//

#import "WSTableViewController.h"

@interface WSTableViewController ()

@end

@implementation WSTableViewController

@synthesize tableView;
@synthesize shouldDragRefresh;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (shouldDragRefresh) {
        refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame: CGRectMake(0.0f, -self.tableView.frame.size.height, self.tableView.frame.size.width, self.tableView.frame.size.height)];
        refreshHeaderView.delegate = self;
        [self.tableView addSubview:refreshHeaderView];
        [refreshHeaderView release];        
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - EGORefreshTableHeaderDelegate
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view {
    [self refreshData];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view {
    return _isLoading;
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
    [refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];	
}


- (void)refreshData {
    //子类实现
}

- (void)refreshComplete {
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}

- (void)requestMoreData {
    //子类实现
}

- (UITableViewCell *)dequeueLoadingCell {
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"loading"];
	if(cell == nil) {
		NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"LoadingCell" owner:self options:nil];
		cell = [arr objectAtIndex:0];
	}
	UIActivityIndicatorView *ai = (UIActivityIndicatorView *)[cell viewWithTag:1];
	[ai startAnimating];
    
    [self performSelector:@selector(requestMoreData) withObject:nil afterDelay:0.0];
	return cell;
}

@end
