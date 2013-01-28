//
//  itineraryListData.h
//  Ctopus
//
//  Created by yueyang zheng on 12-7-10.
//  Copyright (c) 2012年 yhiker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface itineraryListData : NSObject
{
    NSString* _ID;
    NSString* _itineraryId;
    NSString* _localItineraryId;
    NSString* _itineraryName;
    NSInteger _itineraryDays;
    NSString* _tourGroupId;
    NSString* _tourGroupName;
    NSString* _startDate;
    NSInteger _memberId;
    NSInteger _status;
    NSString* _startCityName;
    NSString* _startCityId;//new added
    NSInteger _routeCount;
    NSString* _tripCityName;
    NSString* _remark;
    NSInteger _isDown;
    //new added
    NSString* _coverImg;
    long _createDate;
    NSInteger _commentCount;
    long long _lastTimestamp;
    NSInteger _commandStatus;
    NSString* _arriveCityName;
    NSString* _arriveCityId;
}
@property(nonatomic,retain)NSString* ID;
@property(nonatomic,retain) NSString* itineraryId;
@property(nonatomic,retain) NSString* localItineraryId;
@property(nonatomic,retain)NSString* itineraryName;
@property(nonatomic)NSInteger itineraryDays;
@property(nonatomic,retain)NSString* tourGroupId;
@property(nonatomic,retain)NSString* tourGroupName;
@property(nonatomic,retain)NSString* startDate;
@property(nonatomic,retain)NSString* startCityName;
@property(nonatomic)NSInteger routeCount;
@property(nonatomic,retain)NSString* tripCityName;
@property(nonatomic,retain)NSString* remark;
@property(nonatomic)NSInteger memberId;
@property(nonatomic)NSInteger status;
@property(nonatomic)NSInteger isDown;
@property(nonatomic,retain)NSString* startCityId;
@property(nonatomic)long long lastTimestamp;
@property(nonatomic,retain)NSString* coverImg;
@property(nonatomic)NSInteger commentCount;
@property(nonatomic)long createDate;
@property(nonatomic)NSInteger commandStatus;
@property(nonatomic,retain)NSString* arriveCityName;
@property(nonatomic,retain)NSString* arriveCityId;

@end
