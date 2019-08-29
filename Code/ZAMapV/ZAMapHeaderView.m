//
//  ZAMapHeaderView.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZAMapHeaderView.h"
#import "ZFragmentConfig.h"
@import Masonry;
@import SToolsKit;

@interface ZAMapHeaderView()

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *label;

@property (nonatomic ,strong) UIView *aView;
@end

@implementation ZAMapHeaderView

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@ZLocationIcon]];
        
        _iconImageView.contentMode = UIViewContentModeCenter;
    }
    return _iconImageView;
}
- (UILabel *)label {
    
    if (!_label) {
        
        _label = [UILabel new];
        
        _label.backgroundColor = [UIColor whiteColor];
        
        _label.numberOfLines = 3;
        
        _label.font = [UIFont systemFontOfSize:12];
        
        _label.textAlignment = NSTextAlignmentLeft;
        
    }
    return _label;
}
- (UIView *)aView {
    
    if (!_aView) {
        
        _aView = [UIView new];
        
        _aView.backgroundColor = [UIColor s_transformToColorByHexColorStr:@"#e1e1e1"];
    }
    return _aView;
}
- (void)commitInit {
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.iconImageView];
    
    [self addSubview:self.label];
    
    [self addSubview:self.aView];
}

- (void)updateLocationText:(NSString *)text {
    
    self.label.text = text;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.centerY.equalTo(self);
        
        make.width.mas_equalTo(30);
        
        make.height.mas_equalTo(15);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(5);
        
        make.centerY.equalTo(self);
        
        make.right.mas_equalTo(-15);
    }];
    [self.aView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        
        make.height.mas_equalTo(1);
    }];
    
}

@end
