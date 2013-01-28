//
//  ImageLoader.m
//  OneByOne
//
//  Created by  on 12-2-28.
//  Copyright (c) 2012年 Hiker. All rights reserved.
//

#import "ImageLoader.h"
#import "SDWebImageManager.h"
#import "SDWebImageManagerDelegate.h"

@interface ImageLoader  (PrivateMethod)

-(void)saveImageToLocal:(UIImage *)image;

@end
@implementation ImageLoader
@synthesize picLocalDiskPath = _picLocalDiskPath;

-(void)dealloc{
    [_picLocalDiskPath release];
    [super dealloc];
}
-(void)downloadMapPic:(NSString *)serverPath picLocalPath:(NSString *)picLocalPath{
    _picLocalDiskPath = [picLocalPath retain];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    NSURL *url = [NSURL URLWithString:serverPath];
    UIImage *cachedImage = [manager imageWithURL:url];
    
    if (cachedImage)
    {
        [self saveImageToLocal:cachedImage];
    }
    else
    {
        [manager downloadWithURL:url delegate:self];
    }
}

-(void)downloadImage:(NSString *)keyid picType:(PicType) type{
    NSString *serverPath = [HelpTools returnPicSeverPath:keyid picType:type];
    NSString *picLocalPath = [HelpTools returnPicDiskPath:keyid picType:type];
    _picLocalDiskPath = [picLocalPath retain];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    NSURL *url = [NSURL URLWithString:serverPath];
    UIImage *cachedImage = [manager imageWithURL:url];
    
    if (cachedImage)
    {
        [self saveImageToLocal:cachedImage];
    }
    else
    {
        [manager downloadWithURL:url delegate:self];
    }

}

-(void)downloadImage:(NSString *)mapPicFullPath{
    
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
    [self saveImageToLocal:image];
}

-(void)saveImageToLocal:(UIImage *)image{
    //JEPG格式
    NSData *imagedata=UIImageJPEGRepresentation(image, 1.0);
    [imagedata writeToFile:self.picLocalDiskPath atomically:YES];
}

@end
