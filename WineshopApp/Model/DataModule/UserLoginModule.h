//
//  UserLoginModule.h
//  OneByOneV3
//
//  Created by Eric Yang on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UserLoginModuleDelegate <NSObject>

//-(void)getLoginDataSuccess:(NSString*)loginResult withData:(NSDictionary *)loginDataDic;
-(void)getLoginDataSuccess:(NSString*)loginResult;
-(void)getLoginDataFailed:(ErrorType)faildReason;

@end

@interface UserLoginModule : NSObject{
    id<UserLoginModuleDelegate> _loginDataModuleDelegate;
    NSString *_accountNum;
    NSString *_pwd;
    NSNumber *_loginType;
//    NSInteger _memberId;
}

@property(assign,nonatomic)id<UserLoginModuleDelegate>loginDataModuleDelegate;
@property(retain,nonatomic)NSString *accountNum;
@property(retain,nonatomic)NSString *pwd;
@property(retain,nonatomic)NSNumber *loginType;
//@property(nonatomic)NSInteger memberId;
-(void)requestLoginData;
@end
