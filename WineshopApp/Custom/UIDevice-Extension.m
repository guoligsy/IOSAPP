//
//  UIDevice-Extension.m
//  OneByOneV3
//
//  Created by sy on 11/6/12.
//
//

#import "UIDevice-Extension.h"
#include <sys/sysctl.h>
#include <sys/socket.h> 
#include <net/if.h>
#include <net/if_dl.h>

@implementation UIDevice(HardWare)

- (NSString*) getSysInfoByName:(char *)typeSpecifier
{
	size_t size;
    
	sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    char answer[size];
	
	sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
	NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
	return results;
}

//手机型号
- (NSString*) platform
{
//    返回形式iPad2，1  处理后iPad2
    NSString *tempStr = [self getSysInfoByName:"hw.machine"];
    NSRange ran = [tempStr rangeOfString:@"," options:NSBackwardsSearch];
    tempStr = [tempStr substringToIndex:(ran.length > 0?ran.location:[tempStr length])];
	return tempStr;
}

- (NSString*) hwmodel
{
	return [self getSysInfoByName:"hw.model"];
}

//网络类型
- (NSString *)netType
{
    NSString *tempStr = [self getSysInfoByName:"hw.machine"];
    NSRange ran = [tempStr rangeOfString:@"," options:NSBackwardsSearch];
    tempStr = [tempStr substringFromIndex:(ran.length > 0?ran.location+1:[tempStr length])];
    if (![tempStr isEqualToString:@"1"] && ![tempStr isEqualToString:@"2"]) {
        tempStr = [NSString stringWithFormat:@"4"];
    }
	return tempStr;
}

- (NSString *)getMacID
{
    int                    mib[6];
    size_t                len;
    char                *buf;
    unsigned char        *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl    *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = (char *)malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    NSLog(@"设备的mac地址: %@",outstring);
    return [outstring uppercaseString];
}

@end
