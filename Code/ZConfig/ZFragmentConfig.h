//
//  ZFragmentConfig.h
//  ZFragment
//
//  Created by three stone 王 on 2019/8/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#pragma mark ---- 类型App

#define ZAppFormCircle 0 // 圈子类型

#define ZAppFormStore 0 // 商城类型

#define ZAppFormMap 1 // 地图类型

#define ZAppFormMapOne 1

#define ZAppFormMapTwo 0

#if ZAppFormMapOne

#define ZKeyValues @[\
@{@"type": @"时间",@"value": @"",@"place": @"请选择上门维修时间"} ,\
@{@"type": @"手机号",@"value": @"",@"place": @"输入联系人手机号"} ,\
@{@"type": @"详细地址",@"value": @"",@"place": @"输入门牌号"} ,\
@{@"type": @"备注",@"value": @"",@"place": @"请输入备注信息"} ,\
]

#define ZLocationIcon "定位"

#define ZAnnotationIcon "大头针"

#define ZLightCircle "光圈"

#define ZNabla "倒三角"

#define ZCompleteItemTitle "保洁预约"

#elif ZAppFormMapTwo

#endif


#define ZAppKey ""

#define ZWXKey ""

#define ZUMKey ""

#define ZWXSecret ""

#pragma mark ---- 主色值
#define ZFragmentColor "#333333"

#define ZBackIcon "返回"

#define ZLogoIcon "Logo"

#pragma mark ---- 欢迎界面 两种样式 选择第一种样式

#define ZWelcomeImgs @[@"画板1",@"画板"]

#define ZWelcomeFormOne 0

#define ZWelcomeFormTwo 1

#pragma mark ---- 登陆、注册、密码、协议、图片等

#define ZLoginFormOne 1

#define ZLoginFormTwo 0

#define ZPhoneIcon "手机号"

#define ZPasswordIcon "密码"

#define ZVCodeIcon "验证码"

#define ZPasswordNormalIcon "闭眼"

#define ZPasswordSelectIcon "睁眼"
// 是否是强制登陆
#define ZForceLogin 1

#pragma mark ---- 我的关注、黑名单

#define ZBlackFormOne 1

#define ZFocusFormOne 1

// 个人中心 ----------------------------------
#pragma mark ---- profile

#define ZProfileFormOne 1

#define ZProfileFormTwo 0

#define AboutIcon "关于我们"

#define ContactUsIcon "联系我们"

#define FocusIcon "我的关注"

#define PravicyIcon "隐私政策"

#define UserInfoIcon "我的资料"

#define SettingIcon "设置"

#define CircleIcon "我的发布"

#define OrderIcon "我的订单"

#define AddressIcon "我的地址"

#define ZPhoneNum "+8618612598269"
