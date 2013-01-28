//
//  PathTools.h
//  Ctopus
//
//  Created by michael cheng on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PathTools : NSObject

+(NSString *)returnMainDbPath;
+(NSString *)returnCategoryDbPath;
+(NSString *)returnCityDBPath;
+(NSString *)returnAppConfigPath;
+(NSString *)returnUserFolder:(NSString *)mobileNum;
+(NSString *)returnDonwloadPlistPath:(NSString *)mobileNum;
+(NSString*)returnUserMobileNum;

////praivate method/////
+(NSString *)returnLibraryCacheDataPath;
+(NSString *)getCurrentUserFolder;
@end
