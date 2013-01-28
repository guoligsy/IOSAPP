//
//  Message.m
//  Ctopus
//
//  Created by michael cheng on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Message.h"

@implementation Message
@synthesize messageId,type,title,content,createTime,status,itineraryName,userId;

-(void)dealloc{
    [messageId release];
    [type release];
    [title release];
    [content release];
    [createTime release];
//    [subject release];
    [itineraryName release];
    [userId release];
    [super dealloc];
}
@end
