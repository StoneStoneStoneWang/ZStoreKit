//
//  ZTextEditViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZTextEditViewController.h"

#import "ZFragmentConfig.h"
@import ZBridge;
@import Masonry;
@import SToolsKit;

@interface ZTextEditViewController ()

@property (nonatomic ,strong) UITextView *textEdittv;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,strong) ZSignatureBridge *bridge;

@property (nonatomic ,strong) UIButton *backItem;

@property (nonatomic ,strong) ZTextEditSucc succ;

@end

@implementation ZTextEditViewController

+ (instancetype)createTextEdit:(ZTextEditSucc)succ; {
    
    return [[self alloc] initWithSucc:succ];
    
}
- (instancetype)initWithSucc:(ZTextEditSucc)succ {
    
    if (self = [super init]) {
        
        self.succ = succ;
    }
    return self;
}
- (UITextView *)textEdittv {
    
    if (!_textEdittv) {
        
        _textEdittv = [[UITextView alloc] initWithFrame:CGRectZero];
        
        _textEdittv.font = [UIFont systemFontOfSize:15];
        
        _textEdittv.textContainerInset = UIEdgeInsetsMake(15, 15, 15, 15);
        
        _textEdittv.tag = 201;
        
    }
    return _textEdittv;
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
    
    [self.view addSubview:self.textEdittv];
}
- (void)configOwnSubViews {
    
    [self.textEdittv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(KTOPLAYOUTGUARD);
        
        make.height.mas_equalTo(200);
    }];
    
}

- (void)configNaviItem {
    
    self.title = @"修改个性签名";
    
    [self.completeItem sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.completeItem];
    
    [self.backItem setImage:[UIImage imageNamed:@ZBackIcon] forState:UIControlStateNormal];
    
    [self.backItem sizeToFit];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backItem];
}

- (void)configViewModel {
    
    self.bridge = [ZSignatureBridge new];
    
    [self.bridge createSignature:self succ:self.succ];
}

@end
