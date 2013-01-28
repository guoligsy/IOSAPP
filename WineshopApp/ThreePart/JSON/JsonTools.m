//
//  JsonTools.m
//  OneByOne
//
//  Created by  on 12-2-1.
//  Copyright (c) 2012年 Hiker. All rights reserved.
//

#import "JsonTools.h"
#import "SBJson.h"
#import "itineraryListData.h"
#import "Message.h"

#define COMMAND @"command"
#define PLATFORMTYPE @"platformType"
#define PARAM @"param"
#define PLATFORM @"ios"
#define STATUS  @"status"
#define MESSAGE @"message"
#define RESULT @"result"
#define FEEDBACK @"feedback"
#define RESULTSCORE @"resultScore"
#define RESULTBUSINESSES @"resultBusinesses"


@implementation JsonTools

+(NSString *)jsonBuilder:(JsonType )type params:(NSDictionary *)paramsDic{
    NSMutableDictionary *jsonDic = [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:@"",PLATFORM,paramsDic,nil] forKeys:[NSArray arrayWithObjects:COMMAND,PLATFORMTYPE,PARAM,nil]];
    switch (type) {
        case Request_CityAll:{
            [jsonDic setValue:@"7109" forKey:COMMAND];
            break;
        }
        case Request_CitytourItem:{
            [jsonDic setValue:@"7114" forKey:COMMAND];
            break;
        }  
        case Request_ScenicList:{
            [jsonDic setValue:@"8407" forKey:COMMAND];
            break;
        }
        case Request_ScenicPointList:{
            [jsonDic setValue:@"7112" forKey:COMMAND];
            break;
        }
        case Request_Feedback:{
            [jsonDic setValue:@"7116" forKey:COMMAND];
            break;
        }
        case Request_PushMsg:{
            [jsonDic setValue:@"7106" forKey:COMMAND];
            break;
        }
        case Request_DownloadInfo:{
            [jsonDic setValue:@"7117" forKey:COMMAND];
            break;
        }
        case Request_CheckUpdata:{
            [jsonDic setValue:@"7107" forKey:COMMAND];
            break;
        }
        case Request_Collection:{
            [jsonDic setValue:@"7104" forKey:COMMAND];
            break;
        }
        case Request_CollectionScenic:{
            [jsonDic setValue:@"7105" forKey:COMMAND];
            break;
        }
        case Request_ServerIP:{
            [jsonDic setValue:@"7100" forKey:COMMAND];
            [jsonDic setValue:@"2" forKey:@"protocolVersion"];
            break;
        }
        case Request_Scenic_Detail: {
            [jsonDic setValue:@"8107" forKey:COMMAND];
            break;
        }
        case Request_Scenic_Spot: {
            [jsonDic setValue:@"8108" forKey:COMMAND];
            break;
        }
        case Request_Member_Location: {
            [jsonDic setValue:@"8102" forKey:COMMAND];
            break;
        }   
        case Request_Login:{
            [jsonDic setValue:@"8401" forKey:COMMAND];
            break;
        }
        case Request_ItineraryDetail:{
            [jsonDic setValue:@"8101" forKey:COMMAND];
            break;
        }    
        case Request_SysMessage:{
             [jsonDic setValue:@"8417" forKey:COMMAND];
            break;
        }
        case Request_Complaints:{
            [jsonDic setValue:@"8103" forKey:COMMAND];
            break;
        }
        case Request_Score:{
            [jsonDic setValue:@"8104" forKey:COMMAND];
            break;
        }
            
        case Request_CityDownloadInfo:{
            [jsonDic setValue:@"8414" forKey:COMMAND];
            break;
        }
        case Request_HotelOrShop_Detail:{
            [jsonDic setValue:@"8110" forKey:COMMAND];
            break;
        }
        case Request_AllItinerary:{
            [jsonDic setValue:@"8404" forKey:COMMAND];
            break;
        }
        case Request_AllRecommendItinerary:{
            [jsonDic setValue:@"8404" forKey:COMMAND];
            break;
        }
        case Request_CityGuide:{
            [jsonDic setValue:@"8416" forKey:COMMAND];
            break;
        }
        case Request_BusinessesData:{
            [jsonDic setValue:@"8409" forKey:COMMAND];
            break;
        }

        case Request_Aroundme:{
            [jsonDic setValue:@"8410" forKey:COMMAND];
            break;
        }
        case Request_UploadItinerary:{
            [jsonDic setValue:@"8404" forKey:COMMAND];
            break;
        }
        case Request_Search:{
            [jsonDic setValue:@"8405" forKey:COMMAND];
            break;
        }

        case Request_CommentList:{
            [jsonDic setValue:@"8403" forKey:COMMAND];
            break;
        }


        case Request_Special:{
            [jsonDic setValue:@"8408" forKey:COMMAND];
            break;
        }

        case Request_Register:{
            [jsonDic setValue:@"8400" forKey:COMMAND];
            break;
        }
        case Request_UserData:{
            [jsonDic setValue:@"8402" forKey:COMMAND];
            break;
        }
        case Request_FeedBack:{
            [jsonDic setValue:@"8418" forKey:COMMAND];
            break;
        }
        case Request_DataCollect://add by gsy
        {
            [jsonDic setValue:@"8411" forKey:COMMAND];
        }
            break;
        case Request_Version:
        {
            [jsonDic setValue:@"8415" forKey:COMMAND];
        }
            break;
        case Request_AutoCompletionValue:
        {
            [jsonDic setValue:@"8421" forKey:COMMAND];
        }
            break;
        case Request_AutoPlayDataCollect://add by gsy
        {
            [jsonDic setValue:@"8412" forKey:COMMAND];
        }
            break;
        case Request_AutoTrafficCompletionValue:
        {
            [jsonDic setValue:@"8420" forKey:COMMAND];
        }
            break;

        case Request_Activity:
        {
            [jsonDic setValue:@"8424" forKey:COMMAND];
        }
            break;

        case Request_RecommendActivityList:
        {
            [jsonDic setValue:@"8425" forKey:COMMAND];
        }
            break;

        default:
            break;
    }
    NSString *jsonStr = [jsonDic JSONRepresentation];
    [jsonDic release];
    NSLog(@"****jsonBuilder string is : %@",jsonStr);
    return jsonStr;
}

+(NSDictionary *)jsonParser:(NSString *)jsonString{
//       NSLog(@"******before is %@",jsonString);
        NSString *dealStr = [jsonString stringByReplacingOccurrencesOfString:@"<null>" withString:@"\"\""];
        dealStr = [dealStr stringByReplacingOccurrencesOfString:@"\"null\"" withString:@"\"\""];
        dealStr = [dealStr stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
        NSLog(@"******after is %@",dealStr);
    NSDictionary *jsonMainDic = [dealStr JSONValue];
    if(jsonMainDic){
        NSString *status = [jsonMainDic valueForKey:STATUS];
        if([status isEqualToString:@"F"]){
            return nil;
        }
        NSDictionary *resultDic = [jsonMainDic valueForKey:RESULT];
        return resultDic;
        
        NSDictionary *feedback=[jsonMainDic valueForKey:FEEDBACK];
        return feedback;
        
        NSDictionary *resultScore=[jsonMainDic valueForKey:RESULTSCORE];
        return resultScore;
    }
    return nil;
}
+(NSMutableArray*)contentsDetailParser:(NSDictionary*)dic{
    NSMutableArray * allDatas=[[[NSMutableArray alloc]initWithCapacity:3]autorelease];
    NSArray* contents=[dic valueForKey:@"content"];
    [allDatas addObject:contents];
    
    return allDatas;
}

+(NSMutableArray*)itineraryListParser:(NSDictionary *)dic
{
    NSMutableArray* allItineraryList = [[[NSMutableArray alloc] initWithCapacity:3] autorelease];
    NSArray* itineraries = [dic valueForKey:@"itineraries"];
    if([itineraries isEqual:[NSNull null]]){
        return nil;
    }
    for (NSDictionary* itineraryList in itineraries) {
        itineraryListData *listData = [[itineraryListData alloc] init];
        if (![((NSNumber*)[itineraryList objectForKey:@"id"])isKindOfClass:[NSNull class]])
        {
            listData.ID = ((NSNumber*)([itineraryList objectForKey:@"id"])).stringValue;
        }
        
        if (![((NSNumber*)[itineraryList objectForKey:@"itineraryId"])isKindOfClass:[NSNull class]]) {
            listData.itineraryId = [itineraryList objectForKey:@"itineraryId"];
        }
        
        if (![((NSNumber*)[itineraryList objectForKey:@"itineraryName"])isKindOfClass:[NSNull class]]){
            listData.itineraryName = [itineraryList objectForKey:@"itineraryName"];
        }
        
        if (![((NSNumber*)[itineraryList objectForKey:@"itineraryDays"])isKindOfClass:[NSNull class]]) {
            listData.itineraryDays = ((NSNumber*)[itineraryList objectForKey:@"itineraryDays"]).intValue;
        }
        
        if (![((NSNumber*)[itineraryList objectForKey:@"tourGroupId"])isKindOfClass:[NSNull class]]){
            listData.tourGroupId = [itineraryList objectForKey:@"tourGroupId"];
        }
        
        if (![((NSNumber*)[itineraryList objectForKey:@"startDate"])isKindOfClass:[NSNull class]]){
            listData.startDate = [itineraryList objectForKey:@"startDate"];
        }
        
        if (![((NSNumber*)[itineraryList objectForKey:@"memberId"]) isKindOfClass:[NSNull class]]) {
            listData.memberId = ((NSNumber*)[itineraryList objectForKey:@"memberId"]).intValue;
        }
        
        if (![((NSNumber*)[itineraryList objectForKey:@"startCityName"]) isKindOfClass:[NSNull class]]){
            listData.startCityName = [itineraryList objectForKey:@"startCityName"];
        }
        if (![((NSNumber*)[itineraryList objectForKey:@"routeCount"]) isKindOfClass:[NSNull class]]) {
            listData.routeCount = ((NSNumber*)[itineraryList objectForKey:@"routeCount"]).intValue;
        }
        
        if (![((NSNumber*)[itineraryList objectForKey:@"tripCityName"]) isKindOfClass:[NSNull class]]){
            listData.tripCityName = [itineraryList objectForKey:@"tripCityName"];
        }
        
        [allItineraryList addObject:listData];
        [listData release];
    }
    return allItineraryList;
}

+(NSMutableArray*)messageArrayParser:(NSArray *)msgArray userId:(NSString *)userId
{
    /*status 为：1 表示正常 
             为：2 表示已读
             为：3 表示删除
      type 为：5 表示普通消息
           为：6 表示致辞
     */
    NSMutableArray* allMessageArray = [[[NSMutableArray alloc] initWithCapacity:3] autorelease];
    
    for (NSDictionary* message in msgArray) {
        Message *msgData = [[Message alloc] init];
        msgData.messageId = [message objectForKey:@"lshId"];
        msgData.type = [message objectForKey:@"notifyType"];
        msgData.status = 1;
        msgData.title = [message objectForKey:@"title"];
        msgData.content = [message objectForKey:@"content"];
        msgData.createTime = [message objectForKey:@"createDate"];
        msgData.userId = userId;
//        msgData.itineraryName = [message objectForKey:@"itineraryName"];
//        msgData.subject = [message objectForKey:@"subject"];
        [allMessageArray addObject:msgData];
        [msgData release];
    }
    return allMessageArray;
}
@end
