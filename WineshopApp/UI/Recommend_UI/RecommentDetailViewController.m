//
//  RecommentDetailViewController.m
//  WineshopApp
//
//  Created by Abner on 13-1-27.
//
//

#import "RecommentDetailViewController.h"

@interface RecommentDetailViewController ()

@end

@implementation RecommentDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //辛苦忙碌了一年,岁末,该让自己歇歇脚,安排一次放松身心的旅行,带上家人,邀约朋友,共享出游美事!今次,新世界酒店推出冬日欢腾住宿礼遇,2012年12月25日至2013年2月18日期间,品牌旗下多家热门城市高星级豪华酒店连住2晚,即可共享免费住宿1晚，于任何一间新世界品牌酒店享用.最低起价只需￥330起/间晚,超值的价格,享用独一无二的舒适旅行.
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self.leftBtn setHidden:NO];
    self.navigationItem.title = @"特别推荐";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
