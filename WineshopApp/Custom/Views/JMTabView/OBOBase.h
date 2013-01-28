//
//  OBOBase.h
//  OneByOneV3
//
//  Created by zheng yueyang on 12-12-26.
//
//

#ifndef OneByOneV3_OBOBase_h
#define OneByOneV3_OBOBase_h
#pragma mark - Macro for MyTour add by yueyang zheng
#define kTabItemFont [UIFont boldSystemFontOfSize:12.]
#define UITABBAR_HEIGHT                                     49
//#define SEGMENTBAR_HEIGHT 30
#define NEWTIMELINE                                         1
#define BASETIMELINE_WIDTH                                  (40)
#define TRAFFIC_CELL_HEIGHT                                 120
#define SCENICPOT_CELL_HEIGHT                               95
#define SHOPPING_HOTEL_CELL_HEIGHT                          95
#define NORMAL_SEGMENT_HEIGHT                               15
#define TIMELINE_SEGMENT_HEIGHT                             60
#define DAYINDEX_SEGMENTATION_VIEW_HEIGHT                   25
#define ITINERARY_ITEM_EDIT_VIEW_HEIGHT                     35
/*
 itemType:
 1:交通
 2:景区
 3:酒店
 4:购物
 itemSubType:
 1:飞机
 2:火车
 3:汽车
 4:轮船
 */
typedef enum{
    none,
    /*subType*/
    trafficAirplane,
    trafficTrain,
    /* trafficBus,
     trafficShip,*/
    trafficOther,
    /*mainType*/
    trafficType,
    scenicpotType,
    hotelType,
    shoppingType,
    entertainType,
    diningType,
    eventType,
    traffic_withheader,
    scenic_withheader,
    hotel_withheader,
    shopping_withheader,
    entertain_withheader,
    dining_withheader,
    eventType_withheader,
    /*seperate line type*/
    timelineSegment,
    normalSegment
}cellType;

typedef enum {
    scheduleDateType,
    dayIndexType
}dataForSegment;

typedef enum {
    Airplane,
    Train,
    Bus,
    Ship
}trafficToolType;
//typedef NSInteger AutoFilterType;
typedef NSInteger AutoFilterType;
#define DINING_FILTERTYPE      1
#define SHOPPING_FILTERTYPE    2
#define ENTERTAIN_FILTERTYPE   3
#define HOTEL_FILTERTYPE       4
#define SCENICPOT_FILTERTYPE   5
#define TRAFFIC_FILTERTYPE     6
#define EVENT_FILTERTYPE       7

typedef NSInteger FormDataType;
#define DINING_FORM_DATA_TYPE      1
#define SHOPPING_FORM_DATA_TYPE    2
#define ENTERTAIN_FORM_DATA_TYPE   3
#define HOTEL_FORM_DATA_TYPE       4
#define SCENICPOT_FORM_DATA_TYPE   5
#define TRAFFIC_FORM_DATA_TYPE     6
#define EVENT_FORM_DATA_TYPE       7

typedef NSInteger TrafficSubType;
#define AIRPLANE_TYPE              1
#define TRAIN_TYPE                 2
#define OTHER_TRAFFIC_TYPE         3

typedef NSInteger ItineraryCommandType;
#define NEW_CREATED_ITINERARY      1
#define EDIT_ITINERARY             2
#define DELETE_ITINERARY           3

typedef NSInteger ItinerarySyncCommand;
#define ITINERARY_NONE_COMMAND                  (0)
#define ITINERARY_BRIEF_COMMAND                 (1)         //获得行程单简介
#define ITINERARY_DETAIL_COMMAND                (1<<1)      //获得行程单详情
#define RECOMMEND_ITINERARY_COMMAND             (1<<2)      //获得推荐行程单
#define SYNC_DELETED_ITINERARY_COMMAND          (1<<3)      //同步删除的行程单
#define SYNC_EDITED_ITINERARY_COMMAND           (1<<4)      //同步编辑的行程单
#define SYNC_ADDED_ITINERARY_COMMAND            (1<<5)      //同步新添加的行程单
#define SYNC_ITINERARY_CREATED_ON_OTHER_CLIENT  (1<<6)      //同步在其他客户端创建的行程单

typedef NSInteger RecommendStatus;
#define COMMOM_TYPE                 1
#define RECOMMEND_TYPE              2

#define DEFAULT_ITINERARYDAYS      1

#define MYTOUR_ITINERARY_NAME_LENGTH                10
#define MYTOUR_ITINERARY_TOURCITY_LENGTH            17
#define PREVIEW_DETAIL_ITINERARY_NAME_LENGTH        15
#define PREVIEW_DETAIL_ITINERARY_TOURCITY_LENGTH    20
#define ITINERARY_ROUTE_NAME_LENGTH                 12
#define PREVIEW_DETAIL_ITINERARY_REMAEK_LENGTH      100

#define SECONDSINDAY                                86400

#define TOAST_DURATION 1.0

#define DEFAULT_CITY_NAME                           @"苏州"
#define DEFAULT_CITY_ID                             @"00863205"
#define DEFAULT_TRAFFIC_TOOL                        @"飞机"
#define DEFAULT_TIME_SPEND                          @"1"
#define DEFAULT_ITINERARY_ROUTE_ID                  @"-1"


#endif
