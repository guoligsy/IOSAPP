//
//  RecommendListCell.h
//  WineshopApp
//
//  Created by Abner on 13-1-22.
//
//

#import <UIKit/UIKit.h>

@interface RecommendListCell : UITableViewCell{
    UIImageView *titleImageView;
    UILabel *titleLabel;
    UILabel *levelLabel;
    UILabel *priceLabel;
    UILabel *dateLabel;
    UILabel *recommendReasonLabel;
    UILabel *detailAddressLabel;
    UILabel *addressLabel;
    UILabel *discountLabel;
    
}
@property(nonatomic, retain)UIImageView *titleImageView;
@property(nonatomic, retain)UILabel *titleLabel;
@property(nonatomic,retain)UILabel *dateLabel;
//@property(nonatomic, retain)UIImageView *rateImageView;
@property(nonatomic, retain)UILabel *levelLabel;
@property(nonatomic, retain)UILabel *priceLabel;
@property(nonatomic, retain)UILabel *recommendReasonLabel;
@property(nonatomic, retain)UILabel *detailAddressLabel;
@property(nonatomic, retain)UILabel *addressLabel;
@property(nonatomic, retain)UILabel *discountLabel;

- (void)setRating:(NSInteger )rate;

@end
