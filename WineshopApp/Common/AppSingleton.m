//
//  AppSingleton.m
//  Ctopus
//
//  Created by michael cheng on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppSingleton.h"
#import "HelpTools.h"

@implementation AppSingleton
@synthesize downloadUrlPrifix = _downloadUrlPrifix;
@synthesize lastPushTime  = _lastPushTime;
@synthesize serverUrlList = _serverUrlList;
@synthesize currentItinerary;
@synthesize memberType;
@synthesize nowCityCode;

-(id)init{
    self = [super init];
    if(self){
        
        _downloadUrlPrifix = [[NSString alloc]init];
        _lastPushTime = [[NSString alloc] init];
        nowCityCode = [[NSString alloc] initWithFormat:@"normal"];
        _serverUrlList = [[NSMutableArray alloc] initWithCapacity:3];
        AVAudioSession* audio = [[AVAudioSession alloc] init];
        [audio setActive: YES error: nil];
        [audio setCategory: AVAudioSessionCategoryPlayback error: nil];
        [audio release];
        
        if ([HelpTools getAppParam:@"authCode"]) {
            memberType = 2;
        }
        else {
            memberType = 1;
        }
        
    }
    return self;
}

-(void)dealloc{
    
    [_downloadUrlPrifix release];
    [_lastPushTime release];
    [_serverUrlList release];
    [currentItinerary release];
    [nowCityCode release];
    [super dealloc];
}
@end


