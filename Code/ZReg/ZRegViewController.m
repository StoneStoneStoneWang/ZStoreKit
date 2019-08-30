//
//  ZRegViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZRegViewController.h"
@import Masonry;
@import ZTextField;
@import SToolsKit;
@import ZBridge;

@interface ZRegViewController ()

@property (nonatomic ,strong) ZRegBridge *bridge;

@property (nonatomic ,strong) WLLeftImageTextField *phone;

@property (nonatomic ,strong) WLVCodeImageTextField *vcode;

@property (nonatomic ,strong) UIButton *loginItem;

@property (nonatomic ,strong) UIButton *proItem;

@property (nonatomic ,strong) UIButton *backLoginItem;

#if ZLoginFormOne

@property (nonatomic ,strong) UIView *topView;

@property (nonatomic ,strong) UIImageView *logoImgView;

#elif ZLoginFormTwo

#else

#endif
@end
@implementation ZRegViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
#if ZLoginFormOne
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor] ];
#elif ZLoginFormTwo
    
#else
    
#endif
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

- (WLVCodeImageTextField *)vcode {
    
    if (!_vcode) {
        
        _vcode = [[WLVCodeImageTextField alloc] initWithFrame:CGRectZero];
        
        _vcode.tag = 202;
        
        _vcode.leftImageName = @ZVCodeIcon;
        
        _vcode.placeholder = @"请输入6位验证码";
        
        [_vcode set_editType:WLTextFiledEditTypeVcode_length6];
        
        [_vcode set_maxLength:6];
        
        [_vcode set_bottomLineColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor]];
    }
    return _vcode;
}

- (UIButton *)loginItem {
    
    if (!_loginItem) {
        
        _loginItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _loginItem.tag = 203;
        
        [_loginItem setBackgroundImage:[UIImage s_transformFromHexColor:@ZFragmentColor] forState:UIControlStateNormal];
        
        [_loginItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@ZFragmentColor]] forState:UIControlStateHighlighted];
        
        [_loginItem setTitle:@"注册/登陆" forState: UIControlStateNormal];
        
        [_loginItem setTitle:@"注册/登陆" forState: UIControlStateHighlighted];
        
        [_loginItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_loginItem setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        _loginItem.layer.cornerRadius = 24;
        
        _loginItem.layer.masksToBounds = true;
        
        _loginItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _loginItem;
}

- (UIButton *)backLoginItem {
    
    if (!_backLoginItem) {
        
        _backLoginItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _backLoginItem.tag = 204;
        
        [_backLoginItem setTitle:@"已有账号,返回登陆" forState: UIControlStateNormal];
        
        [_backLoginItem setTitle:@"已有账号,返回登陆" forState: UIControlStateHighlighted];
        
        [_backLoginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor] forState:UIControlStateNormal];
        
        [_backLoginItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@ZFragmentColor]] forState:UIControlStateHighlighted];
        
        _backLoginItem.layer.cornerRadius = 24;
        
        _backLoginItem.layer.masksToBounds = true;
        
        _backLoginItem.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@ZFragmentColor].CGColor;
        
        _backLoginItem.layer.borderWidth = 1;
        
        _backLoginItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _backLoginItem;
}
- (UIButton *)proItem {
    
    if (!_proItem) {
        
        _proItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _proItem.tag = 205;
        
        NSMutableAttributedString *mutable = [NSMutableAttributedString new];
        
        NSString *displayname = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
        
        [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                      attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12] ,
                                                                                   NSForegroundColorAttributeName: [UIColor s_transformToColorByHexColorStr:@ZFragmentColor]}]];
        [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12] ,
                                                                                                         NSForegroundColorAttributeName: [UIColor s_transformToColorByHexColorStr:@"#333333"]}] ];
        [_proItem setAttributedTitle:mutable forState:UIControlStateNormal];
        
        [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                      attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12] ,
                                                                                   NSForegroundColorAttributeName: [UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@ZFragmentColor]] }]];
        [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12] ,
                                                                                                         NSForegroundColorAttributeName: [UIColor s_transformToColorByHexColorStr:@"#333333"]}] ];
        
        _proItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _proItem;
}

- (void)addOwnSubViews {
    
    [self.view addSubview:self.phone];
    
    [self.view addSubview:self.vcode];
    
    [self.view addSubview:self.loginItem];
    
    [self.view addSubview:self.backLoginItem];
    
    [self.view addSubview:self.proItem];
    
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
    
#if ZLoginFormOne
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
    self.title = @"注册/登陆";
    
#elif ZLoginFormTwo
    
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
    
    [self.vcode mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    [self.vcode set_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    UIButton *vcodeItem = (UIButton *)self.vcode.rightView;
    
    [vcodeItem setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [vcodeItem sizeToFit];
    
    [vcodeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor] forState:UIControlStateNormal];
    
    [vcodeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@80",@ZFragmentColor]] forState:UIControlStateHighlighted];
    
    [vcodeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#999999"] forState:UIControlStateSelected];
    
    [self.vcode setRightView:vcodeItem];
    
    [self.proItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    
    
    [self.loginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.proItem.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    [self.backLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
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
    
    self.bridge = [ZRegBridge new];
    
    [self.bridge configViewModel:self];
}

- (BOOL)canPanResponse {
    
    return true ;
}

@end
