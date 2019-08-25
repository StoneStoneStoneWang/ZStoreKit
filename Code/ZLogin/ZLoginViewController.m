//
//  ZLoginViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZLoginViewController.h"
@import Masonry;
@import WLComponentView;
@interface ZLoginViewController ()

@property (nonatomic ,strong) WLLeftImageTextField *phone;

@property (nonatomic ,strong) WLPasswordImageTextFiled *password;

@property (nonatomic ,strong) UIButton *loginItem;

@property (nonatomic ,strong) UIButton *backItem;

@property (nonatomic ,strong) UIButton *forgetItem;

@property (nonatomic ,strong) UIButton *swiftLoginItem;

#if ZLoginFormOne

@property (nonatomic ,strong) UIView *topView;

@property (nonatomic ,strong) UIImageView *logoImgView;
#elif ZLoginFormTwo

#else

#endif
@end
@implementation ZLoginViewController

- (WLLeftImageTextField *)phone {
    
    if (!_phone) {
        
        _phone = [[WLLeftImageTextField alloc] initWithFrame:CGRectZero];
        
        _phone.tag = 201;
        
    }
    return _phone;
}

- (WLPasswordImageTextFiled *)password {
    
    if (!_password) {
        
        _password = [[WLPasswordImageTextFiled alloc] initWithFrame:CGRectZero];
        
        _password.tag = 202;
        
        _password.normalIcon = @"";
        
        _password.selectedIcon = @"";
    }
    return _password;
}

- (UIButton *)loginItem {
    
    if (!_loginItem) {
        
        _loginItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _loginItem.tag = 203;
    }
    return _loginItem;
}

- (UIButton *)swiftLoginItem {
    
    if (!_swiftLoginItem) {
        
        _swiftLoginItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _swiftLoginItem.tag = 204;
    }
    return _swiftLoginItem;
}
- (UIButton *)forgetItem {
    
    if (!_forgetItem) {
        
        _forgetItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _forgetItem.tag = 204;
    }
    return _forgetItem;
}
- (UIButton *)backItem {
    
    if (!_backItem) {
        
        _backItem = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _backItem;
}
- (void)addOwnSubViews {
    
    [self.view addSubview:self.phone];
    
    [self.view addSubview:self.password];
    
    [self.view addSubview:self.loginItem];
    
    [self.view addSubview:self.swiftLoginItem];
    
    [self.view addSubview:self.forgetItem];
    
#if ZLoginFormOne
    
    [self.view addSubview:self.topView];
    
    [self.view addSubview:self.logoImgView];
#elif ZLoginFormTwo
    
#else
    
#endif
}

#if ZLoginFormOne

- (UIView *)topView {
    
    if (!_topView) {
        
        _topView = [UIView new];
    }
    return _topView;
}

- (UIImageView *)logoImgView {
    
    if (!_logoImgView) {
        
        _logoImgView = [UIImageView new];
    }
    return _logoImgView;
}

#elif ZLoginFormTwo

#else

#endif
- (void)configNaviItem {
    
    [self.backItem setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backItem];
    
#if ZLoginFormOne
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
#elif ZLoginFormTwo
    
#else
    
#endif
}
- (void)configOwnSubViews {
    
    
}
- (void)configViewModel {
    
    
}
@end
