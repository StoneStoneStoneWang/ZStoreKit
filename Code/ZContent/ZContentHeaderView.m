//
//  ZContentHeaderView.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/20.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZContentHeaderView.h"
@import SToolsKit;
@import Masonry;
@import SDWebImage;

@interface ZContentHeaderView ()

@property (nonatomic ,strong )UIImageView *iconImageView;

@property (nonatomic ,strong )UILabel *titleLabel;

@property (nonatomic ,strong) UILabel *timeLabel;

@property (nonatomic ,strong ,readwrite) UIButton *focusItem;

@end

@implementation ZContentHeaderView

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
        
        _iconImageView.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@"#e1e1e1"].CGColor;
        
        _iconImageView.layer.borderWidth = 0.5;
        
        _iconImageView.layer.masksToBounds = true;
        
        _iconImageView.contentMode = UIViewContentModeCenter;
        
        _iconImageView.layer.cornerRadius = 20;
    }
    return _iconImageView;
}
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        
        _titleLabel.font = [UIFont systemFontOfSize:17];
        
        _titleLabel.numberOfLines = 3;
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#333333"];
    }
    return _titleLabel;
}
- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] init];
        
        _timeLabel.font = [UIFont systemFontOfSize:12];
        
        _timeLabel.numberOfLines = 1;
        
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        
        _timeLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#999999"];
    }
    return _timeLabel;
}

- (UIButton *)focusItem {
    
    if (!_focusItem) {
        
        _focusItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_focusItem setTitle:@"关注" forState:UIControlStateNormal];
        
        [_focusItem setTitle:@"已关注" forState:UIControlStateSelected];
        
        _focusItem.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [_focusItem setBackgroundImage:[UIImage s_transformFromColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor]] forState:UIControlStateNormal];
        
        [_focusItem setBackgroundImage:[UIImage s_transformFromColor:[UIColor s_transformToColorByHexColorStr:@"#999999"]] forState:UIControlStateSelected];
        
        _focusItem.layer.cornerRadius = 5;
        
        _focusItem.layer.masksToBounds = true;
    }
    return _focusItem;
}
- (void)setCircleBean:(ZCircleBean *)circleBean {
    
    self.titleLabel.text = circleBean.users.nickname;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_400,h_300",circleBean.users.headImg]] placeholderImage:[UIImage imageNamed:@ZLogoIcon] options:SDWebImageRefreshCached];
    
    self.timeLabel.text = [[NSString stringWithFormat:@"%ld",circleBean.intime / 1000] s_convertToDate:SDateTypeDateStyle];
    
    self.focusItem.selected = circleBean.isattention;
}

- (void)commitInit {
    [super commitInit];
    
    [self addSubview:self.iconImageView];
    
    [self addSubview:self.titleLabel];
    
    [self addSubview:self.timeLabel];
    
    [self addSubview:self.focusItem];
    
    self.backgroundColor = [UIColor whiteColor];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(15);
        
        make.height.width.mas_equalTo(40);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        
        make.bottom.equalTo(self.iconImageView.mas_centerY).offset(-1);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        
        make.top.equalTo(self.iconImageView.mas_centerY).offset(1);
        
    }];
    
    [self.focusItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self.iconImageView.mas_centerY);
        
        make.width.mas_equalTo(@60);
        
        make.height.mas_equalTo(@25);
    }];
    
}

@end
