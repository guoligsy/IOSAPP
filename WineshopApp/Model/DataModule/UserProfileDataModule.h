//
//  UserProfileDataModule.h
//  OneByOneV3
//
//  Created by Abner on 12-9-12.
//
//

#import <Foundation/Foundation.h>

@protocol UserProfileModuleDelegate <NSObject>

-(void)getProfileDataSuccess:(NSString*)ProfileResult;
-(void)getProfileDataFailed:(ErrorType)faildReason;

@end

@interface UserProfileDataModule : NSObject{
    id<UserProfileModuleDelegate> _profileDataModuleDelegate;
    
    NSString *_userId;
    NSNumber *_messageType;
    NSString *_nickname;
    NSString *_headIndex;
    NSString *_gender;
    NSString *_areaName;
    BOOL isUserHeadPic;
}

@property(assign,nonatomic)id<UserProfileModuleDelegate>profileDataModuleDelegate;
@property(retain,nonatomic) NSString *userId;
@property(retain,nonatomic) NSNumber *messageType;
@property(retain,nonatomic) NSString *nickname;
@property(retain,nonatomic) NSString *headIndex;
@property(retain,nonatomic) NSString *gender;
@property(retain,nonatomic) NSString *areaName;
@property(nonatomic)BOOL isUserHeadPic;

-(void)requestProfileData;
@end
