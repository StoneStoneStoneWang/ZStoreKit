//
//  ZNotiName.h
//  ZNoti
//
//  Created by three stone 王 on 2019/8/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//
@import Foundation;
@import UIKit;
NS_ASSUME_NONNULL_BEGIN

#pragma mark ---- 欢迎界面
FOUNDATION_EXPORT NSString * const ZNotiWelcomeSkip;

#pragma mark ---- 登陆相关

FOUNDATION_EXPORT NSString * const ZNotiLoginSucc;

FOUNDATION_EXPORT NSString * const ZNotiGotoReg;

FOUNDATION_EXPORT NSString * const ZNotiGotoFindPwd;

FOUNDATION_EXPORT NSString * const ZNotiRegSucc;

FOUNDATION_EXPORT NSString * const ZNotiBackLogin;

FOUNDATION_EXPORT NSString * const ZNotiFindPwdSucc;

FOUNDATION_EXPORT NSString * const ZNotiGotoProtocol;

FOUNDATION_EXPORT NSString * const ZNotiUnLogin;

#pragma mark ---- setting

FOUNDATION_EXPORT NSString * const ZNotiGotoModifyPwd;

FOUNDATION_EXPORT NSString * const ZNotiModifyPwdSucc;

FOUNDATION_EXPORT NSString * const ZNotiGotoBlack;

FOUNDATION_EXPORT NSString * const ZNotiLogout;

#pragma mark ---- 个人中心点击
FOUNDATION_EXPORT NSString * const ZNotiUserInfo;

FOUNDATION_EXPORT NSString * const ZNotiAboutUs;

FOUNDATION_EXPORT NSString * const ZNotiSetting;

FOUNDATION_EXPORT NSString * const ZNotiFocus;

FOUNDATION_EXPORT NSString * const ZNotiPrivacy;

FOUNDATION_EXPORT NSString * const ZNotiMyAddress;

FOUNDATION_EXPORT NSString * const ZNotiMyCircle;

FOUNDATION_EXPORT NSString * const ZNotiMyOrder;

FOUNDATION_EXPORT NSString * const ZNotiAvatar;

FOUNDATION_EXPORT NSString * const ZNotiContactUs;

#pragma mark ---- person

FOUNDATION_EXPORT NSString * const ZNotiAddBlack;

FOUNDATION_EXPORT NSString * const ZNotiRemoveBlack;

FOUNDATION_EXPORT NSString * const ZNotiAddFocus;

FOUNDATION_EXPORT NSString * const ZNotiRemoveFocus;

#pragma mark ---- 圈子

FOUNDATION_EXPORT NSString * const ZNotiCircleItemClick;

FOUNDATION_EXPORT NSString * const ZNotiMyCircleItemClick;

FOUNDATION_EXPORT NSString * const ZNotiCircleShare;

FOUNDATION_EXPORT NSString * const ZNotiCirclePublishSucc;

FOUNDATION_EXPORT NSString * const ZNotiCircleGotoReport;

FOUNDATION_EXPORT NSString * const ZNotiCircleImageClick;

FOUNDATION_EXPORT NSString * const ZNotiCircleVideoClick;

FOUNDATION_EXPORT NSString * const ZNotiCircleAudioClick;

#pragma mark ---- 商城

FOUNDATION_EXPORT NSString * const ZNotiStoreClick;

FOUNDATION_EXPORT NSString * const ZNotiStoreDetailBuy;

FOUNDATION_EXPORT NSString * const ZNotiStoreBuy;

FOUNDATION_EXPORT NSString * const ZNotiStoreCart;

FOUNDATION_EXPORT NSString * const ZNotiStoreAddress;

FOUNDATION_EXPORT NSString * const ZNotiStoreOrder;

#pragma mark ---- 地址

FOUNDATION_EXPORT NSString * const ZNotiAddressSelect;

FOUNDATION_EXPORT NSString * const ZNotiAreaSelect;

#pragma mark ---- banner

FOUNDATION_EXPORT NSString * const ZNotiBannerClick;

#pragma mark ---- item


FOUNDATION_EXPORT NSString * const ZNotiItemClick;

@interface ZNotiConfigration: NSObject

+ (void)postNotificationWithName:(_Nonnull NSNotificationName) name
                        andValue:(nullable id)value
                         andFrom:(nullable UIViewController *)from;

@end

NS_ASSUME_NONNULL_END
