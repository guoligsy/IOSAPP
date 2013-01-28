//
//  UserLoginModule.m
//  OneByOneV3
//
//  Created by Eric Yang on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserLoginModule.h"
#import "ASIHTTPRequest.h"
#import "JsonTools.h"
#import "NSObject+SBJson.h"
#import "itineraryListData.h"
#import "HelpTools.h"
@interface UserLoginModule ()

@end

@implementation UserLoginModule
@synthesize loginDataModuleDelegate = _loginDataModuleDelegate;
@synthesize accountNum = _accountNum;
@synthesize pwd = _pwd;
@synthesize loginType = _loginType;
//@synthesize memberId = _memberId;

-(void)dealloc{
    [_accountNum release];
    [_pwd release];
    [_loginType release];
    [super dealloc];
}

-(void)requestLoginData{
    
    NSDictionary *paramsDic = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:self.accountNum,self.loginType,self.pwd,nil] forKeys:[NSArray arrayWithObjects:@"id",@"loginType",@"password",nil]];

    NSString *requestJson = [JsonTools jsonBuilder:Request_Login params:paramsDic];
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
            NSString *statusStr = [resultDic valueForKey:@"status"];
            if([statusStr intValue] == 1){
                [HelpTools setAppParam:self.accountNum key:@"accountNum"];
                [HelpTools setAppParam:self.pwd key:@"password"];
                NSString *headIndex = [NSString stringWithFormat:@"%@",[resultDic valueForKey:@"headIndex"]];
                [HelpTools setAppParam:headIndex key:@"userPicIndex"];
                [HelpTools setAppParam:[resultDic valueForKey:@"nickname"] key:@"userNickName"];
                NSString *userId = [NSString stringWithFormat:@"%@",[resultDic valueForKey:@"userId"]];
                [HelpTools setAppParam:userId key:@"userId"];
                
                NSString *areaName = [resultDic valueForKey:@"areaName"];
                //NSLog(@"%@",areaName);
                if(areaName && ![areaName isEqualToString:@"0"]){
                    [HelpTools setAppParam:areaName key:@"userSite"];
                }else{
                    [HelpTools setAppParam:@"" key:@"userSite"];
                }
                
                if([[resultDic valueForKey:@"gender"] intValue] == 1){
                    [HelpTools setAppParam:@"男" key:@"userSex"];
                }else if([[resultDic valueForKey:@"gender"] intValue] == 2){
                    [HelpTools setAppParam:@"女" key:@"userSex"];
                }else {
                    [HelpTools setAppParam:@"" key:@"userSex"];
                }
                
                [self.loginDataModuleDelegate getLoginDataSuccess:statusStr];
            }else {
                [self.loginDataModuleDelegate getLoginDataSuccess:statusStr];
            }
        }else {
            [self.loginDataModuleDelegate getLoginDataFailed:NoSeverData];
        }
    }
    else {
        [self.loginDataModuleDelegate getLoginDataFailed:NoConnectionAndData];
    }
    
    [responseString release];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"***********%@",[error description]);
    //    [self getAllItineraryFromDB:@"1" mId:_memberId];
    [self.loginDataModuleDelegate getLoginDataFailed:NoConnection];
}

@end
