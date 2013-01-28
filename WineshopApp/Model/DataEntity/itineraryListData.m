
//
//  itineraryListData.m
//  Ctopus
//
//  Created by yueyang zheng on 12-7-10.
//  Copyright (c) 2012年 yhiker. All rights reserved.
//

#import "itineraryListData.h"

@implementation itineraryListData
@synthesize ID = _ID;
@synthesize itineraryId = _itineraryId;
@synthesize localItineraryId = _localItineraryId;
@synthesize itineraryName = _itineraryName;
@synthesize itineraryDays = _itineraryDays;
@synthesize tourGroupId = _tourGroupId;
@synthesize startDate = _startDate;
@synthesize memberId = _memberId;
@synthesize startCityName = _startCityName;
@synthesize routeCount = _routeCount;
@synthesize tripCityName = _tripCityName;
@synthesize tourGroupName = _tourGroupName;
@synthesize remark = _remark;
@synthesize status = _status;
@synthesize isDown = _isDown;
@synthesize startCityId = _startCityId;
@synthesize coverImg = _coverImg;
@synthesize createDate = _createDate;
@synthesize commentCount = _commentCount;
@synthesize lastTimestamp = _lastTimestamp;
@synthesize commandStatus = _commandStatus;
@synthesize arriveCityName = _arriveCityName;
@synthesize arriveCityId = _arriveCityId;

-(void)dealloc
{
    [_ID release];
    //    _ID = nil;
    //    [_itineraryId release];
    [_localItineraryId release];
    [_itineraryName release];
    [_tourGroupId release];
    [_tourGroupName release];
    [_startDate release];
    [_startCityName release];
    [_tripCityName release];
    //    self.ID = nil;
    //    self.itineraryId = nil;
    //    self.itineraryName =nil;
    //    self.tourGroupId = nil;
    //    self.startDate = nil;
    //    self.startCityName = nil;
    [_startCityId release];
    [_coverImg release];
    [_arriveCityId release];
    [_arriveCityName release];
    [super dealloc];
}

@end
