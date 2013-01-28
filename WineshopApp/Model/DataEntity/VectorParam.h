//
//  VectorParam.h
//  OneByOne
//
//  Created by chao sun on 12-1-18.
//  Copyright 2012年 Hiker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VectorParam : NSObject{
    NSString *scenicRegionId;
    NSString *scenicRegionName;
	NSString *picId;
	int width;
	int height;
	int segmentWidthNum;
	int segmentHeightNum;
	double a1;
	double a2;
	double a3;
	
	double b1;
	double b2;
	double b3;
	
	int version;
	int versionNew;
	BOOL selfUpdate;
}
@property(retain) NSString *scenicRegionId;
@property(retain) NSString *scenicRegionName;
@property(retain) NSString *picId;
@property(assign) int width;
@property(assign) int height;
@property(assign) int segmentWidthNum;
@property(assign) int segmentHeightNum;
@property(assign) double a1;
@property(assign) double a2;
@property(assign) double a3;
@property(assign) double b1;
@property(assign) double b2;
@property(assign) double b3;
@property(assign) int version;
@property(assign) int versionNew;
@property(assign) BOOL selfUpdate;

@end
