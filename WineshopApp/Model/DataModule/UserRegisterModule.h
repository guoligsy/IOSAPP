//
//  UserRegisterModule.h
//  OneByOneV3
//
//  Created by Eric Yang on 9/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UserRegisterModuleDelegate <NSObject>

-(void)getRegisterDataSuccess:(NSString*)registerResult userId:(NSString *)userid times:(NSString *)times;
-(void)getRegisterDataFailed:(ErrorType)faildReason;

@end

@interface UserRegisterModule : NSObject{
    id<UserRegisterModuleDelegate> _registerDataModuleDelegate;
    
    NSString *_account;
    NSNumber *_registerType;
    NSNumber *_accountType;
    NSString *_pwd;
    NSString *_nickname;
    NSString *_userId;
    NSString *_activateCode;
}

@property(assign,nonatomic)id<UserRegisterModuleDelegate>registerDataModuleDelegate;
@property(retain,nonatomic) NSString *account;
@property(retain,nonatomic) NSNumber *registerType;
@property(retain,nonatomic) NSNumber *accountType;
@property(retain,nonatomic) NSString *pwd;
@property(retain,nonatomic) NSString *nickname;
@property(retain,nonatomic) NSString *userId;
@property(retain,nonatomic) NSString *activateCode;

-(void)requestRegisterData;
@end
