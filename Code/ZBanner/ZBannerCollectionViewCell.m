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
- (void)setCircleBean:(ZCircleBean *)circleBean {
    _circleBean = circleBean;
    
}

- (void)commitInit {
    
    self.backgroundColor = [UIColor whiteColor];
}
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
        
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImageView;
}

- (void)setImage:(NSString *)image {
    
    self.iconImageView.image = [UIImage imageNamed:image];
}
- (void)setCircleBean:(ZCircleBean *)circleBean {
    [super setCircleBean:circleBean];
    
    ZKeyValueBean *image = nil;
    
    for (ZKeyValueBean *keyValue in circleBean.contentMap) {
        
        if ([keyValue.type isEqualToString:@"image"]) {
            
            image = keyValue;
            
            break;
        }
    }
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=image/resize,m_fill,w_1600,h_800",image.value]] placeholderImage:[UIImage imageNamed:@ZLogoIcon] options:SDWebImageRefreshCached];
    
}
- (void)commitInit {
    [super commitInit];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.iconImageView];
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iconImageView.frame = self.bounds;
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
        
        _iconImageView.contentMode = UIViewContentModeScaleToFill;
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
- (void)setCircleBean:(ZCircleBean *)circleBean {
    [super setCircleBean:circleBean];
    
    ZKeyValueBean *video = nil;
    
    for (ZKeyValueBean *keyValue in circleBean.contentMap) {
        
        if ([keyValue.type isEqualToString:@"video"]) {
            
            video = keyValue;
            
            break;
        }
    }
#if ZBannerFormOne
    
   [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=video/snapshot,t_7000,f_jpg,w_1600,h_800,m_fast",video.value]] placeholderImage:[UIImage imageNamed:@ZLogoIcon] options:SDWebImageRefreshCached];
#elif ZBannerFormTwo
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=video/snapshot,t_7000,f_jpg,w_1400,h_600,m_fast",video.value]] placeholderImage:[UIImage imageNamed:@ZLogoIcon] options:SDWebImageRefreshCached];
#else
    
#endif //
    
    
    self.subTitleLabel.text = [ZBannerVideoCollectionViewCell getVideoTimeByUrlString:[NSURL URLWithString:video.value]];
    
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
    
    self.iconImageView.frame = self.bounds;
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.iconImageView.mas_right).offset(-10);
        
        make.height.mas_equalTo(18);
        
        make.width.mas_equalTo(35);
        
        make.bottom.equalTo(self.iconImageView.mas_bottom).offset(-10);
    }];
}

@end
