//
//  OederCell.h
//  WineshopApp
//
//  Created by sy on 1/17/13.
//
//

#import <UIKit/UIKit.h>

@interface OederCell : UITableViewCell
{
    UILabel *_dateLabel;
    UILabel *_priceLabel;
    UILabel *_wineNameLabel;
    UILabel *_roomTypeLabel;
    UILabel *_dateInLabel;
    UILabel *_startDLabel;
    UILabel *_endDLabel;
    UILabel *_toLabel;
    
    UILabel *_orderStatusLabel;
    UIButton *_payBtn;
    
    UITapGestureRecognizer *tapGes;
}

@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) UILabel *priceLabel;
@property (nonatomic, retain) UILabel *wineNameLabel;
@property (nonatomic, retain) UILabel *roomTypeLabel;
@property (nonatomic, retain) UILabel *dateInLabel;
@property (nonatomic, retain) UILabel *startDLabel;
@property (nonatomic, retain) UILabel *endDLabel;
@property (nonatomic, retain) UILabel *toLabel;

@property (nonatomic, retain) UILabel *orderStatusLabel;
@property (nonatomic, retain) UIButton *payBtn;
@end
