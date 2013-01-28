//
//  HelpTools.h
//  Ctopus
//
//  Created by michael cheng on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
typedef enum {
CityListPic,
PicWallPic,
ScenicListPic,
ScenicRegionInfoPic,
ScenicPointPic,
CityTourFocusPic,
CityTourMainPic,
CityTourSubPic,
CitySubMainPic,
CityTourDetailPic,
CityTourRoutePic
}PicType;

#import <Foundation/Foundation.h>
#import "AppSingleton.h"
#import "VectorParam.h"
#import "Reachability.h"


@interface HelpTools : NSObject
////Singleton////
+(AppSingleton *)getAppSingleton;

/////////
+(void)setAppParam:(NSString *)param key:(NSString *)key;
+(NSString *)getAppParam:(NSString *)key;

+(BOOL) connectedToNetwork;
+(NSString *)returnLibraryCacheDataPath;
+(NSString *)getValueForKey:(NSString *)key;
+(void)setValueForKey:(NSString *)key value:(NSString *)value;

+(NSString *)returnStringByObject:(id)object;
+(void)copyDbFromZipToDb:(NSString *)cityId;
+(BOOL)ifAlreadyDownloadbyid:(NSString*)cityid;

+(NSString *)getFileFolderPath:(NSString *)keyID;
//map path
+(NSString *)getMapPicFolderPath:(NSString *)scenicRegionID;
+(NSString *)getMapServerPath:(NSString *)scenicRegionID;
+(NSString *)getmapLocalDiskPath:(NSString *)scenicRegionID;
//pic path
+(NSString *)getPicName:(PicType)type;
+(NSString *)returnPicDiskPath:(NSString *)keyId picType:(PicType)type;
+(NSString *)returnPicSeverPath:(NSString *)keyId picType:(PicType)type;
+(BOOL)isFileExist:(NSString *)fileDiskPath;

//audio path
+(NSString *)returnSpotAudioDiskPath:(NSString *)spotId;
+(NSString *)returnSpotAudioServerPath:(NSString *)spotId;

+(NSArray *)returnBestRouteArrayByString:(NSString *)brString;

/* map tools*/
+(double)locationToMapX:(double)longitude latitude:(double)latitude vectorParam:(VectorParam *)vp;
+(double)locationToMapY:(double)longitude latitude:(double)latitude vectorParam:(VectorParam *)vp;
//
///*AppSingleton*/
//+(AppSingleton *)getAppSingleton;

+(void)setDownloadURLPrifix:(NSString *)urlStr;
+(NSString *)getDownloadURLPrifix;

+(void)setServerURLList:(NSMutableArray*)serverList;
+(NSMutableArray*)getServerURLList;

+(void)setLastPushTime:(NSString *)lastTime;
+(NSString *)getLastPushTime;

+(void)setNowCityCode:(NSString *)nowCityCode;
+(NSString *)getNowCityCode;

+(void)setPlayerController:(MPMoviePlayerController *)player;
+(MPMoviePlayerController *)getPlayerController;
+(NSString*)GetCurrntNet;

+(NSString *) getDistanceFromNowLocation:(double)longitude latitude:(double)latitude acc:(int)acc;

+(NSMutableArray*)returnCityList;

//generate itinerary id & itinerary item id & cover image
+(NSString*)generateItineraryId;
+(NSString*)generateItineraryItemId;
+(NSString*)generateConverImageNum;
//return login status
+(BOOL)isLogin;
//check itinerary status(not started,ongoing,expired)
+(NSDate*)String2Date:(NSString*)Str;
+(NSString*)Date2String:(NSDate*)Date;
@end
