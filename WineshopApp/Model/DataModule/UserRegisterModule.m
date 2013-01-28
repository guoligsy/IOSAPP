//
//  UserRegisterModule.m
//  OneByOneV3
//
//  Created by Eric Yang on 9/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserRegisterModule.h"
#import "ASIHTTPRequest.h"
#import "JsonTools.h"
#import "NSObject+SBJson.h"
#import "itineraryListData.h"
#import "HelpTools.h"
@interface UserRegisterModule ()

@end

@implementation UserRegisterModule
@synthesize registerDataModuleDelegate = _registerDataModuleDelegate;
@synthesize account = _account;
@synthesize pwd = _pwd;
@synthesize registerType = _registerType;
@synthesize accountType = _accountType;
@synthesize nickname = _nickname;
@synthesize activateCode = _activateCode;
@synthesize userId = _userId;

-(void)dealloc{
    [_accountType release];
    [_account release];
    [_pwd release];
    [_registerType release];
    [_nickname release];
    [_userId release];
    [_activateCode release];
    [super dealloc];
}

/*
 registerType  1:获取验证码  2：注册
 accountType  1:mail  2:phone  3:id
 */

-(void)requestRegisterData{
    
    if(!_account){
        _account = @"";
    }
    if(!_accountType){
        _accountType = [NSNumber numberWithInt:0];
    }
    if(!_registerType){
        _registerType = [NSNumber numberWithInt:0];
    }
    if(!_nickname){
        _nickname = @"";
    }
    if(!_pwd){
        _pwd = @"";
    }
    if(!_userId){
        _userId = @"";
    }
    if(!_activateCode){
        _activateCode = @"";
    }
    
    NSString *str = [NSString stringWithFormat:@"%@",self.userId];
    
    NSDictionary *paramsDic = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:self.account,self.accountType,self.registerType,self.nickname,self.pwd,str,self.activateCode,nil] forKeys:[NSArray arrayWithObjects:@"id",@"idType",@"registerType",@"nickname",@"password",@"userId",@"verifyCode",nil]];
    
    NSString *requestJson = [JsonTools jsonBuilder:Request_Register params:paramsDic];
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
//        NSLog(@"*****resultDic is %@",resultDic);
        if([resultDic count] > 0){
            NSString *statusStr = [resultDic valueForKey:@"status"];
            NSString *userId = [resultDic valueForKey:@"userId"];
            if(userId){
//                NSLog(@"*********userID*%@",userId);
                [HelpTools setAppParam:userId key:@"userId"];
            }
            NSString *regiserTimes = [resultDic valueForKey:@"times"];
            
            if([statusStr intValue] == 1){
                if(([self.registerType intValue] == 2)&&([self.accountType intValue] == 2)){
                    [HelpTools setAppParam:self.account key:@"accountNum"];
                    [HelpTools setAppParam:self.pwd key:@"password"];
                    [HelpTools setAppParam:self.nickname key:@"userNickName"];
                    [HelpTools setAppParam:@"0" key:@"userPicIndex"];
                    [HelpTools setAppParam:@"" key:@"userSex"];
                    [HelpTools setAppParam:@"" key:@"userSite"];
                }
                
                if(([self.registerType intValue] == 1)&&([self.accountType intValue] == 1)){
//                    [HelpTools setAppParam:self.account key:@"accountNum"];
//                    [HelpTools setAppParam:self.pwd key:@"password"];
//                    [HelpTools setAppParam:self.nickname key:@"userNickName"];
//                    [HelpTools setAppParam:@"0" key:@"userPicIndex"];
//                    [HelpTools setAppParam:@"" key:@"userSex"];
//                    [HelpTools setAppParam:@"" key:@"userSite"];
                }
                
                [self.registerDataModuleDelegate getRegisterDataSuccess:statusStr userId:userId times:regiserTimes];
            }else {
                [self.registerDataModuleDelegate getRegisterDataSuccess:statusStr userId:userId times:nil];
            }
        }else{
            [self.registerDataModuleDelegate getRegisterDataFailed:NoSeverData];
        }
    }
    else {
        [self.registerDataModuleDelegate getRegisterDataFailed:NoConnectionAndData];
    }
    
    [responseString release];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"***********%@",[error description]);
    [self.registerDataModuleDelegate getRegisterDataFailed:NoConnection];
}

@end
