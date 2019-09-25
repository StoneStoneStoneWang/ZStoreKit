//
//  ZBannerCollectionViewCell.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZBannerCollectionViewCell.h"
@import SToolsKit;
@import Masonry;
@import SDWebImage;
@import AVFoundation;

@implementation ZBannerCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self commitInit];
        
    }
    return self;
}
- (void)setKeyValue:(ZKeyValueBean *)keyValue {
    _keyValue = keyValue;
    
}

- (void)commitInit { }
@end
@interface ZBannerImageCollectionViewCell ()

@property (nonatomic ,strong )UIImageView *iconImageView;

@end

@implementation ZBannerImageCollectionViewCell


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

@implementation ZKeyValueBean (video)

- (void)setVideoUrl:(NSURL *)videoUrl {
    
    objc_setAssociatedObject(self, RY_CLICKKEY, videoUrl, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSURL *)videoUrl {
    
    return objc_getAssociatedObject(self, RY_CLICKKEY);
}

@end

@interface ZBannerVideoCollectionViewCell()

@property (nonatomic ,strong )UIImageView *iconImageView;

@property (nonatomic ,strong )UILabel *subTitleLabel;
@end

@implementation ZBannerVideoCollectionViewCell

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
    
    self.subTitleLabel.text = [ZBannerVideoCollectionViewCell getVideoTimeByUrlString:keyValue.videoUrl];
    
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
