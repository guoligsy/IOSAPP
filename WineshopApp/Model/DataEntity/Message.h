//
//  Message.h
//  Ctopus
//
//  Created by michael cheng on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject{
    NSString *messageId;
    NSString *type;
    NSString *title;
    NSString *content;
    NSString *createTime;
    NSInteger status;
    NSString *itineraryName;
    NSString *userId;
//    NSString *subject;
}

@property(retain)NSString *messageId;
@property(retain)NSString *type;
@property(retain)NSString *title;
@property(retain)NSString *content;
@property(retain)NSString *createTime;
@property(assign) NSInteger status;
@property(retain)NSString *itineraryName;
@property(retain)NSString *userId;
//@property(retain)NSString *subject;
@end
