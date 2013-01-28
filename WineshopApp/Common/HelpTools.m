//
//  HelpTools.m
//  Ctopus
//
//  Created by michael cheng on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HelpTools.h"
//#import "AppDelegate.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <netdb.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import "Constants.h"
#import "AppSingleton.h"
#import "PathTools.h"
//#import "

#define AUDIOSUFFIX @"_24Kbps.mp3"

@implementation HelpTools
static AppSingleton *appSingleton = nil;


+ (BOOL) connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

+(NSString*)GetCurrntNet
{
    NSString* result;
    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:// 没有网络连接
            result=nil;
            break;
        case ReachableViaWWAN:// 使用3G网络
            result=@"3g";
            break;
        case ReachableViaWiFi:// 使用WiFi网络
            result=@"wifi";
            break;
        default:
            result = nil;
            break;
    }
    return result;
}

+(NSString *)returnLibraryCacheDataPath{
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *userFolder = @"Data";
    NSString *libUserPath = [[paths lastObject] stringByAppendingPathComponent:userFolder];
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:libUserPath]){
        [fileManager createDirectoryAtPath:libUserPath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    return libUserPath;
}

//+(NSString *)returnMainDBPath{
//    NSString *dbFolderPath = @"db";
//    NSString *dbPath = [NSString stringWithFormat:@"%@/%@.db",dbFolderPath,RESOURCE_DBNAME];
//    NSString *dbInResource = [[NSBundle mainBundle] pathForResource:RESOURCE_DBNAME ofType:@"db"];
//    NSError *error;
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    //检查是否存在db文件夹
//    NSString *fullDBFolderPath = [[self returnLibraryCacheDataPath] stringByAppendingPathComponent:dbFolderPath];
//    if(![fileManager fileExistsAtPath:fullDBFolderPath]){
//        [fileManager createDirectoryAtPath:fullDBFolderPath withIntermediateDirectories:YES attributes:nil error:&error];
//    }
//    //检查main数据库是否存在
//    NSString *fullDBPath = [[self returnLibraryCacheDataPath] stringByAppendingPathComponent:dbPath];
//    if(![fileManager fileExistsAtPath:fullDBPath]){
//        [fileManager copyItemAtPath:dbInResource toPath:fullDBPath error:&error];
//    }
//    return fullDBPath;
//}

//+(NSString *)returnCityDBPath{
//    NSString *dbFolderPath = @"db";
//    NSString *nowCity = [HelpTools getNowCity];
//    //    NSLog(@"***********now city is%@",nowCity);
//    if(nowCity == nil || nowCity.length < 8){
//        return nil;
//    }
//    NSString *dbPath = [NSString stringWithFormat:@"%@/%@%@.db",dbFolderPath,RESOURCE_CITYDBNAME,nowCity];
//    NSString *dbInResource = [[NSBundle mainBundle] pathForResource:RESOURCE_CITYDBNAME ofType:@"db"];
//    NSError *error;
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    //检查是否存在db文件夹
//    NSString *fullDBFolderPath = [[self returnLibraryCacheDataPath] stringByAppendingPathComponent:dbFolderPath];
//    if(![fileManager fileExistsAtPath:fullDBFolderPath]){
//        [fileManager createDirectoryAtPath:fullDBFolderPath withIntermediateDirectories:YES attributes:nil error:&error];
//    }
//    //检查city数据库是否存在
//    NSString *fullDBPath = [[self returnLibraryCacheDataPath] stringByAppendingPathComponent:dbPath];
//    if(![fileManager fileExistsAtPath:fullDBPath]){
//        [fileManager copyItemAtPath:dbInResource toPath:fullDBPath error:&error];
//    }
//    return fullDBPath;
//}

+(NSString *)getValueForKey:(NSString *)key{
    NSMutableDictionary *configFile = [[[NSMutableDictionary alloc] initWithContentsOfFile:[PathTools returnAppConfigPath]] autorelease];
    return [configFile valueForKey:key];
}

+(void)setValueForKey:(NSString *)key value:(NSString *)value{
    NSMutableDictionary *configFile = [[[NSMutableDictionary alloc] initWithContentsOfFile:[PathTools returnAppConfigPath]] autorelease];
    [configFile setValue:value forKey:key];
    [configFile writeToFile:[PathTools returnAppConfigPath] atomically:YES];
}

+(NSString *)returnStringByObject:(id)object{
    NSString *valueStr;
    if([object isKindOfClass:[NSString class]]){
        valueStr = [NSString stringWithFormat:@"'%@'",(NSString *)object];
    }
    else if([object isKindOfClass:[NSNumber class]]){
        valueStr = [NSString stringWithFormat:@"%@",(NSNumber *)object];
    }
    else{
        valueStr  =@"''";
    }
    return valueStr;
}

+(NSString *)getFileFolderPath:(NSString *)keyID{
    //城市目录
    NSMutableString *path = [[[NSMutableString alloc] init] autorelease];
    [path appendString:[keyID substringWithRange:NSMakeRange(0, 4)]];
    [path appendString:[NSString stringWithFormat:@"/%@",[keyID substringWithRange:NSMakeRange(4, 2)]]];
    [path appendString:[NSString stringWithFormat:@"/%@",[keyID substringWithRange:NSMakeRange(6, 2)]]];
    if([keyID length]==10){
        //城市游一级目录
        [path appendString:@"/citytour/"];
        [path appendString:[NSString stringWithFormat:@"%@",[keyID substringWithRange:NSMakeRange(8, 2)]]];
    }
    else if ([keyID length]==13){
        //城市游二级目录
        [path appendString:@"/citytour/"];
        [path appendString:[NSString stringWithFormat:@"%@/",[keyID substringWithRange:NSMakeRange(8, 2)]]];
        [path appendString:[NSString stringWithFormat:@"%@",[keyID substringWithRange:NSMakeRange(10, 3)]]];
    }
    else if([keyID length] == 19){
        //城市游三级目录
        [path appendString:@"/citytour/"];
        [path appendString:[NSString stringWithFormat:@"%@/",[keyID substringWithRange:NSMakeRange(8, 2)]]];
        [path appendString:[NSString stringWithFormat:@"%@/",[keyID substringWithRange:NSMakeRange(10, 3)]]];
        [path appendString:[NSString stringWithFormat:@"%@",[keyID substringWithRange:NSMakeRange(13, 6)]]];
    }
    else if([keyID length]==14){
        //景区	
        [path appendString:[NSString stringWithFormat:@"/%@",[keyID substringWithRange:NSMakeRange(8, 6)]]];
        
    }else if([keyID length]==17){
        //景点		
        [path appendString:[NSString stringWithFormat:@"/%@",[keyID substringWithRange:NSMakeRange(8, 6)]]];
        [path appendString:@"/Data/"];
        NSString *spotid = [NSString stringWithFormat:@"%@",[keyID substringWithRange:NSMakeRange(14, 3)]];
        NSInteger spotIdInt = [spotid intValue];
        [path appendString:[NSString stringWithFormat:@"%d",spotIdInt]];
    }
    [path appendString:@"/"];
    return path;
}

+(NSString *)getMapPicFolderPath:(NSString *)scenicRegionID{
    NSMutableString *mapPath = [[[NSMutableString alloc] init] autorelease];
    [mapPath appendString:[self getFileFolderPath:scenicRegionID]];
    [mapPath appendString:@"Data/Pic/"];
    return mapPath;
}

+(NSString *)getmapLocalDiskPath:(NSString *)scenicRegionID{
    NSString *mapPath = [self getMapPicFolderPath:scenicRegionID];
    NSString *fullDBFolderPath = [[PathTools returnLibraryCacheDataPath] stringByAppendingPathComponent:mapPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    if(![fileManager fileExistsAtPath:fullDBFolderPath]){
        [fileManager createDirectoryAtPath:fullDBFolderPath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    return fullDBFolderPath;
}
+(NSString *)getMapServerPath:(NSString *)scenicRegionID{
    NSMutableString *mapServerPath = [[[NSMutableString alloc] init] autorelease];
    [mapServerPath appendString:[self getDownloadURLPrifix]];
    [mapServerPath appendString:@"/"];
    [mapServerPath appendString:[self getMapPicFolderPath:scenicRegionID]];
    return mapServerPath;
}

+(NSString *)getPicName:(PicType)type{
    NSMutableString *picName = [[[NSMutableString alloc] init] autorelease];
    switch (type) {
        case CityListPic:
            [picName appendString:@"_148-148"];
            break;
        case PicWallPic:
            [picName appendString:@"_201-201"];
            break;
        case ScenicListPic:
            [picName appendString:@"_148-148"];
            break;
        case ScenicRegionInfoPic:
            [picName appendString:@"_620-370"];
            break;
        case CityTourFocusPic:
            [picName appendString:@"_576-274"];
            break;
        case CityTourMainPic:
            [picName appendString:@"_120-120"];
            break;
        case CityTourSubPic:
            [picName appendString:@"_315-256"];
            break;
        case CityTourDetailPic:
            [picName appendString:@"_466-282"];
            break;  
        case ScenicPointPic:
            [picName appendString:@"_620-370"];
            break;
        case CityTourRoutePic:
            
            break;
        case CitySubMainPic:
            [picName appendString:@"_620-370"];
            break;
        default:
            break;
    }
    if(type != CityTourFocusPic){
        [picName appendString:@".jpg"];
    }
    return picName;
}

+(NSString *)returnPicDiskPath:(NSString *)keyId picType:(PicType)type{
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *fileFolderPath;
    if (type == CityTourFocusPic) {
        fileFolderPath = [NSString stringWithFormat:@"%@citytour/",[self getFileFolderPath:keyId]];
    }
    else{
        fileFolderPath = [self getFileFolderPath:keyId];
    }
    if(type == CityTourRoutePic){
        fileFolderPath = [NSString stringWithFormat:@"%@route/",fileFolderPath];
    }
    //检查是否存在文件夹
    NSString *fullFolderPath = [[PathTools returnLibraryCacheDataPath] stringByAppendingPathComponent:fileFolderPath];
    if(![fileManager fileExistsAtPath:fullFolderPath]){
        [fileManager createDirectoryAtPath:fullFolderPath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    //检测文件是否存在
    NSString *fileName = [NSString stringWithFormat:@"%@%@%@",fileFolderPath,keyId,[self getPicName:type]];
    NSString *fileFullPath = [[PathTools returnLibraryCacheDataPath] stringByAppendingPathComponent:fileName];
    return fileFullPath;
}

+(BOOL)isFileExist:(NSString *)fileDiskPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:fileDiskPath]){
        return YES;
    }
    else{
        return NO;
    }
}

+(NSString *)returnPicSeverPath:(NSString *)keyId picType:(PicType)type{
    NSString *fileFolderPath;
    if (type == CityTourFocusPic) {
        fileFolderPath = [NSString stringWithFormat:@"%@citytour/",[self getFileFolderPath:keyId]];
    }
    else{
        fileFolderPath = [self getFileFolderPath:keyId];
    }
    if(type == CityTourRoutePic){
        fileFolderPath = [NSString stringWithFormat:@"%@route/",fileFolderPath];
    }
    NSString *fileName = [NSString stringWithFormat:@"%@%@%@",fileFolderPath,keyId,[self getPicName:type]];
  
    NSString *serverPath = [NSString stringWithFormat:@"%@/%@",[self getDownloadURLPrifix],fileName];
      NSLog(@"%@",serverPath);
    return serverPath;
}

+(NSString *)returnSpotAudioDiskPath:(NSString *)spotId{
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *fileFolderPath = [self getFileFolderPath:spotId];
    //检查是否存在文件夹
    NSString *fullFolderPath = [[PathTools returnLibraryCacheDataPath] stringByAppendingPathComponent:fileFolderPath];
    if(![fileManager fileExistsAtPath:fullFolderPath]){
        [fileManager createDirectoryAtPath:fullFolderPath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    //检测文件是否存在
    NSString *fileName = [NSString stringWithFormat:@"%@%@%@",fileFolderPath,spotId,AUDIOSUFFIX];
    NSString *fileFullPath = [[PathTools returnLibraryCacheDataPath] stringByAppendingPathComponent:fileName];
    return fileFullPath;
}

+(NSString *)returnSpotAudioServerPath:(NSString *)spotId{
    NSString *fileFolderPath = [self getFileFolderPath:spotId];
    NSString *fileName = [NSString stringWithFormat:@"%@%@%@",fileFolderPath,spotId,AUDIOSUFFIX];
    NSString *serverPath = [NSString stringWithFormat:@"%@/%@",[self getDownloadURLPrifix],fileName];
    return serverPath;
}

+(NSArray *)returnBestRouteArrayByString:(NSString *)brString{
    if(brString == nil || [@"" isEqualToString:brString]){
        return nil;
    }
    NSArray *array = [brString componentsSeparatedByString:@"|"];
    NSMutableArray *pointArray = [[[NSMutableArray alloc] init] autorelease];
    for(NSString *str in array){
        NSArray *tempArray = [str componentsSeparatedByString:@","];
        NSString *x = [tempArray objectAtIndex:0] ;
        NSString *y = [tempArray objectAtIndex:1] ;
        NSDictionary *pointDic = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:x,y, nil] forKeys:[NSArray arrayWithObjects:@"x",@"y",nil]];
        [pointArray addObject:pointDic];
        [pointDic release];
    }
    return pointArray;
}
#pragma mark mapTools
+(double)locationToMapX:(double)longitude latitude:(double)latitude vectorParam:(VectorParam *)vp{
    return (vp.a3 * vp.b2 - vp.b2 * longitude + vp.a2 * latitude - vp.a2 * vp.b3) / (vp.a2 * vp.b1 - vp.a1 * vp.b2);
}

+(double)locationToMapY:(double)longitude latitude:(double)latitude vectorParam:(VectorParam *)vp{
    return ((longitude - vp.a3) / vp.a1 - (latitude - vp.b3) / vp.b1) / (vp.a2 / vp.a1 - vp.b2 / vp.b1);
}
#pragma mark AppMutableParams
+(AppSingleton *)getAppSingleton{
    @synchronized(self) {
        if (appSingleton == nil) {
            appSingleton =  [[AppSingleton alloc] init]; 
        }
    }
    return appSingleton;
}

+(void)setDownloadURLPrifix:(NSString *)urlStr{
    AppSingleton *appParams = [self getAppSingleton];
    [appParams setDownloadUrlPrifix:urlStr];
}

+(NSString *)getDownloadURLPrifix{
    AppSingleton *appParams = [self getAppSingleton];
    return appParams.downloadUrlPrifix;
    //    return @"http://58.211.138.180:88";
}

+(void)setServerURLList:(NSMutableArray *)serverList
{
    AppSingleton *appParams = [self getAppSingleton];
    [appParams setServerUrlList:serverList];
}

//+(NSMutableArray*)getServerURLList
//{
//    return [self getAppSingleton].serverUrlList;
//}

+(void)setLastPushTime:(NSString *)lastTime{
    AppSingleton *appParams = [self getAppSingleton];
    [appParams setLastPushTime:lastTime];
}

+(NSString *)getLastPushTime{
    AppSingleton *appParams = [self getAppSingleton];
    return appParams.lastPushTime;
}

+(void)setNowCityCode:(NSString *)nowCityCode{
    AppSingleton *appParams = [self getAppSingleton];
    [appParams setNowCityCode:nowCityCode];
}
+(NSString *)getNowCityCode{
    AppSingleton *appParams = [self getAppSingleton];
    return appParams.nowCityCode;
}

//1000代表以公里为单位，1代表以米为单位，9999代表返回精确距离,不返回>100
//+(NSString *) getDistanceFromNowLocation:(double)longitude latitude:(double)latitude acc:(int)acc{
//    double distance = 0;
//    if(longitude == 0 || latitude==0){
//        return @"99999999";
//    }
//    CLLocation *regionLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    if (appDelegate.currentLocation) {
//        distance = [regionLocation distanceFromLocation:appDelegate.currentLocation];
//    }
//    [regionLocation release];
//    if(distance/1000>100 && acc!= 9999){
//        NSString *distanceStr = @">100";
//        return distanceStr;
//    }
//    if(distance>0){
//        if (acc==1000) {
//            NSString *distanceStr = [NSString stringWithFormat:@"%0.1f",(double)distance/1000];
//            return distanceStr;
//        }
//        else if (acc==1){
//            NSString *distanceStr = [NSString stringWithFormat:@"%0.1f",(double)distance];
//            return distanceStr;
//        }
//        else if (acc ==9999){
//            NSString *distanceStr = [NSString stringWithFormat:@"%0.1f",(double)distance];
//            return distanceStr;
//        }
//        
//    }
//    return @"99999999";
//}


#pragma mark appcinfig
+(void)setAppParam:(NSString *)param key:(NSString *)key{
    NSMutableDictionary *appDic = [[NSMutableDictionary alloc] initWithContentsOfFile:[PathTools returnAppConfigPath]];
    [appDic setValue:param forKey:key];
    [appDic writeToFile:[PathTools returnAppConfigPath] atomically:NO];
    [appDic release];
}

+(NSString *)getAppParam:(NSString *)key{
    NSDictionary *appDic = [[[NSDictionary alloc] initWithContentsOfFile:[PathTools returnAppConfigPath]]autorelease];
    NSString *val = [appDic valueForKey:key];
//    [appDic release];
    return val;
}

#pragma mark - Generate local itinerary id
+(NSString*)generateItineraryId
{
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    NSString* itineraryIdSuffix = [NSString stringWithFormat:@"%f",timeInterval];
    NSString* localItineraryId = [NSString stringWithFormat:@"ios_itinerary_%@",itineraryIdSuffix];

    NSLog(@"localItineraryId = %@",localItineraryId);
    return localItineraryId;
}

+(NSString*)generateItineraryItemId
{
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    NSString* itineraryItemIdSuffix = [NSString stringWithFormat:@"%f",timeInterval];
    NSString* localItineraryItemId = [NSString stringWithFormat:@"ios_itineraryItem_%@",itineraryItemIdSuffix];
    
    NSLog(@"localItineraryItemId = %@",localItineraryItemId);
    return localItineraryItemId;
}
//获取一个随机整数，范围在[1,9），包括1，不包括9
+(NSString*)generateConverImageNum
{
    return [NSString stringWithFormat:@"%d",(int)(1 + (arc4random() % 8))];
}

#pragma mark login

+(BOOL)isLogin{
    NSString *accountNum = [self getAppParam:@"accountNum"];
    NSString *password = [self getAppParam:@"password"];
    NSString *userId = [self getAppParam:@"userId"];
    
    if(![accountNum isEqualToString:@""] && ![password isEqualToString:@""] && [userId intValue]!=0){
        return YES;
    }else{
        return NO;
    }
}

+(NSDate*)String2Date:(NSString *)Str
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [[[dateFormatter dateFromString:Str] retain] autorelease];
}
@end
