//
//  UserProfileDataModule.m
//  OneByOneV3
//
//  Created by Abner on 12-9-12.
//
//

#import "UserProfileDataModule.h"
#import "ASIHTTPRequest.h"
#import "JsonTools.h"
#import "NSObject+SBJson.h"
#import "itineraryListData.h"
#import "HelpTools.h"
@interface UserProfileDataModule ()

@end

@implementation UserProfileDataModule
@synthesize profileDataModuleDelegate = _profileDataModuleDelegate;
@synthesize userId = _userId;
@synthesize messageType = _messageType;
@synthesize nickname = _nickname;
@synthesize headIndex = _headIndex;
@synthesize gender = _gender;
@synthesize areaName = _areaName;
@synthesize isUserHeadPic;

-(void)dealloc{
    [_userId release];
    [_messageType release];
    [_nickname release];
    [_headIndex release];
    [_gender release];
    [_areaName release];
    [super dealloc];
}

-(void)requestProfileData{
    self.userId = [HelpTools getAppParam:@"userId"];
    self.messageType = [NSNumber numberWithInt:1];//messageType 1:提交 2:获取
    
    if(!_userId){
        _userId = @"";
    }
    if(!_nickname){
        _nickname = @"";
    }
    if(!_headIndex){
        _headIndex = @"";
    }
    if(!_gender){
        _gender = @"";
    }
    if(!_areaName){
        _areaName = @"";
    }
    
    NSString *str = [NSString stringWithFormat:@"%@",self.userId];
    
    NSDictionary *paramsDic = nil;
    if(isUserHeadPic){
        paramsDic = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:str,self.messageType,self.headIndex,nil] forKeys:[NSArray arrayWithObjects:@"userId",@"messageType",@"headIndex",nil]];
    }else{
        int genderForInt;
        if([self.gender isEqualToString:@"男"]){
            genderForInt = 1;
        }else if([self.gender isEqualToString:@"女"]){
            genderForInt = 2;
        }else{
            genderForInt = 0;
        }
        paramsDic = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:str,self.messageType,self.nickname,[NSNumber numberWithInt:genderForInt],self.areaName,nil] forKeys:[NSArray arrayWithObjects:@"userId",@"messageType",@"nickname",@"gender",@"areaName",nil]];
    }
    
//    NSDictionary *paramsDic = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:str,self.messageType,self.nickname,self.headIndex,self.gender,self.areaName,nil] forKeys:[NSArray arrayWithObjects:@"userId",@"messageType",@"nickname",@"headIndex",@"gender",@"areaName",nil]];
    
    NSString *requestJson = [JsonTools jsonBuilder:Request_UserData params:paramsDic];
    //    NSLog(@"requestJson = %@",requestJson);
    //发送服务器请求
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:WSURL];
    [request setDelegate:self];
    [request appendPostData:[requestJson dataUsingEncoding:NSUTF8StringEncoding]];
    
    [paramsDic release];
    // Default becomes POST when you use appendPostData: / appendPostDataFromFile: / setPostBody:
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *responseData = [request responseData];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//    NSLog(@"*******responseString is **%@",responseString);
    int statusCode = [request responseStatusCode];
    if (statusCode >= 200 && statusCode < 300)
    {
        //解析json
        NSDictionary *resultDic = [JsonTools jsonParser:responseString];
        //NSLog(@"*****resultDic is %@",resultDic);
        if([resultDic count] > 0){
            NSString *resultStatus = [resultDic valueForKey:@"status"];
            [self.profileDataModuleDelegate getProfileDataSuccess:resultStatus];
            if([resultStatus intValue] == 1){
                if([self.headIndex isEqualToString:@""]){
                    [HelpTools setAppParam:self.nickname key:@"userNickName"];
                    [HelpTools setAppParam:self.gender key:@"userSex"];
                    [HelpTools setAppParam:self.areaName key:@"userSite"];
                }else{
                    [HelpTools setAppParam:self.headIndex key:@"userPicIndex"];
                }
            }
        }else{
            [self.profileDataModuleDelegate getProfileDataFailed:NoSeverData];
        }
    }
    else {
        [self.profileDataModuleDelegate getProfileDataFailed:NoConnection];
    }
    
    [responseString release];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"***********%@",[error description]);
    [self.profileDataModuleDelegate getProfileDataFailed:NoConnection];
}

@end
