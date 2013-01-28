/* 
 * Copyright (c) 2009 Keith Lazuka
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "KalViewController.h"
#import "KalLogic.h"
#import "KalDataSource.h"
#import "KalDate.h"
#import "KalPrivate.h"
#import "KalGridView.h"
#define PROFILER 0
#if PROFILER
#include <mach/mach_time.h>
#include <time.h>
#include <math.h>

void mach_absolute_difference(uint64_t end, uint64_t start, struct timespec *tp)
{
    uint64_t difference = end - start;
    static mach_timebase_info_data_t info = {0,0};

    if (info.denom == 0)
        mach_timebase_info(&info);
    
    uint64_t elapsednano = difference * (info.numer / info.denom);
    tp->tv_sec = elapsednano * 1e-9;
    tp->tv_nsec = elapsednano - (tp->tv_sec * 1e9);
}
#endif

NSString *const KalDataSourceChangedNotification = @"KalDataSourceChangedNotification";

@interface KalViewController ()
@property (nonatomic, retain, readwrite) NSDate *initialDate;
@property (nonatomic, retain, readwrite) NSDate *selectedDate;
@property (nonatomic, retain, readwrite) NSDate *selectedTime;
- (KalView*)calendarView;
@end

@implementation KalViewController

@synthesize dataSource, delegate, initialDate, selectedDate,selectedTime;
@synthesize dataArray = _dataArray;
@synthesize startTimeDelegate = _startTimeDelegate;
@synthesize endTimeDelegate = _endTimeDelegate;

- (id)initWithSelectedDate:(NSDate *)date
{
  if ((self = [super init])) {
    logic = [[KalLogic alloc] initForDate:date];
    self.initialDate = date;
    self.selectedDate = date;
      //add by Even zheng
    self.selectedTime = ((KalView*)self.view).datePickerView.date;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(significantTimeChangeOccurred) name:UIApplicationSignificantTimeChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:KalDataSourceChangedNotification object:nil];
  }
  return self;
}

- (id)init
{
  return [self initWithSelectedDate:[NSDate date]];
}

- (KalView*)calendarView { return (KalView*)self.view; }

- (void)setDataSource:(id<KalDataSource>)aDataSource
{
  if (dataSource != aDataSource) {
    dataSource = aDataSource;
    tableView.dataSource = dataSource;
  }
}

- (void)setDelegate:(id<UITableViewDelegate>)aDelegate
{
  if (delegate != aDelegate) {
    delegate = aDelegate;
    tableView.delegate = delegate;
  }
}

- (void)clearTable
{
  [dataSource removeAllItems];
  [tableView reloadData];
}

- (void)reloadData
{
  [dataSource presentingDatesFrom:logic.fromDate to:logic.toDate delegate:self];
}

- (void)significantTimeChangeOccurred
{
  [[self calendarView] jumpToSelectedMonth];
  [self reloadData];
}

// -----------------------------------------
#pragma mark KalViewDelegate protocol

- (void)didSelectDate:(KalDate *)date andTime:(NSDate *)time
{
    NSLog(@"didSelectDate");
  self.selectedDate = [date NSDate];
    //add by Even zheng
    NSDateFormatter* dateFt = [[[NSDateFormatter alloc] init] autorelease];
    [dateFt setDateFormat:@"HH:mm"];
    //在转换成NSDate之前，要先转换成GMT时区,否则会帮你减去8小时
//    [dateFt setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
//    NSLog(@"1111 %@",[dateFt stringFromDate:time]);
//    [dateFt setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
//     NSLog(@"2222 %@",[dateFt dateFromString:[dateFt stringFromDate:time]]);
    self.selectedTime = time;
    
  NSDate *from = [[date NSDate] cc_dateByMovingToBeginningOfDay];
  NSDate *to = [[date NSDate] cc_dateByMovingToEndOfDay];
  [self clearTable];
  [dataSource loadItemsFromDate:from toDate:to];
  [tableView reloadData];
  [tableView flashScrollIndicators];
}

-(void)didSelectTime:(UIDatePicker *)datePicker
{
    
}

- (void)showPreviousMonth
{
  [self clearTable];
  [logic retreatToPreviousMonth];
  [[self calendarView] slideDown];
  [self reloadData];
}

- (void)showFollowingMonth
{
  [self clearTable];
  [logic advanceToFollowingMonth];
  [[self calendarView] slideUp];
  [self reloadData];
}

// -----------------------------------------
#pragma mark KalDataSourceCallbacks protocol

- (void)loadedDataSource:(id<KalDataSource>)theDataSource;
{
  NSArray *markedDates = [theDataSource markedDatesFrom:logic.fromDate to:logic.toDate];
  NSMutableArray *dates = [[markedDates mutableCopy] autorelease];
  for (int i=0; i<[dates count]; i++)
    [dates replaceObjectAtIndex:i withObject:[KalDate dateFromNSDate:[dates objectAtIndex:i]]];
  
  [[self calendarView] markTilesForDates:dates];
  [self didSelectDate:self.calendarView.selectedDate andTime:nil];
}

// ---------------------------------------
#pragma mark -

- (void)showAndSelectDate:(NSDate *)date
{
  if ([[self calendarView] isSliding])
    return;
  
  [logic moveToMonthForDate:date];
  
#if PROFILER
  uint64_t start, end;
  struct timespec tp;
  start = mach_absolute_time();
#endif
  
  [[self calendarView] jumpToSelectedMonth];
  
#if PROFILER
  end = mach_absolute_time();
  mach_absolute_difference(end, start, &tp);
  printf("[[self calendarView] jumpToSelectedMonth]: %.1f ms\n", tp.tv_nsec / 1e6);
#endif
  
  [[self calendarView] selectDate:[KalDate dateFromNSDate:date]];
  [self reloadData];
}

- (NSDate *)selectedDate
{
  return [self.calendarView.selectedDate NSDate];
}


// -----------------------------------------------------------------------------------
#pragma mark UIViewController

- (void)didReceiveMemoryWarning
{
  self.initialDate = self.selectedDate; // must be done before calling super
  [super didReceiveMemoryWarning];
}

- (void)loadView
{
  if (!self.title)
    self.title = @"Calendar";
    //add by Even zheng
    UIButton* leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 52, 36)];
    [leftBtn setImage:[UIImage imageNamed:@"backHighlight.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backToTrafficForm:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = menuBtn;
    [menuBtn release];
    [leftBtn release];
    
    UIButton* confirm = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 52, 36)];
    [confirm addTarget:self action:@selector(didSelectDateAndTime:) forControlEvents:UIControlEventTouchUpInside];
    [confirm setImage:[UIImage imageNamed:@"confirmBtn.png"] forState:UIControlStateNormal];
    UIBarButtonItem* rightBtn = [[UIBarButtonItem alloc] initWithCustomView:confirm];
    self.navigationItem.rightBarButtonItem = rightBtn;
    [rightBtn release];
    [confirm release];
    
//    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Today" style:UIBarButtonItemStyleBordered target:self action:@selector(didSelectDateAndTime:)] autorelease];
  KalView *kalView = [[[KalView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] delegate:self logic:logic] autorelease];
  self.view = kalView;
  tableView = kalView.tableView;
    tableView.dataSource = self;//dataSource;
    tableView.delegate = self;//delegate;
    _dataArray = [[NSMutableArray alloc] initWithObjects:@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00", nil];
  [tableView retain];
  [kalView selectDate:[KalDate dateFromNSDate:self.initialDate]];
  [self reloadData];
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  [tableView release];
  tableView = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  [tableView flashScrollIndicators];
//    [tableView reloadData];//add by Even zheng
}
#pragma mark - UITableViewSourceDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    return cell;
}
#pragma mark - left & right bar button
-(void)backToTrafficForm:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)didSelectDateAndTime:(id)sender
{    
    self.selectedTime = ((KalView*)self.view).datePickerView.date;//fix bug:当先选日期，再选时间后，时间设置不正确
    if (self.selectedDate && self.selectedTime && [self.startTimeDelegate respondsToSelector:@selector(retrieveBasicStartDate:andTime:)]) {
        NSDateFormatter* ft = [[[NSDateFormatter alloc] init] autorelease];
        [ft setDateFormat:@"yyyy-MM-dd"];
        NSString* dateStr = [ft stringFromDate:self.selectedDate];
        [ft setDateFormat:@"HH:mm"];//为了设置称为24小时制
        NSString* timeStr = [ft stringFromDate:self.selectedTime];
        [self.startTimeDelegate retrieveBasicStartDate:dateStr andTime:timeStr];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (self.selectedDate && self.selectedTime && [self.endTimeDelegate respondsToSelector:@selector(retrieveBasicEndDate:andTime:)]){
        NSDateFormatter* ft = [[[NSDateFormatter alloc] init] autorelease];
        [ft setDateFormat:@"yyyy-MM-dd"];
        NSString* dateStr = [ft stringFromDate:self.selectedDate];
        [ft setDateFormat:@"HH:mm"];//为了设置称为24小时制
        NSString* timeStr = [ft stringFromDate:self.selectedTime];
        [self.endTimeDelegate retrieveBasicEndDate:dateStr andTime:timeStr];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationSignificantTimeChangeNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:KalDataSourceChangedNotification object:nil];
  [initialDate release];
  [selectedDate release];
  [logic release];
  [tableView release];
    [_dataArray release];
    self.startTimeDelegate = nil;
    self.endTimeDelegate = nil;
  [super dealloc];
}

@end
