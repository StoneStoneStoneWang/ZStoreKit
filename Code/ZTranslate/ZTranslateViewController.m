//
//  ZTranslateViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2020/3/16.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import "ZTranslateViewController.h"
@import ZBombBridge;
@import SToolsKit;
@import Masonry;



@interface ZTranslateViewController ()

@property (nonatomic ,strong) ZTranslateBridge *bridge;

@property (nonatomic ,strong) UITextView *from;

@property (nonatomic ,strong) UITextView *to;

@property (nonatomic ,strong) UIButton *translateItem;

@property (nonatomic ,strong) UILabel *placeholder;

@property (nonatomic ,strong) UIButton *speaker;

@end
@implementation ZTranslateViewController

- (UITextView *)from {
    
    if (!_from) {
        
        _from = [[UITextView alloc] initWithFrame:CGRectZero];
        
        _from.font = [UIFont systemFontOfSize:13];
        
        _from.tag = 401;
        
        _from.textAlignment = NSTextAlignmentLeft;
        
        _from.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
        
        _from.layer.cornerRadius = 1;
        
        _from.layer.masksToBounds = true;
        
        _from.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@"#333333"].CGColor;
        
        _from.layer.borderWidth = 1;
    }
    return _from;
}
- (UITextView *)to {
    
    if (!_to) {
        
        _to = [[UITextView alloc] initWithFrame:CGRectZero];
        
        _to.font = [UIFont systemFontOfSize:13];
        
        _to.tag = 402;
        
        _to.layer.cornerRadius = 1;
        
        _to.layer.masksToBounds = true;
        
        _to.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@"#333333"].CGColor;
        
        _to.layer.borderWidth = 1;
        
        _to.editable = false;
        
        _to.text = @"번역 내용을 입력하십시오";
    }
    return _to;
}

- (UIButton *)translateItem {
    
    if (!_translateItem) {
        
        _translateItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_translateItem setTitle:@"翻译" forState:UIControlStateNormal];
        
        [_translateItem setTitle:@"翻译" forState:UIControlStateHighlighted];
        
        [_translateItem setTitle:@"翻译" forState:UIControlStateSelected];
        
        _translateItem.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [_translateItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
        
        [_translateItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff60"] forState:UIControlStateHighlighted];
        
        [_translateItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff80"] forState:UIControlStateDisabled];
        
        [_translateItem setBackgroundImage:[UIImage s_transformFromColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor]] forState:(UIControlState)UIControlStateNormal];
        
        [_translateItem setBackgroundImage:[UIImage s_transformFromColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@80",@ZFragmentColor]]] forState:(UIControlState)UIControlStateHighlighted];
        
        [_translateItem setBackgroundImage:[UIImage s_transformFromColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@80",@ZFragmentColor]]] forState:(UIControlState)UIControlStateNormal];
        
        _translateItem.tag = 403;
        
        _translateItem.layer.cornerRadius = 24;
        
        _translateItem.layer.masksToBounds = true;
    }
    return _translateItem;
}

- (UIButton *)speaker {
    
    if (!_speaker) {
        
        _speaker = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_speaker setImage:[UIImage imageNamed:@"speaker"] forState:UIControlStateNormal];
        
        [_speaker setImage:[UIImage imageNamed:@"speaker"] forState:UIControlStateHighlighted];
        
        [_speaker sizeToFit];
        
        _speaker.tag = 404;
    }
    return _speaker;
}

- (UILabel *)placeholder {
    
    if (!_placeholder) {
        
        _placeholder = [UILabel new];
        
        _placeholder.tag = 405;
        
        _placeholder.font = [UIFont systemFontOfSize:13];
        
        _placeholder.textAlignment = NSTextAlignmentLeft;
        
        _placeholder.text = @"请输入需要翻译内容";
    }
    return _placeholder;
}
- (void)addOwnSubViews {
    
    [self.view addSubview:self.from];
    
    [self.view addSubview:self.to];
    
    [self.view addSubview:self.translateItem];
    
    [self.view addSubview:self.placeholder];
    
    [self.view addSubview:self.speaker];
}
- (void)configOwnSubViews {
    
    [self.from mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(1);
        
        make.top.mas_equalTo(KTOPLAYOUTGUARD);
        
        make.width.mas_equalTo(KSSCREEN_WIDTH / 2);
        
        make.height.mas_equalTo(KSSCREEN_WIDTH  * 3 / 4 );
    }];
    
    [self.to mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-1);
        
        make.top.mas_equalTo(KTOPLAYOUTGUARD);
        
        make.width.mas_equalTo(KSSCREEN_WIDTH / 2);
        
        make.height.mas_equalTo(KSSCREEN_WIDTH  * 3 / 4 );
    }];
    
    [self.translateItem mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(0);
        
        make.top.mas_equalTo(self.from.mas_bottom).offset(20);
        
        make.width.mas_equalTo(KSSCREEN_WIDTH / 2);
        
        make.height.mas_equalTo(48);
    }];
    
    [self.placeholder mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.from.mas_left).offset(2);
        
        make.top.mas_equalTo(self.from.mas_top).offset(10);
    }];
    
    [self.speaker mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.translateItem.mas_right);
        
        make.right.mas_equalTo(0);
        
        make.centerY.mas_equalTo(self.translateItem.mas_centerY);
    }];
}

- (void)configViewModel {
    
    self.bridge = [ZTranslateBridge new];
    
    [self.bridge createTranslate:self];
    
    [self.bridge changeLanguage:@"ko-KR"];
}
- (void)configNaviItem {
    
    self.title = @"中文->韩语";
}

@end
