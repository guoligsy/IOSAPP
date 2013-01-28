//
//  ImageLoader.h
//  OneByOne
//
//  Created by  on 12-2-28.
//  Copyright (c) 2012年 Hiker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HelpTools.h"
#import "SDWebImageManagerDelegate.h"

@interface ImageLoader : NSObject<SDWebImageManagerDelegate>{
    NSString *_picLocalDiskPath;
}
@property(retain) NSString *picLocalDiskPath;
-(void)downloadImage:(NSString *)keyid picType:(PicType) type;
-(void)downloadMapPic:(NSString *)serverPath picLocalPath:(NSString *)picLocalPath;

@end
