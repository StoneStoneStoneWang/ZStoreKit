//
//  ZWXManager.h
//  ZWechat
//
//  Created by three stone 王 on 2019/8/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
NS_ASSUME_NONNULL_BEGIN



typedef NS_ENUM(NSInteger ,ZWXActionType) {
    
    ZWXActionTypeCancle NS_SWIFT_NAME(cancle) = 1,
    
    ZWXActionTypeConfirm NS_SWIFT_NAME(confirm) = 2,
    
    ZWXActionTypeRefused NS_SWIFT_NAME(refused) = 3,
    
    ZWXActionTypeNone NS_SWIFT_NAME(none) = 4
};

typedef void(^ZWXApiBlock)(ZWXActionType type,NSString *_Nonnull msg);

@interface ZWXManager : NSObject 

+ (BOOL)wxRegisterAppKey:(NSString *)appKey;

+ (void)wxLoginWithApiBlock:(ZWXApiBlock )apiBlock;

+ (void)wxPayWithPayReq:(PayReq *_Nonnull)payReq andApiBlock:(ZWXApiBlock )apiBlock;

+ (void)wxShareWithTitle:(NSString * _Nonnull)title
                 andDesc:(NSString * _Nonnull)desc
           andThumbImage:(NSString * _Nullable)thumbImage
           andWebPageUrl:(NSString * _Nullable)webpageUrl
                andScene:(int)scene
             andApiBlock:(ZWXApiBlock )apiBlock;

+ (BOOL)handleOpenUrl:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
