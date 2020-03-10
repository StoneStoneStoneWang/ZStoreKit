//
//  ZCharacterNameViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2020/3/10.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import "ZCharacterNameViewController.h"
@import ZBridge;
@import ZTField;
@import SToolsKit;
@import Masonry;

@interface ZCharacterNameViewController ()

@property (nonatomic ,copy) NSString *name;

@property (nonatomic ,copy) ZCharacterNameSucc block;

@property (nonatomic ,strong) WLNickNameTextField *textField;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,strong) ZCharactersNameBridge *bridge;

@property (nonatomic ,strong) UIButton *backItem;
@end

@implementation ZCharacterNameViewController

+ (instancetype)createCharacterName:(NSString *)name andBlock:(ZCharacterNameSucc)succ {
    
    return [[self alloc] initWithCharacterName:name andBlock:succ];
}
- (instancetype)initWithCharacterName:(NSString *)name andBlock:(ZCharacterNameSucc)succ {
    
    if (self = [super init]) {
        
        self.name = name;
        
        self.block = succ;
        
    }
    return self;
}
- (WLNickNameTextField *)textField {
    
    if (!_textField) {
        
        _textField = [[WLNickNameTextField alloc] initWithFrame:CGRectZero];
        
        [_textField set_clearButtonMode:UITextFieldViewModeWhileEditing];
        
        [_textField set_returnKeyType:UIReturnKeyDone];
        
        _textField.tag = 201;
        
        _textField.placeholder = @"请速入角色昵称";
    
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
    
    self.title = @"修改角色昵称";
    
    [self.completeItem sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.completeItem];
    
    [self.backItem setImage:[UIImage imageNamed:@ZBackIcon] forState:UIControlStateNormal];
    
    [self.backItem sizeToFit];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backItem];
    
}
- (void)configViewModel {
    
    self.bridge = [ZCharactersNameBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createCharactersName:self nameValue:self.name succ:^(NSString * _Nonnull newValue) {
     
        weakSelf.block(newValue);
    }];
}

@end
