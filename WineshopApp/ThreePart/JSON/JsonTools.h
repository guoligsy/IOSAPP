//
//  JsonTools.h
//  OneByOne
//
//  Created by  on 12-2-1.
//  Copyright (c) 2012年 Hiker. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    Request_CityAll,
    Request_CitytourItem,
    Request_ScenicList,
    Request_ScenicPointList,
    Request_PushMsg,
    Request_DownloadInfo,
    Request_Feedback,
    Request_CheckUpdata,
    Request_Collection,
    Request_CollectionScenic,
    Request_ServerIP,
    Request_Scenic_Detail,
    Request_HotelOrShop_Detail,
    Request_Scenic_Spot,
    Request_Member_Location, 
    Request_Login,
    Request_ItineraryDetail,
    Request_SysMessage,
    Request_Complaints,
    Request_Score,
    Request_CityDownloadInfo,
    Request_AllItinerary,
    Request_AllRecommendItinerary,
    Request_CityGuide,
    Request_BusinessesData,
    Request_Aroundme,
    Request_Search,
    Request_CommentList,
    Request_Special,
    Request_UploadItinerary,
    Request_Register,
    Request_UserData,
    Request_FeedBack,
    Request_DataCollect,//add by gsy
    Request_Version,
    Request_AutoCompletionValue,
    Request_AutoPlayDataCollect,//add by gsy

    Request_AutoTrafficCompletionValue,
    Request_Activity,

    Request_RecommendActivityList

}JsonType;

@interface JsonTools : NSObject


+(NSString *)jsonBuilder:(JsonType )type params:(NSDictionary *)paramsDic;
+(NSDictionary *)jsonParser:(NSString *)jsonString;
//+(NSMutableArray*)itineraryUpdatedInfoParser:(NSDictionary*)dic withType:(NSString*)aType;
//+(NSMutableArray*)itineraryDetailParser:(NSDictionary*)dic withType:(NSString*)aType;
+(NSMutableArray*)contentsDetailParser:(NSDictionary*)dic;
+(NSMutableArray*)itineraryListParser:(NSDictionary*)dic;
+(NSMutableArray*)messageArrayParser:(NSArray *)msgArray userId:(NSString *)userId;
@end
