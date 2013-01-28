//
//  PathTools.m
//  Ctopus
//
//  Created by michael cheng on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PathTools.h"

@implementation PathTools

+(NSString*)returnUserMobileNum
{
    return @"";
}

+(NSString *)returnAppConfigPath{
    NSString *cgFileName = [NSString stringWithFormat:@"%@.plist",APPCONFIGFILE];
    NSString *cgFileInResource = [[NSBundle mainBundle] pathForResource:APPCONFIGFILE ofType:@"plist"];
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //检查是否存在cofig文件
    NSString *fullConfigPath = [[self returnLibraryCacheDataPath] stringByAppendingPathComponent:cgFileName];
    if(![fileManager fileExistsAtPath:fullConfigPath]){
        [fileManager copyItemAtPath:cgFileInResource toPath:fullConfigPath error:&error];
    }
    return fullConfigPath;
}

+(NSString *)returnUserFolder:(NSString *)mobileNum{
    NSString *userPath = [[self returnLibraryCacheDataPath] stringByAppendingPathComponent:mobileNum];
    //    NSLog(@"*****%@",userPath);
    //检查是否存在user文件夹
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:userPath]){
        [fileManager createDirectoryAtPath:userPath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    return userPath;
}

+(NSString *)returnDonwloadPlistPath:(NSString *)mobileNum
{
    NSString *plistpath= [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:[NSString stringWithFormat:@"hk_download.plist"]];
    return plistpath;
}

+(NSString *)getCurrentUserFolder{
    NSDictionary *appDic = [[NSDictionary alloc] initWithContentsOfFile:[self returnAppConfigPath]];
    NSString *userMobile = [NSString stringWithString:[appDic valueForKey:@"accountNum"]] ;
    [appDic release];
    return [self returnUserFolder:userMobile];
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
@end
