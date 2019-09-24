//
//  ZPublishTableViewCell.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZPublishTableViewCell.h"
@import SToolsKit;
@import Masonry;
@import SDWebImage;
@import AVFoundation;

@interface ZPublishTableViewCell ()

@property (nonatomic ,strong) UIButton *deleteItem;


@end
@implementation ZPublishTableViewCell

- (void)setKeyValue:(ZKeyValueBean *)keyValue {
    _keyValue = keyValue;
    
}

- (UIButton *)deleteItem {
    
    if (!_deleteItem) {
        
        _deleteItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_deleteItem setImage:[UIImage imageNamed:@ZDeleteIcon] forState:UIControlStateNormal];
        
        [_deleteItem setImage:[UIImage imageNamed:@ZDeleteIcon] forState:UIControlStateSelected];
        
        _deleteItem.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    return _deleteItem;
}
- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.deleteItem];
    
    [self.deleteItem sizeToFit];
    
    [self.deleteItem addTarget:self action:@selector(onDeleteItemClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)onDeleteItemClick {
    
    if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(onDeleteItemClick:)]) {
        
        [self.mDelegate onDeleteItemClick:self.keyValue];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.deleteItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-5);
        
        make.top.mas_equalTo(5);
    }];
}
@end
@interface ZPublishTextTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;

@end


@implementation ZPublishTextTableViewCell


- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        
        _titleLabel.font = [UIFont systemFontOfSize:15];
        
        _titleLabel.numberOfLines = 0;
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#333333"];
    }
    return _titleLabel;
}

- (void)commitInit {
    [super commitInit];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.titleLabel];
}
- (void)setKeyValue:(ZKeyValueBean *)keyValue {
    [super setKeyValue:keyValue];
    self.titleLabel.text = keyValue.value;
    
    self.bottomLineType = ZBottomLineTypeNormal;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.top.mas_equalTo(10);
        
        make.bottom.mas_equalTo(-10);
        
        make.right.mas_equalTo(-15);
    }];
    
}
@end

@interface ZPublishImageTableViewCell ()

@property (nonatomic ,strong )UIImageView *iconImageView;

@end

@implementation ZPublishImageTableViewCell


- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
        
        _iconImageView.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@"#e1e1e1"].CGColor;
        
        _iconImageView.layer.borderWidth = 0.5;
        
        _iconImageView.layer.masksToBounds = true;
        
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconImageView;
}

- (void)setKeyValue:(ZKeyValueBean *)keyValue {
    [super setKeyValue:keyValue];
    
    self.iconImageView.image = keyValue.img;
    
    self.bottomLineType = ZBottomLineTypeNormal;
}
- (void)commitInit {
    [super commitInit];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.iconImageView];
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.top.mas_equalTo(5);
        
        make.bottom.mas_equalTo(-5);
    }];
}

@end

#import <objc/runtime.h>
static const char * RY_CLICKKEY = "ry_clickkey";

@implementation ZKeyValueBean (cate)

- (void)setVideoUrl:(NSURL *)videoUrl {
    
    objc_setAssociatedObject(self, RY_CLICKKEY, videoUrl, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSURL *)videoUrl {
    
    return objc_getAssociatedObject(self, RY_CLICKKEY);
}

@end

@interface ZPublishVideoTableViewCell()

@property (nonatomic ,strong )UIImageView *iconImageView;

@property (nonatomic ,strong )UILabel *subTitleLabel;
@end

@implementation ZPublishVideoTableViewCell

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
        
        _iconImageView.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@"#e1e1e1"].CGColor;
        
        _iconImageView.layer.borderWidth = 0.5;
        
        _iconImageView.layer.masksToBounds = true;
        
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconImageView;
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
- (void)setKeyValue:(ZKeyValueBean *)keyValue {
    [super setKeyValue:keyValue];
    
    self.iconImageView.image = keyValue.img;
    
    self.bottomLineType = ZBottomLineTypeNormal;
    
    self.subTitleLabel.text = [ZPublishVideoTableViewCell getVideoTimeByUrlString:keyValue.videoUrl];

}

+ (NSString *)getVideoTimeByUrlString:(NSURL *)videoUrl {
    
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:videoUrl];
    
    CMTime time = [avUrl duration];
    
    int seconds = ceil(time.value/time.timescale);
    
    return [NSString stringWithFormat:@"%02d:%02d",seconds / 60 ,seconds % 60];
}

- (void)commitInit {
    [super commitInit];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.iconImageView];
    
    [self.contentView addSubview:self.subTitleLabel];
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.top.mas_equalTo(5);
        
        make.bottom.mas_equalTo(-5);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.iconImageView.mas_right).offset(-10);
        
        make.height.mas_equalTo(18);
        
        make.width.mas_equalTo(35);
        
        make.bottom.equalTo(self.iconImageView.mas_bottom).offset(-10);
    }];
}

@end

