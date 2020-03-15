//
//  ZLoginViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZLoginViewController.h"
@import Masonry;
@import ZTField;
@import SToolsKit;
@import ZBridge;

@interface ZLoginViewController ()

@property (nonatomic ,strong) ZLoginBridge *bridge;

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

@property (nonatomic ,copy) ZLoginBlock block;
@end
@implementation ZLoginViewController

+ (instancetype)createLoginWithBlock:(ZLoginBlock)block {
    
    return [[self alloc] initWithBlock:block];
}
- (instancetype)initWithBlock:(ZLoginBlock)block  {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (WLLeftImageTextField *)phone {
    
    if (!_phone) {
        
        _phone = [[WLLeftImageTextField alloc] initWithFrame:CGRectZero];
        
        _phone.tag = 201;
        
        _phone.leftImageName = @ZPhoneIcon;
        
        _phone.placeholder = @"请输入11位手机号";
        
        [_phone set_editType:WLTextFiledEditTypePhone];
        
        [_phone set_maxLength:11];
        
        [_phone set_bottomLineColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor]];
    }
    return _phone;
}

- (WLPasswordImageTextFiled *)password {
    
    if (!_password) {
        
        _password = [[WLPasswordImageTextFiled alloc] initWithFrame:CGRectZero];
        
        _password.tag = 202;
        
        _password.normalIcon = @ZPasswordNormalIcon;
        
        _password.selectedIcon = @ZPasswordSelectIcon;
        
        _password.leftImageName = @ZPasswordIcon;
        
        _password.placeholder = @"请输入6-18位密码";
        
        [_password set_editType:WLTextFiledEditTypeSecret];
        
        [_password set_maxLength:18];
        
        [_password set_bottomLineColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor]];
    }
    return _password;
}

- (UIButton *)loginItem {
    
    if (!_loginItem) {
        
        _loginItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _loginItem.tag = 203;
        
        [_loginItem setBackgroundImage:[UIImage s_transformFromHexColor:@ZFragmentColor] forState:UIControlStateNormal];
        
        [_loginItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@ZFragmentColor]] forState:UIControlStateHighlighted];
        
        [_loginItem setTitle:@"登陆" forState: UIControlStateNormal];
        
        [_loginItem setTitle:@"登陆" forState: UIControlStateHighlighted];
        
        [_loginItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_loginItem setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        _loginItem.layer.cornerRadius = 24;
        
        _loginItem.layer.masksToBounds = true;
        
        _loginItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _loginItem;
}

- (UIButton *)swiftLoginItem {
    
    if (!_swiftLoginItem) {
        
        _swiftLoginItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _swiftLoginItem.tag = 204;
        
        [_swiftLoginItem setTitle:@"没有账号?前往注册" forState: UIControlStateNormal];
        
        [_swiftLoginItem setTitle:@"没有账号?前往注册" forState: UIControlStateHighlighted];
        
        [_swiftLoginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor] forState:UIControlStateNormal];
        
        [_swiftLoginItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@ZFragmentColor]] forState:UIControlStateHighlighted];
        
        _swiftLoginItem.layer.cornerRadius = 24;
        
        _swiftLoginItem.layer.masksToBounds = true;
        
        _swiftLoginItem.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@ZFragmentColor].CGColor;
        
        _swiftLoginItem.layer.borderWidth = 1;
        
        _swiftLoginItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _swiftLoginItem;
}
- (UIButton *)forgetItem {
    
    if (!_forgetItem) {
        
        _forgetItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _forgetItem.tag = 205;
        
        [_forgetItem setTitle:@"忘记密码?" forState: UIControlStateNormal];
        
        [_forgetItem setTitle:@"忘记密码?" forState: UIControlStateHighlighted];
        
        [_forgetItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor] forState:UIControlStateNormal];
        
        [_forgetItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@ZFragmentColor]] forState:UIControlStateHighlighted];
        
        _forgetItem.titleLabel.font = [UIFont systemFontOfSize:15];
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
        
        _topView.backgroundColor = [UIColor s_transformToColorByHexColorStr:@ZFragmentColor];
    }
    return _topView;
}

- (UIImageView *)logoImgView {
    
    if (!_logoImgView) {
        
        _logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@ZLogoIcon]];
        
        _logoImgView.layer.cornerRadius = 40;
        
        _logoImgView.layer.masksToBounds = true;
        
        _logoImgView.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@ZFragmentColor].CGColor;
        
        _logoImgView.layer.borderWidth = 1;
    }
    return _logoImgView;
}

#elif ZLoginFormTwo

#else

#endif
- (void)configNaviItem {
    
    [self.backItem setImage:[UIImage imageNamed:@ZBackIcon] forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backItem];
    
#if ZLoginFormOne
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
    self.title = @"登陆";
    
#elif ZLoginFormTwo
    
#else
    
#endif
    
#if ZForceLogin
    
    self.backItem.hidden = true;
#else
    
#endif
}
- (void)configOwnSubViews {
    
#if ZLoginFormOne
    
    CGFloat w = CGRectGetWidth(self.view.bounds);
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.mas_equalTo(@0);
        
        make.height.mas_equalTo(@(w / 2));
    }];
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.topView.mas_centerX);
        
        make.centerY.mas_equalTo(self.topView.mas_centerY);
        
        make.width.height.mas_equalTo(@80);
    }];
    
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.topView.mas_bottom).offset(10);
        
        make.left.mas_equalTo(@15);
        
        make.right.mas_equalTo(@-15);
        
        make.height.mas_equalTo(@48);
    }];
    [self.phone set_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    [self.password set_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.forgetItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    [self.loginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.forgetItem.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    [self.swiftLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.loginItem.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
#elif ZLoginFormTwo
    
#else
    
    
#endif
    
    
    
}
- (void)configOwnProperties {
    [super configOwnProperties];
    
#if ZLoginFormOne
    
    self.view.backgroundColor = [UIColor whiteColor];
    
#elif ZLoginFormTwo
    
#else
    
#endif
}
- (void)configViewModel {
    
    self.bridge = [ZLoginBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge configViewModel:self loginAction:^(enum ZLoginActionType type, ZBaseViewController * _Nonnull vc) {
        
        weakSelf.block(type, vc);
    }];
}

@end
