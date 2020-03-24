//
//  ZSignConfigration.h
//  ZSign
//
//  Created by three stone 王 on 2019/8/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger ,ZConfigureType) {
    /** 圈子  */
    ZConfigureTypeCircle NS_SWIFT_NAME(circle) = 1,
    /** 商城  */
    ZConfigureTypeStore NS_SWIFT_NAME(store) = 2,
    /** 地图  */
    ZConfigureTypeMap NS_SWIFT_NAME(map) = 3,
    /** 游戏  */
    ZConfigureTypeGame NS_SWIFT_NAME(game) = 4,
    /** Mix  */
    ZConfigureTypeMix NS_SWIFT_NAME(mix) = 5,
};

NS_ASSUME_NONNULL_BEGIN

@interface ZConfigure : NSObject

/** 初始化所有组件产品
 @param appKey 开发者在官网申请的appKey.
 @param domain 请求主地址
 @param ptype 类型 1.圈子 2.商城 3.待定 默认1 圈子
 */
+ (void)initWithAppKey:(NSString * _Nonnull)appKey
                domain:(NSString * _Nonnull)domain
                 pType:(ZConfigureType)ptype;

+ (NSString *)createSign:(NSDictionary *_Nonnull)json;

/**
 @result signature
 */
+ (NSString *)fetchSignature;

+ (NSString *)fetchAppKey;

+ (NSString *)fetchDomain;

+ (NSString *)fetchSmsSign;

+ (NSString *)fetchSmsLogin;

+ (NSString *)fetchSmsPwd;

+ (ZConfigureType )fetchPType;

@end

NS_ASSUME_NONNULL_END
