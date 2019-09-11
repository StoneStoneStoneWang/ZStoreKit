//
//  ZFocusTableViewCell.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZFocusTableViewCell.h"
@import SToolsKit;
@import Masonry;
@import SDWebImage;
@interface ZFocusTableViewCell()

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *nameLabel;

@property (nonatomic ,strong) UILabel *timeLabel;

@end

@implementation ZFocusTableViewCell

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [UIImageView new];
        
        _iconImageView.contentMode = UIViewContentModeCenter;
        
        _iconImageView.layer.cornerRadius = 5;
        
        _iconImageView.layer.masksToBounds = true;
    }
    return _iconImageView;
}
- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = [UILabel new];
        
        _nameLabel.font = [UIFont systemFontOfSize:15];
        
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        
        _nameLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#333333"];
        
    }
    return _nameLabel;
}
- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        
        _timeLabel = [UILabel new];
        
        _timeLabel.font = [UIFont systemFontOfSize:13];
        
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        
        _timeLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#999999"];
    }
    return _timeLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self commitInit];
    }
    return self;
}
- (void)commitInit {
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.iconImageView];
    
    [self.contentView addSubview:self.nameLabel];
    
    [self.contentView addSubview:self.timeLabel];
}
- (void)setFocus:(ZFocusBean *)focus {
//    _focus = focus;
    
    self.timeLabel.text = [[NSString stringWithFormat:@"%ld",focus.intime / 1000] s_convertToDate:SDateTypeDateStyle];
    
    self.nameLabel.text = focus.users.nickname;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_200,h_200",focus.users.headImg]] placeholderImage:[UIImage imageNamed:@ZLogoIcon] options:SDWebImageRefreshCached];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(@15);
        
        make.bottom.mas_equalTo(@-15);
        
        make.width.mas_equalTo(@(CGRectGetHeight(self.bounds) - 30));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(15);
        
        make.bottom.mas_equalTo(self.iconImageView.mas_centerY).offset(-3);
        
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(15);
        
        make.top.mas_equalTo(self.iconImageView.mas_centerY).offset(3);
    }];
}
@end
