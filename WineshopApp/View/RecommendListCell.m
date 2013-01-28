//
//  RecommendListCell.m
//  WineshopApp
//
//  Created by Abner on 13-1-22.
//
//

#import "RecommendListCell.h"
#import <QuartzCore/QuartzCore.h>

#define RATING_IMAGE_VIEW_START_TAG 1100
#define TEXT_COLOR [UIColor colorWithRed:247/255.0 green:99/255.0 blue:21/255.0 alpha:1.0]

@implementation RecommendListCell
@synthesize titleImageView,titleLabel,levelLabel,priceLabel,dateLabel,recommendReasonLabel,detailAddressLabel,addressLabel,discountLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat padding = 8.0f;
        
        titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(padding-3, padding, 90, 92/*self.frame.size.height*/-2*padding)];
        [titleImageView setBackgroundColor:[UIColor lightGrayColor]];
        [titleImageView.layer setCornerRadius:5.f];
        [self addSubview:titleImageView];
        
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleImageView.frame)+2, padding-3, 145, 19)];
        [titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        //[titleLabel setText:@"中华人民共和国国宾馆"];
        [titleLabel setTextColor:[UIColor blackColor]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:titleLabel];
        
        dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleImageView.frame)+2, CGRectGetMaxY(titleLabel.frame), 200, 16)];
        [dateLabel setFont:[UIFont systemFontOfSize:11]];
        //[dateLabel setText:@"入住有效期:从2012-12-12至2012-12-15"];
        [dateLabel setTextColor:[UIColor lightGrayColor]];
        [dateLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:dateLabel];
        
        recommendReasonLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleImageView.frame)+2, CGRectGetMaxY(dateLabel.frame), 145, 16)];
        [recommendReasonLabel setFont:[UIFont systemFontOfSize:11]];
        //[recommendReasonLabel setText:@"推荐理由:价格非常优惠"];
        [recommendReasonLabel setTextColor:[UIColor lightGrayColor]];
        [recommendReasonLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:recommendReasonLabel];
        
        detailAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleImageView.frame)+2, CGRectGetMaxY(recommendReasonLabel.frame), 145, 16)];
        [detailAddressLabel setFont:[UIFont systemFontOfSize:11]];
        //[detailAddressLabel setText:@"阜成路33号"];
        [detailAddressLabel setTextColor:[UIColor lightGrayColor]];
        [detailAddressLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:detailAddressLabel];
        
        addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleImageView.frame)+2, CGRectGetMaxY(detailAddressLabel.frame), 145, 16)];
        [addressLabel setFont:[UIFont systemFontOfSize:11]];
        //[addressLabel setText:@"陆家嘴"];
        [addressLabel setTextColor:[UIColor lightGrayColor]];
        [addressLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:addressLabel];
        
        for (int i = 0; i < 5; i ++) {
            UIImageView *ratingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + i * 15, padding-2, 17.0f, 17.0f)];
            ratingImageView.tag = RATING_IMAGE_VIEW_START_TAG + i;
            ratingImageView.contentMode = UIViewContentModeScaleToFill;
            ratingImageView.image = [UIImage imageNamed:@"rating_gray.png"];
            [self addSubview:ratingImageView];
            [ratingImageView release];
        }
        
        priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(recommendReasonLabel.frame)+12, CGRectGetMaxY(recommendReasonLabel.frame)-12, 60, 20)];
        [priceLabel setFont:[UIFont systemFontOfSize:14]];
        [priceLabel setText:@"1067"];
        [priceLabel sizeToFit];
        [priceLabel setTextColor:TEXT_COLOR];
        [priceLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:priceLabel];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(priceLabel.frame)-10, CGRectGetMaxY(recommendReasonLabel.frame)-7, 10, 16)];
        [label setFont:[UIFont systemFontOfSize:11]];
        [label setText:@"￥"];
        [label setTextColor:TEXT_COLOR];
        [label setBackgroundColor:[UIColor clearColor]];
        [self addSubview:label];
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame), CGRectGetMaxY(recommendReasonLabel.frame)-8, 10, 16)];
        [label1 setFont:[UIFont systemFontOfSize:11]];
        [label1 setText:@"起"];
        [label1 setTextColor:[UIColor lightGrayColor]];
        [label1 setBackgroundColor:[UIColor clearColor]];
        [self addSubview:label1];
        
        discountLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(priceLabel.frame)-8, CGRectGetMaxY(priceLabel.frame)+3, 60, 16)];
        [discountLabel setFont:[UIFont systemFontOfSize:11]];
        [discountLabel setText:@"4.65折起"];
        [discountLabel setTextColor:TEXT_COLOR];
        [discountLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:discountLabel];
    }
    return self;
}

-(void)dealloc{
    [titleImageView release];
    [titleLabel release];
    [priceLabel release];
    [dateLabel release];
    [recommendReasonLabel release];
    [detailAddressLabel release];
    [addressLabel release];
    [discountLabel release];
    [super dealloc];
}

-(void)layoutSubviews{

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark Private
- (void)setRating:(NSInteger )rate {
    if (rate < 1 || rate > 5) {
        return;
    }
    for (int i = 0; i < 5; i ++) {
        UIImageView *ratingImageView = (UIImageView *)[self viewWithTag:RATING_IMAGE_VIEW_START_TAG + i];
        if (!ratingImageView) {
            break;
        }
        ratingImageView.image = [UIImage imageNamed:i < rate ? @"rating_gray.png" : @"rating_gray.png"];
    }
}

@end
