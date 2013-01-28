//
//  Constants.h
//  WineshopApp
//
//  Created by sy on 1/7/13.
//
//

//here create public var and macro definitation
typedef enum {
    NoConnection,
    NoDataLocal,
    NoConnectionAndData,
    NoSeverData
}ErrorType;

typedef enum
{
    WaitForPay,//去付款，取消订单
    confirmForPay,//确认订单
    WaitForConfirm,//订单待确认
    CanclePay,//已付款，退订
    
}OrderStatus;

#define isIPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define APPCONFIGFILE @"AppConfig"
#define WSURL @""
#define IMG_TABBAR_NORMAL @"tabBarNormal.png"
#define IMG_TABBAR_SEL @"tabBarSel.png"

#define FONT_SIZE_CELL_LABEL 14
#define FONT_SIZE_CELL_BTN 10

#define TEL_NUM @"400-000-888"


