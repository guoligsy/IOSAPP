//
//  OederCell.m
//  WineshopApp
//
//  Created by sy on 1/17/13.
//
//

#import "OederCell.h"

@implementation OederCell

@synthesize dateLabel = _dateLabel;
@synthesize priceLabel = _priceLabel;
@synthesize wineNameLabel = _wineNameLabel;
@synthesize roomTypeLabel = _roomTypeLabel;
@synthesize dateInLabel = _dateInLabel;
@synthesize startDLabel = _startDLabel;
@synthesize endDLabel = _endDLabel;
@synthesize toLabel = _toLabel;
@synthesize orderStatusLabel = _orderStatusLabel;
@synthesize payBtn = _payBtn;

- (void)dealloc
{
    [_dateLabel release];
    [_priceLabel release];
    [_wineNameLabel release];
    [_roomTypeLabel release];
    [_dateInLabel release];
    [_startDLabel release];
    [_endDLabel release];
    [_toLabel release];
    [_orderStatusLabel release];
    
    [tapGes release];
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 100, 23)];
        [_dateLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
        [_dateLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_dateLabel];
        
        _wineNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, 100, 23)];
        [_wineNameLabel setBackgroundColor:[UIColor clearColor]];
        [_wineNameLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
        [self addSubview:_wineNameLabel];
        _wineNameLabel.userInteractionEnabled = YES;
        tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpAction)];
        [_wineNameLabel addGestureRecognizer:tapGes];
        
        _roomTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 35, 60, 23)];
        [_roomTypeLabel setBackgroundColor:[UIColor clearColor]];
        [_roomTypeLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
        [self addSubview:_roomTypeLabel];
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(175, 35, 60, 23)];
        [_priceLabel setBackgroundColor:[UIColor clearColor]];
        [_priceLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
        [self addSubview:_priceLabel];
        
        _orderStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 35, 50, 23)];
        [_orderStatusLabel setBackgroundColor:[UIColor clearColor]];
        [_orderStatusLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
        [self addSubview:_orderStatusLabel];
        
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payBtn setTitle:@"付款" forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_payBtn.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_BTN]];
        [_payBtn setFrame:CGRectMake(240, 35, 50, 23)];
        [_payBtn setBackgroundImage:[UIImage imageNamed:@"OSBtnImg.jpg"] forState:UIControlStateNormal];
        [_payBtn setBackgroundImage:[UIImage imageNamed:@"OSBtnImg_Sel.jpg"] forState:UIControlStateHighlighted];
        [self addSubview:_payBtn];
        
        _dateInLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 65, 94, 23)];
        [_dateInLabel setBackgroundColor:[UIColor clearColor]];
        [_dateInLabel setText:@"入住时间："];
        [_dateInLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
        [self addSubview:_dateInLabel];
        
        _startDLabel = [[UILabel alloc] initWithFrame:CGRectMake(107, 65, 95, 23)];
        [_startDLabel setBackgroundColor:[UIColor clearColor]];
        [_startDLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
        [self addSubview:_startDLabel];
        
        _toLabel = [[UILabel alloc] initWithFrame:CGRectMake(204, 65, 15, 23)];
        [_toLabel setBackgroundColor:[UIColor clearColor]];
        [_toLabel setText:@"至"];
        [_toLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
        [self addSubview:_toLabel];
        
        _endDLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 65, 95, 23)];
        [_endDLabel setBackgroundColor:[UIColor clearColor]];
        [_endDLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
        [self addSubview:_endDLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)jumpAction
{
//跳转到酒店详情
}

@end
