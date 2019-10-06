//
//  ZFragmentConfig.h
//  ZFragment
//
//  Created by three stone 王 on 2019/8/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#pragma mark ---- 类型App

#define ZAppFormGlobalOne 0 // 地图类型 含有抽屉

#define ZAppFormGlobalTwo 1 // 地图类型 不含抽屉

#define ZAppFormGlobalThree 0 // 朋友圈类型

#define ZCircleFormOne 1  // 朋友圈类型 1 图片比例 4 / 3 左边

#if ZAppFormGlobalOne

#define ZKeyValues @[\
@{@"type": @"时间",@"value": @"",@"place": @"请选择上门服务时间"} ,\
@{@"type": @"手机号",@"value": @"",@"place": @"输入联系人手机号"} ,\
@{@"type": @"详细地址",@"value": @"",@"place": @"输入门牌号"} ,\
@{@"type": @"备注",@"value": @"",@"place": @"请输入备注信息"} ,\
]

#define ZLocationIcon "定位"

#define ZAnnotationIcon "大头针"

#define ZLightCircle "光圈"

#define ZNabla "倒三角"

#define ZCompleteItemTitle "保洁预约"

#define ZAliMapKey "1d08f272709f1dc107f6a08a734d3ef6"

#define ZReportKeyValues @[\
@{@"type": @"1",@"title": @"干活不用心",@"isSelected": @true} ,\
@{@"type": @"2",@"title": @"二次收费",@"isSelected": @false} ,\
@{@"type": @"3",@"title": @"色情暴力",@"isSelected": @false} ,\
@{@"type": @"4",@"title": @"违规操作",@"isSelected": @false} ,\
@{@"type": @"5",@"title": @"其他",@"isSelected": @false} ,\
]

#define ZEvaluateKeyValues @[\
@{@"type": @"1",@"title": @"非常满意",@"isSelected": @true} ,\
@{@"type": @"2",@"title": @"一般",@"isSelected": @false} ,\
@{@"type": @"3",@"title": @"不满意",@"isSelected": @false} ,\
@{@"type": @"5",@"title": @"其他",@"isSelected": @false} ,\
]

#define ZReportHeaderText "1.保洁人员是我们公司内部员工,我们竭诚为您服务\n \
2.您的举报十分关键,我们会根据您的举报,调查我们的保洁人员,如果属实我们会对保洁人员职业道德培训和思想教育培训,严重者开除处理、移交公安机关\n \
3.经过我们的调查,如果您的举报为虚假、恶意举报,我们将会把您拉入黑名单并向公安机关报案,严重者向法院提起诉讼。\n \
4.双方遵守遵守契约精神,契约精神是对双方最有效的约束,不局限于书面合同、口头约定\n \
5.最终解释权归本公司所有,我们的目的是中国最大的线上保洁公司。"

#define ZGoldCleanerTag "金牌保洁"

#elif ZAppFormGlobalTwo

#define ZKeyValues @[\
@{@"type": @"时间",@"value": @"",@"place": @"请选择上门服务时间"} ,\
@{@"type": @"手机号",@"value": @"",@"place": @"输入联系人手机号"} ,\
@{@"type": @"详细地址",@"value": @"",@"place": @"输入门牌号"} ,\
@{@"type": @"备注",@"value": @"",@"place": @"请输入备注信息"} ,\
]

#define ZLocationIcon "定位"

#define ZAnnotationIcon "大头针"

#define ZLightCircle "光圈"

#define ZNabla "倒三角"

#define ZCompleteItemTitle "预约保洁服务"

#define ZAliMapKey "07ae3075c36411b19429c9006f4ae9c3"

#define ZReportKeyValues @[\
@{@"type": @"1",@"title": @"干活不用心",@"isSelected": @true} ,\
@{@"type": @"2",@"title": @"二次收费",@"isSelected": @false} ,\
@{@"type": @"3",@"title": @"色情暴力",@"isSelected": @false} ,\
@{@"type": @"4",@"title": @"损坏财物",@"isSelected": @false} ,\
@{@"type": @"5",@"title": @"其他",@"isSelected": @false} ,\
]

#define ZEvaluateKeyValues @[\
@{@"type": @"1",@"title": @"非常满意",@"isSelected": @true} ,\
@{@"type": @"2",@"title": @"一般",@"isSelected": @false} ,\
@{@"type": @"3",@"title": @"不满意",@"isSelected": @false} ,\
@{@"type": @"5",@"title": @"其他",@"isSelected": @false} ,\
]

#define ZReportHeaderText "七小福保洁竭诚为您服务\n \
1.保洁人员是我们公司内部员工,我们竭诚为您服务\n \
2.您的举报十分关键,我们会根据您的举报,调查我们的保洁人员,如果属实我们会对保洁人员职业道德培训和思想教育培训,严重者开除处理、移交公安机关\n \
3.经过我们的调查,如果您的举报为虚假、恶意举报,我们将会把您拉入黑名单并向公安机关报案,严重者向法院提起诉讼。\n \
4.双方遵守遵守契约精神,契约精神是对双方最有效的约束,不局限于书面合同、口头约定\n \
5.最终解释权归本公司所有,我们的目的是中国最大的线上保洁公司。"

#define ZGoldCleanerTag "金牌保洁"

#elif ZAppFormGlobalThree

#define ZReportKeyValues @[\
@{@"type": @"1",@"title": @"标题夸张",@"isSelected": @true} ,\
@{@"type": @"2",@"title": @"低俗色情",@"isSelected": @false} ,\
@{@"type": @"3",@"title": @"广告软文",@"isSelected": @false} ,\
@{@"type": @"4",@"title": @"内容不实",@"isSelected": @false} ,\
@{@"type": @"5",@"title": @"涉嫌违法犯罪",@"isSelected": @false} ,\
@{@"type": @"6",@"title": @"其他问题",@"isSelected": @false} ,\
]

#endif

#pragma mark ---- 主色值
#define ZFragmentColor "#FF9A9E"

#define ZBackIcon "返回"

#define ZLogoIcon "Logo"

#pragma mark ---- 欢迎界面 两种样式 选择第一种样式

#define ZWelcomeImgs @[@"画板1",@"画板2"]

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
#define ZForceLogin 0

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

#define UserInfoIcon "用户资料"

#define SettingIcon "设置"

#define CircleIcon "我的发布"

#define OrderIcon "我的订单"

#define AddressIcon "我的地址"

#define ZPhoneNum "+0314-8081025"

#define ZMoreIcon "更多"

#define ZNormalIcon "未选中"

#define ZSelectedIcon "选中"
