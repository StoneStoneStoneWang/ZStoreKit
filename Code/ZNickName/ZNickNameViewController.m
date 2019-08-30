//
//  ZNickNameViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/28.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZNickNameViewController.h"
#import "ZFragmentConfig.h"
@import ZTextField;
@import ZBridge;
@import Masonry;
@import SToolsKit;

@interface ZNickNameViewController ()

@property (nonatomic ,strong) WLNickNameTextField *textField;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,strong) ZNickNameBridge *bridge;

@property (nonatomic ,strong) UIButton *backItem;

@property (nonatomic ,strong) ZNickNameSucc succ;

@end

@implementation ZNickNameViewController

+ (instancetype)createSignature:(ZNickNameSucc)succ {
    
    return [[self alloc] initWithSucc:succ];
    
}
- (instancetype)initWithSucc:(ZNickNameSucc)succ {
    
    if (self = [super init]) {
        
        self.succ = succ;
    }
    return self;
}

- (WLNickNameTextField *)textField {
    
    if (!_textField) {
        
        _textField = [[WLNickNameTextField alloc] initWithFrame:CGRectZero];
        
        [_textField set_clearButtonMode:UITextFieldViewModeWhileEditing];
        
        [_textField set_returnKeyType:UIReturnKeyDone];
        
        _textField.tag = 201;
        
        _textField.backgroundColor = [UIColor whiteColor];
    }
    return _textField;
}

- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateNormal];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateSelected];
        
        _completeItem.titleLabel.font = [UIFont systemFontOfSize:15];
        
        if ([@ZFragmentColor isEqualToString:@"#ffffff"]) {
            
            [_completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#666666"] forState:UIControlStateNormal];
            
            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#66666680"] forState:UIControlStateHighlighted];
            
            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#66666650"] forState:UIControlStateDisabled];
            
        } else {
            
            [_completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
            
            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff80"] forState:UIControlStateHighlighted];
            
            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff50"] forState:UIControlStateDisabled];
        }
    }
    return _completeItem;
}
- (UIButton *)backItem {
    
    if (!_backItem) {
        
        _backItem = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _backItem;
}
- (void)addOwnSubViews {
    
    [self.view addSubview:self.textField];
    
}
- (void)configOwnSubViews {
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(KTOPLAYOUTGUARD);
        
        make.height.mas_equalTo(48);
    }];
}

- (void)configNaviItem {
    
    self.title = @"修改昵称";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.completeItem];
    
    [self.backItem setImage:[UIImage imageNamed:@ZBackIcon] forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backItem];
    
}
- (void)configViewModel {
    
    self.bridge = [ZNickNameBridge new];
    
    [self.bridge createNickName:self succ:self.succ];
}

@end
