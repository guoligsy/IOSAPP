//
//  AppSingleton.h
//  Ctopus
//
//  Created by michael cheng on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "itineraryListData.h"

@interface AppSingleton : NSObject{
    
    NSString *_downloadUrlPrifix;
    NSMutableArray *_serverUrlList;
    NSString *_lastPushTime;
    
    itineraryListData *currentItinerary;
    NSInteger memberType;
    NSString *nowCityCode;
}

@property(retain) NSString *downloadUrlPrifix;
@property(retain) NSString *lastPushTime;
@property(retain) NSMutableArray* serverUrlList;

@property(retain, nonatomic)itineraryListData *currentItinerary;
@property(nonatomic, assign)NSInteger memberType;

@property(nonatomic,retain) NSString *nowCityCode;

@end
