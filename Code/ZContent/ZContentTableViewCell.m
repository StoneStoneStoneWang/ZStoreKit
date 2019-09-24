//
//  ZConntentTableViewCell.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/20.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZContentTableViewCell.h"
@import SToolsKit;
@import Masonry;
@import SDWebImage;

@implementation ZContentTableViewCell


@end

@interface ZContentTextTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;

@end

@implementation ZContentTextTableViewCell

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
    
    self.titleLabel.text = keyValue.value;
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

@interface ZContentImageTableViewCell ()

@property (nonatomic ,strong )UIImageView *iconImageView;

@end

@implementation ZContentImageTableViewCell


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
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_1600,h_800",keyValue.value]] placeholderImage:[UIImage imageNamed:@ZLogoIcon] options:SDWebImageRefreshCached];
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
