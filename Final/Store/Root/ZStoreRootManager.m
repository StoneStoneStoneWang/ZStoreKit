//
//  ZStoreRootManager.m
//  ZStoreTest
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZStoreRootManager.h"
@import ZNoti;
@import ZSign;
@import ZNavi;
@import ZHud;
@import ZWelcome;
//@import ZWechat;
@import ZPravicy;
@import ZPassword;
@import ZReg;
@import ZCache;

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
        
        [ZConfigure initWithAppKey:@"" domain:@"https://zhih.ecsoi.com/" pType:ZConfigureTypeCircle];
        //
        [ZNavigationController initWithConfig:nil];
        
        appdelegate.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstLogin"]) {
            
            appdelegate.window.rootViewController = [ZWelcomeViewController createWelcomeWithConfig:nil];
            
        } else {
            
            [[ZAccountCache shared] wl_queryAccount];
            
            //            appdelegate.window.rootViewController = [WLMainViewController createCircleTab];
            
        }
        
        [appdelegate.window makeKeyAndVisible];
        
        //        [WXApi registerApp:@SWXKey];
        //
        [ZHudUtil configHud];
    }
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoMyCircleTap:) name:ZNotiMyCircle object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoMyOrderTap:) name:ZNotiMyOrder object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoMyAddressTap:) name:ZNotiMyAddress object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoAboutTap:) name:ZNotiAboutUs object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoProtocolTap:) name:ZNotiPrivacy object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCircleClickTap:) name:ZNotiCircleClick object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCircleReportTap:) name:ZNotiCircleGotoReport object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCircleShareTap:) name:ZNotiCircleShare object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCirclePublishSuccTap:) name:ZNotiCirclePublishSucc object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onStoreBannerTap:) name:ZNotiBannerClick object:nil ];
}

#pragma mark -- WelcomeSkip
- (void)onskipTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        //        WLMainViewController *main = [WLMainViewController createCircleTab];
        //
        //        main.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        //
        //        [from presentViewController:main animated:true completion:nil];
        
    }
}
#pragma mark -- ZNotiGotoReg

- (void)onLoginSuccTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        //        [from dismissViewControllerAnimated:true completion:nil];
        
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

@end
