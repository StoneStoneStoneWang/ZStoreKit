//
//  ZModifyViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZModifyViewController.h"
@import Masonry;
@import ZTField;
@import SToolsKit;
@import ZBridge;

@interface ZModifyViewController ()

@property (nonatomic ,strong) ZModifyPwdBridge *bridge;

@property (nonatomic ,strong) WLPasswordImageTextFiled *oldpassword;

@property (nonatomic ,strong) WLPasswordImageTextFiled *password;

@property (nonatomic ,strong) WLPasswordImageTextFiled *againpassword;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,copy) ZModifyPwdBlock block;
#if ZLoginFormOne

@property (nonatomic ,strong) UIView *topView;

@property (nonatomic ,strong) UIImageView *logoImgView;

#elif ZLoginFormTwo

#else

#endif
@end

@implementation ZModifyViewController

+ (instancetype)createPwdWithBlock:(ZModifyPwdBlock)block {
    
    return [[self alloc] initWithBlock:block];
}
- (instancetype)initWithBlock:(ZModifyPwdBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (WLPasswordImageTextFiled *)oldpassword {
    
    if (!_oldpassword) {
        
        _oldpassword = [[WLPasswordImageTextFiled alloc] initWithFrame:CGRectZero];
        
        _oldpassword.tag = 201;
        
        _oldpassword.leftImageName = @ZPasswordIcon;
        
        _oldpassword.placeholder = @"请输入6-18位旧密码";
        
        [_oldpassword set_editType:WLTextFiledEditTypeSecret];
        
        [_oldpassword set_maxLength:18];
        
        [_oldpassword set_bottomLineColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor]];
    }
    return _oldpassword;
}
- (WLPasswordImageTextFiled *)password {
    
    if (!_password) {
        
        _password = [[WLPasswordImageTextFiled alloc] initWithFrame:CGRectZero];
        
        _password.tag = 202;
        
        _password.leftImageName = @ZPasswordIcon;
        
        _password.placeholder = @"请输入6-18位新密码";
        
        [_password set_editType:WLTextFiledEditTypeSecret];
        
        [_password set_maxLength:18];
        
        [_password set_bottomLineColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor]];
    }
    return _password;
}

- (WLPasswordImageTextFiled *)againpassword {
    
    if (!_againpassword) {
        
        _againpassword = [[WLPasswordImageTextFiled alloc] initWithFrame:CGRectZero];
        
        _againpassword.tag = 203;
        
        _againpassword.leftImageName = @ZPasswordIcon;
        
        _againpassword.placeholder = @"请输入6-18位确认密码";
        
        [_againpassword set_editType:WLTextFiledEditTypeSecret];
        
        [_againpassword set_maxLength:18];
        
        [_againpassword set_bottomLineColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor]];
    }
    return _againpassword;
}


- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _completeItem.tag = 204;
        
        [_completeItem setBackgroundImage:[UIImage s_transformFromHexColor:@ZFragmentColor] forState:UIControlStateNormal];
        
        [_completeItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@ZFragmentColor]] forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@"修改密码" forState: UIControlStateNormal];
        
        [_completeItem setTitle:@"修改密码" forState: UIControlStateHighlighted];
        
        [_completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        _completeItem.layer.cornerRadius = 24;
        
        _completeItem.layer.masksToBounds = true;
        
        _completeItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _completeItem;
}

- (void)addOwnSubViews {
    
    [self.view addSubview:self.oldpassword];
    
    [self.view addSubview:self.password];
    
    [self.view addSubview:self.againpassword];
    
    [self.view addSubview:self.completeItem];
    
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
    
    self.title = @"忘记密码";
    
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
    
    [self.oldpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.topView.mas_bottom).offset(10);
        
        make.left.mas_equalTo(@15);
        
        make.right.mas_equalTo(@-15);
        
        make.height.mas_equalTo(@48);
    }];
    
    [self.oldpassword set_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.oldpassword.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
    }];
    
    [self.password set_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.againpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
    }];
    
    [self.againpassword set_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.againpassword.mas_bottom).offset(30);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
        
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
    
    self.bridge = [ZModifyPwdBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge configViewModel:self pwdAction:^(ZBaseViewController * _Nonnull vc) {
        
        weakSelf.block(vc);
    }];
}

- (BOOL)canPanResponse {
    
    return true ;
}

@end
