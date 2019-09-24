//
//  ZCircleTableViewCell.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/17.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZCircleTableViewCell.h"

@import Masonry;
@import SToolsKit;
@import SDWebImage;
@import AVFoundation;

@implementation ZCircleTableViewCell


@end

#if ZCircleFormOne

@interface ZCircleImageTableViewCell () <ZFuncItemViewDelegate>

@property (nonatomic ,strong )ZFuncItemView *funcView;

@property (nonatomic ,strong )UIImageView *iconImageView;

@property (nonatomic ,strong )UILabel *titleLabel;

@property (nonatomic ,strong) UILabel *timeLabel;

@property (nonatomic ,strong) UILabel *subTitleLabel;

@property (nonatomic ,strong) UIImageView *avatarImageView;

@property (nonatomic ,strong) UIImageView *cover;

@property (nonatomic ,strong) ZCircleBean *someCircle;
@end

@implementation ZCircleImageTableViewCell

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
        
        _iconImageView.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@"#e1e1e1"].CGColor;
        
        _iconImageView.layer.borderWidth = 0.5;
        
        _iconImageView.layer.masksToBounds = true;
        
        _iconImageView.contentMode = UIViewContentModeCenter;
    }
    return _iconImageView;
}
- (ZFuncItemView *)funcView {
    
    if (!_funcView) {
        
        _funcView = [[ZFuncItemView alloc] initWithFrame:CGRectZero];
        
        _funcView.mDelegate = self;
    }
    return _funcView;
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

- (UILabel *)subTitleLabel {
    
    if (!_subTitleLabel) {
        
        _subTitleLabel = [[UILabel alloc] init];
        
        _subTitleLabel.font = [UIFont systemFontOfSize:12];
        
        _subTitleLabel.numberOfLines = 1;
        
        _subTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        _subTitleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#999999"];
    }
    return _subTitleLabel;
}
- (UIImageView *)avatarImageView {
    
    if (!_avatarImageView) {
        
        _avatarImageView = [[UIImageView alloc] init];
        
        _avatarImageView.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@"#e1e1e1"].CGColor;
        
        _avatarImageView.layer.borderWidth = 0.5;
        
        _avatarImageView.layer.masksToBounds = true;
        
        _avatarImageView.layer.cornerRadius = 10;
        
        _avatarImageView.contentMode = UIViewContentModeCenter;
    }
    return _avatarImageView;
}

- (void)setCircleBean:(ZCircleBean *)circleBean {
    
    self.someCircle = circleBean;
    
    ZKeyValueBean *title = circleBean.contentMap.firstObject;
    
    self.titleLabel.text = title.value;
    
    ZKeyValueBean *image = nil;
    
    for (ZKeyValueBean *keyValue in circleBean.contentMap) {
        
        if ([keyValue.type isEqualToString:@"image"]) {
            
            image = keyValue;
            
            break;
        }
    }
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_400,h_300",image.value]] placeholderImage:[UIImage imageNamed:@ZLogoIcon] options:SDWebImageRefreshCached];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@ %@",circleBean.users.nickname,[[NSString stringWithFormat:@"%ld",circleBean.intime / 1000] s_convertToDate:SDateTypeDateStyle]];
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_100,h_100",circleBean.users.headImg]] placeholderImage:[UIImage imageNamed:@ZLogoIcon] options:SDWebImageRefreshCached];
    
    [self.funcView setCircleBean:circleBean];
}

- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.iconImageView];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.timeLabel];
    
    [self.contentView addSubview:self.funcView];
    
    [self.contentView addSubview:self.avatarImageView];
    
    [self.contentView addSubview:self.subTitleLabel];
    
    self.backgroundColor = [UIColor whiteColor];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(15);
        
        make.height.mas_equalTo(75);
        
        make.width.mas_equalTo(100);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        
        make.top.equalTo(self.iconImageView);
        
        make.right.mas_equalTo(-15);
    }];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView);
        
        make.top.equalTo(self.iconImageView.mas_bottom).offset(5);
        
        make.height.width.mas_equalTo(20);
        
    }];
    
    [self.funcView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self.avatarImageView.mas_centerY);
        
        make.height.mas_equalTo(30);
        
        make.width.mas_equalTo(140);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.avatarImageView.mas_right).offset(10);
        
        make.centerY.equalTo(self.avatarImageView.mas_centerY);
        
        make.height.mas_equalTo(30);
        
        make.right.equalTo(self.funcView.mas_left);
        
    }];
}

- (void)onFuncItemClick:(ZFuncItemType)itemType {
    
    if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(onFuncItemClick:forCircleBean:)]) {
        
        [self.mDelegate onFuncItemClick:itemType forCircleBean:self.someCircle];
    }
}
@end

@interface ZCircleVideoTableViewCell() <ZFuncItemViewDelegate>

@property (nonatomic ,strong )ZFuncItemView *funcView;

@property (nonatomic ,strong )UIImageView *iconImageView;

@property (nonatomic ,strong )UILabel *titleLabel;

@property (nonatomic ,strong) UILabel *timeLabel;

@property (nonatomic ,strong) UILabel *subTitleLabel;

@property (nonatomic ,strong) UIImageView *avatarImageView;

@property (nonatomic ,strong) ZCircleBean *someCircle;

@end

@implementation ZCircleVideoTableViewCell

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
        
        _iconImageView.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@"#e1e1e1"].CGColor;
        
        _iconImageView.layer.borderWidth = 0.5;
        
        _iconImageView.layer.masksToBounds = true;
        
        _iconImageView.contentMode = UIViewContentModeCenter;
    }
    return _iconImageView;
}
- (ZFuncItemView *)funcView {
    
    if (!_funcView) {
        
        _funcView = [[ZFuncItemView alloc] initWithFrame:CGRectZero];
        
        _funcView.mDelegate = self;
    }
    return _funcView;
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

- (UILabel *)subTitleLabel {
    
    if (!_subTitleLabel) {
        
        _subTitleLabel = [[UILabel alloc] init];
        
        _subTitleLabel.font = [UIFont systemFontOfSize:10];
        
        _subTitleLabel.numberOfLines = 1;
        
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        
        _subTitleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#ffffff"];
        
        _subTitleLabel.backgroundColor = [UIColor blackColor];
        
        _subTitleLabel.alpha = 0.5;
        
        _subTitleLabel.layer.cornerRadius = 9;
        
        _subTitleLabel.layer.masksToBounds = true;
    }
    return _subTitleLabel;
}
- (UIImageView *)avatarImageView {
    
    if (!_avatarImageView) {
        
        _avatarImageView = [[UIImageView alloc] init];
        
        _avatarImageView.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@"#e1e1e1"].CGColor;
        
        _avatarImageView.layer.borderWidth = 0.5;
        
        _avatarImageView.layer.masksToBounds = true;
        
        _avatarImageView.layer.cornerRadius = 10;
        
        _avatarImageView.contentMode = UIViewContentModeCenter;
    }
    return _avatarImageView;
}
- (void)setCircleBean:(ZCircleBean *)circleBean {
    
    self.someCircle = circleBean;
    
    ZKeyValueBean *title = circleBean.contentMap.firstObject;
    
    self.titleLabel.text = title.value;
    
    ZKeyValueBean *video = nil;
    
    for (ZKeyValueBean *keyValue in circleBean.contentMap) {
        
        if ([keyValue.type isEqualToString:@"video"]) {
            
            video = keyValue;
            
            break;
        }
    }
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=video/snapshot,t_7000,f_jpg,w_1600,h_1200,m_fast",video.value]] placeholderImage:[UIImage imageNamed:@ZLogoIcon] options:SDWebImageRefreshCached];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@ %@",circleBean.users.nickname,[[NSString stringWithFormat:@"%ld",circleBean.intime / 1000] s_convertToDate:SDateTypeDateStyle]];
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_100,h_100",circleBean.users.headImg]] placeholderImage:[UIImage imageNamed:@ZLogoIcon] options:SDWebImageRefreshCached];
    
    [self.funcView setCircleBean:circleBean];
    
    self.subTitleLabel.text = [ZCircleVideoTableViewCell getVideoTimeByUrlString:video.value];
    
}

- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.iconImageView];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.timeLabel];
    
    [self.contentView addSubview:self.funcView];
    
    [self.contentView addSubview:self.avatarImageView];
    
    [self.contentView addSubview:self.subTitleLabel];
    
    self.backgroundColor = [UIColor whiteColor];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(15);
        
        make.height.mas_equalTo(75);
        
        make.width.mas_equalTo(100);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        
        make.top.equalTo(self.iconImageView);
        
        make.right.mas_equalTo(-15);
    }];
    
    
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView);
        
        make.top.equalTo(self.iconImageView.mas_bottom).offset(5);
        
        make.height.width.mas_equalTo(20);
        
    }];
    
    [self.funcView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self.avatarImageView.mas_centerY);
        
        make.height.mas_equalTo(30);
        
        make.width.mas_equalTo(140);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.avatarImageView.mas_right).offset(10);
        
        make.centerY.equalTo(self.avatarImageView.mas_centerY);
        
        make.height.mas_equalTo(30);
        
        make.right.equalTo(self.funcView.mas_left);
        
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.iconImageView.mas_right).offset(-10);
        
        make.height.mas_equalTo(18);
        
        make.width.mas_equalTo(35);
        
        make.bottom.equalTo(self.iconImageView.mas_bottom).offset(-10);
    }];
    
}
+ (NSString *)getVideoTimeByUrlString:(NSString*)urlString {
    
    NSURL*videoUrl = [NSURL URLWithString:urlString];
    
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:videoUrl];
    
    CMTime time = [avUrl duration];
    
    int seconds = ceil(time.value/time.timescale);
    
    return [NSString stringWithFormat:@"%02d:%02d",seconds / 60 ,seconds % 60];
    
}

- (void)onFuncItemClick:(ZFuncItemType)itemType {
    
    if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(onFuncItemClick:forCircleBean:)]) {
        
        [self.mDelegate onFuncItemClick:itemType forCircleBean:self.someCircle];
    }
}
@end

#endif
