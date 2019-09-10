//
//  ZGoldCleanerTableViewCell.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZGoldCleanerTableViewCell.h"
@import SToolsKit;
@import Masonry;
@import SDWebImage;

#if ZAppFormGlobalOne

@interface ZGoldCleanerTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *nameLabel;


@end

@implementation ZGoldCleanerTableViewCell

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [UIImageView new];
        
        _iconImageView.contentMode = UIViewContentModeCenter;
        
        _iconImageView.layer.cornerRadius = 15;
        
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
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.iconImageView];
    
    [self.contentView addSubview:self.nameLabel];
    
    [self.contentView addSubview:self.titleLabel];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setKeyValue:(ZCircleBean *)keyValue {
    _keyValue = keyValue;
    
    self.bottomLineType = ZBottomLineTypeNone;
    
    self.nameLabel.text = keyValue.users.nickname;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_200,h_200",keyValue.users.headImg]] placeholderImage:[UIImage imageNamed:@ZLogoIcon] options:SDWebImageRefreshCached];
    
    NSMutableAttributedString *mutable = [NSMutableAttributedString new];
    
    
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:@"已认证" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14] ,NSForegroundColorAttributeName: [UIColor s_transformToColorByHexColorStr:@ZFragmentColor]}]];
    
    [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"好评: %ld",keyValue.countComment] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14] ,NSForegroundColorAttributeName: [UIColor s_transformToColorByHexColorStr:@"#666666"]}]];
    
    self.titleLabel.attributedText = mutable;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(15);
        
        make.height.width.mas_equalTo(40);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        
        make.centerY.equalTo(self.iconImageView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self.iconImageView);
    }];
    
}

@end
#endif

