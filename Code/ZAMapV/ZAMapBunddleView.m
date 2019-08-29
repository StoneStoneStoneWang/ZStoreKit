//
//  ZAMapBunddleView.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZAMapBunddleView.h"
#import "ZFragmentConfig.h"
@import SToolsKit;
@import Masonry;

@interface ZAMapBunddleView ()

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *label;

@property (nonatomic ,strong) UIView *whiteView;

@end

@implementation ZAMapBunddleView

- (UIView *)whiteView {
    
    if (!_whiteView) {
        
        _whiteView = [[UIView alloc] init];
        
        _whiteView.backgroundColor = [UIColor whiteColor];
        
        _whiteView.layer.cornerRadius = 2;
        
        _whiteView.layer.masksToBounds = true;
        
        _whiteView.layer.borderWidth = 1;
        
        _whiteView.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@"#e1e1e1"].CGColor;
    }
    return _whiteView;
}

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@ZNabla]];
        
    }
    return _iconImageView;
}
- (UILabel *)label {
    
    if (!_label) {
        
        _label = [UILabel new];
        
        _label.backgroundColor = [UIColor whiteColor];
        
        _label.numberOfLines = 3;
        
        _label.font = [UIFont systemFontOfSize:12];
    }
    return _label;
}
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self commitInit];
    }
    return self;
}
- (void)commitInit {
    
    [self addSubview:self.whiteView];
    
    [self addSubview:self.iconImageView];
    
    [self addSubview:self.label];
    
}
- (void)updateLocationText:(NSString *)text {
    
    self.label.text = text;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.equalTo(self);
        
        make.bottom.mas_equalTo(-12);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(12);
        
        make.right.mas_equalTo(-12);
        
        make.top.mas_equalTo(5);
        
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.whiteView.mas_bottom).offset(-1);
        
        make.centerX.equalTo(self);
        
        make.width.mas_equalTo(22);
        
        make.height.mas_equalTo(12);
    }];
    
}
@end
