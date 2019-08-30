//
//  ZStoreRootManager.m
//  ZStoreTest
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZStoreRootManager.h"
#import "ZNaviConfigImpl.h"
#import "ZFragmentConfig.h"

@import JXTAlertManager;
@import ZNoti;
@import ZSign;
@import ZNavi;
@import ZHud;
@import ZWelcome;
@import ZLogin;
@import ZPravicy;
@import ZPassword;
@import ZReg;
@import ZCache;
@import ZProfile;
@import ZAbout;
@import ZSetting;
@import ZBlack;
@import ZFocus;
@import ZUserInfo;
@import ZWechat;
@import ZAMap;

#import <ZAMapV/ZAMapViewController.h>

@implementation WLMainBean

+ (instancetype)mainBeanWithType:(WLMainType )type andTitle:(NSString *)title andTag:(NSString *)tag andNormalIcon:(NSString *)normalIcon andSelectedIcon:(NSString *)selectedIcon {
    
    return [[self alloc] initWithType:type andTitle:title andTag:tag andNormalIcon:normalIcon andSelectedIcon:selectedIcon];
}

- (instancetype)initWithType:(WLMainType )type andTitle:(NSString *)title andTag:(NSString *)tag andNormalIcon:(NSString *)normalIcon andSelectedIcon:(NSString *)selectedIcon {
    
    if (self = [super init]) {
        
        self.type = type;
        
        self.title = title;
        
        self.tag = tag;
        
        self.normalIcon = normalIcon;
        
        self.selectedIcon = selectedIcon;
    }
    return self;
}

@end

static ZStoreRootManager *manager = nil;

@implementation ZStoreRootManager

+ (instancetype)shared {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [self new];
    });
    return manager;
}

- (NSArray *)tabs {
    if (!_tabs) {
        
        WLMainBean *m1 = [WLMainBean mainBeanWithType:WLMainTypeHome andTitle:@"溢米商城" andTag:@"" andNormalIcon:@"首页未" andSelectedIcon:@"首页选中"];
        
        WLMainBean *m2 = [WLMainBean mainBeanWithType:WLMainTypeCart andTitle:@"购物车" andTag:@"购物车" andNormalIcon:@"购物车未" andSelectedIcon:@"购物车选中"];
        
        WLMainBean *m3 = [WLMainBean mainBeanWithType:WLMainTypeProfile andTitle:@"个人中心" andTag:@"" andNormalIcon:@"个人中心未" andSelectedIcon:@"个人中心选中"];
        
        WLMainBean *m4 = [WLMainBean mainBeanWithType:WLMainTypeStore andTitle:@"商城" andTag:@"" andNormalIcon:@"商城未" andSelectedIcon:@"商城选中"];
        
        _tabs = @[m1,m4,m2,m3];
    }
    
    return _tabs;
}

- (NSMutableArray *)catas {
    if (!_catas) {
        
        _catas = [@[@{@"title": @"鱼食",@"isSelected":@(true),@"tag":@"鱼食"},
                    @{@"title": @"观赏鱼",@"isSelected":@(false),@"tag":@"观赏鱼"},
                    @{@"title": @"热带鱼",@"isSelected":@(false),@"tag":@"热带鱼"},
                    @{@"title": @"鱼具(养)",@"isSelected":@(false),@"tag":@"鱼具(养)"},
                    @{@"title": @"渔具(钓)",@"isSelected":@(false),@"tag":@"渔具(钓)"}] mutableCopy];
    }
    return _catas;
}

@end

@implementation ZStoreRootManager (Config)

- (void)makeRoot:(UIResponder<UIApplicationDelegate> *)appdelegate {
    
    if (appdelegate) {
        
        [ZConfigure initWithAppKey:@"0e37c36a33b547fe9fd9d2a21dfa4479" domain:@"https://zhih.ecsoi.com/" pType:ZConfigureTypeCircle];
        
#if ZAppFormMapOne
        
        [[ZAMapUtil shared] registerApiKey:@"5deb6638fec2c948724920c41a0a6bc0"];
#endif
        //
        [ZNavigationController initWithConfig:[ZNaviConfigImpl new]];
        
        appdelegate.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstLogin"]) {
            
            appdelegate.window.rootViewController = [ZWelcomeViewController createWelcome];
            
        } else {
            
            [[ZAccountCache shared] wl_queryAccount];
#if ZAppFormMapOne
            if ([ZAccountCache shared] .isLogin) {
                
                appdelegate.window.rootViewController = [[ZNavigationController alloc] initWithRootViewController:[ZAMapViewController new]];
            } else {
                
                appdelegate.window.rootViewController = [[ZNavigationController alloc] initWithRootViewController:[ZLoginViewController new]];
            }
#endif
        }
        
        [appdelegate.window makeKeyAndVisible];
        
        [ZHudUtil configHud];
        
        [ZWXManager wxRegisterAppKey:@""];
    }
    
    [self addNotification];
}

- (void)addNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onskipTap:) name:ZNotiWelcomeSkip object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoRegTap:) name:ZNotiGotoReg object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoFindPwdTap:) name:ZNotiGotoFindPwd object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoProtocolTap:) name:ZNotiGotoProtocol object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onBackLoginTap:) name:ZNotiBackLogin object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLoginSuccTap:) name:ZNotiLoginSucc object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLoginSuccTap:) name:ZNotiRegSucc object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSettingTap:) name:ZNotiSetting object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoBlackTap:) name:ZNotiGotoBlack object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onFindPwdSucc:) name:ZNotiFindPwdSucc object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onModifyPwdSucc:) name:ZNotiModifyPwdSucc object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoUserInfoTap:) name:ZNotiUserInfo object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoFocusTap:) name:ZNotiFocus object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUnLogin:) name:ZNotiUnLogin object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoModifyPwdTap:) name:ZNotiGotoModifyPwd object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLogoutTap:) name:ZNotiLogout object:nil ];
    //
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoMyOrderTap:) name:ZNotiMyOrder object:nil ];
    //
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoMyAddressTap:) name:ZNotiMyAddress object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoAboutTap:) name:ZNotiAboutUs object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoProtocolTap:) name:ZNotiPrivacy object:nil ];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCircleClickTap:) name:ZNotiCircleClick object:nil ];
    //
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCircleReportTap:) name:ZNotiCircleGotoReport object:nil ];
    //
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCircleShareTap:) name:ZNotiCircleShare object:nil ];
    //
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCirclePublishSuccTap:) name:ZNotiCirclePublishSucc object:nil ];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onStoreBannerTap:) name:ZNotiBannerClick object:nil ];
}

#pragma mark -- WelcomeSkip
- (void)onskipTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"isFirstLogin"];
    
    if (userInfo && userInfo[@"from"]) {
#if ZAppFormMapOne
        UIViewController *from = userInfo[@"from"];
        
        ZNavigationController *anvi = [[ZNavigationController alloc] initWithRootViewController:[ZLoginViewController
                                                                                                 new]];
        anvi.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        
        [from presentViewController:anvi animated:true completion:nil];
#endif
    }
}
#pragma mark -- ZNotiGotoReg

- (void)onLoginSuccTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        ZTNavigationController *navi = [[ZTNavigationController alloc] initWithRootViewController:[ZAMapViewController new]] ;
        
        [UIApplication sharedApplication].delegate.window.rootViewController = navi;
    }
}

- (void)onGotoRegTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        ZRegViewController *swiftLogin = [ZRegViewController new];
        
        [from.navigationController pushViewController:swiftLogin animated:true];
    }
}

- (void)onBackLoginTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        [from.navigationController popViewControllerAnimated:true];
    }
}

- (void)onGotoProtocolTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        ZPravicyViewController *pro = [ZPravicyViewController new];
        
        [from.navigationController pushViewController:pro animated:true];
    }
}

- (void)onGotoFindPwdTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        ZFindPwdViewController *findPwd = [ZFindPwdViewController new];
        
        [from.navigationController pushViewController:findPwd animated:true];
    }
}

- (void)onGotoModifyPwdTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        ZModifyViewController *modifyPwd = [ZModifyViewController new];
        
        [from.navigationController pushViewController:modifyPwd animated:true];
    }
}

- (void)onFindPwdSucc:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        [from.navigationController popViewControllerAnimated:true];
    }
}

- (void)onModifyPwdSucc:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        [from.navigationController popViewControllerAnimated:true];
    }
}
- (void)onGotoAboutTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        ZAboutViewController *about = [ZAboutViewController new];
        
        [from.navigationController pushViewController:about animated:true];
    }
}

- (void)onSettingTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        ZSettingViewController *setting = [ZSettingViewController new];
        
        [from.navigationController pushViewController:setting animated:true];
    }
}

- (void)onGotoBlackTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
#if ZAppFormMapOne
        UIViewController *from = userInfo[@"from"];
        
        ZBlackViewController *black = [ZBlackViewController new];
        
        [from.navigationController pushViewController:black animated:true];
#endif
    }
}

- (void)onGotoFocusTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
#if ZAppFormMapOne
        UIViewController *from = userInfo[@"from"];
        
        ZFocusViewController *focus = [ZFocusViewController new];
        
        [from.navigationController pushViewController:focus animated:true];
#endif
    }
}
- (void)onGotoUserInfoTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        ZUserInfoViewController *userInfo = [ZUserInfoViewController new];
        
        [from.navigationController pushViewController:userInfo animated:true];
    }
}

- (void)onUnLogin:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
#if ZAppFormMapOne
        
        
#else
        
        UIViewController *from = userInfo[@"from"];
        
        [from  jxt_showAlertWithTitle:@"您的还未登录" message:@"点击确定前往登录" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            
            alertMaker.
            addActionCancelTitle(@"取消").
            addActionDefaultTitle(@"前往登陆");
            
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            
            if ([action.title isEqualToString:@"取消"]) {
                
            }
            else if ([action.title isEqualToString:@"前往登陆"]) {
                
                ZTNavigationController *navi = [[ZTNavigationController alloc] initWithRootViewController:[ZLoginViewController new]] ;
                
                [from presentViewController:navi animated:true completion:nil];
            }
        }];
#endif
    }
}
- (void)onLogoutTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        [from  jxt_showAlertWithTitle:@"退出登录?" message:@"退出登陆不清楚缓存信息" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            
            alertMaker.
            addActionCancelTitle(@"取消").
            addActionDefaultTitle(@"确定");
            
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            
            if ([action.title isEqualToString:@"取消"]) {
                
            }
            else if ([action.title isEqualToString:@"确定"]) {
                
                ZTNavigationController *navi = [[ZTNavigationController alloc] initWithRootViewController:[ZLoginViewController new]] ;
                
                [UIApplication sharedApplication].delegate.window.rootViewController = navi;
                
                [[ZAccountCache shared] clearAccount];
            }
        }];
    }
}

@end
