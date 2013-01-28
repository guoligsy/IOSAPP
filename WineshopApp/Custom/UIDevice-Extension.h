//
//  UIDevice-Extension.h
//  OneByOneV3
//
//  Created by sy on 11/6/12.
//
//

#import <Foundation/Foundation.h>

@interface UIDevice(HardWare)
- (NSString*) platform;
//网络类型
- (NSString *)netType;

- (NSString*) hwmodel;

- (NSString *)getMacID;
@end
