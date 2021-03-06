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

@property (nonatomic ,strong) UILabel *iconLabel;

@property (nonatomic ,strong) UILabel *phoneLabel;

@end

@implementation ZGoldCleanerTableViewCell

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [UIImageView new];
        
        _iconImageView.contentMode = UIViewContentModeCenter;
        
        _iconImageView.layer.cornerRadius = 20;
        
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
- (UILabel *)iconLabel {
    
    if (!_iconLabel) {
        
        _iconLabel = [UILabel new];
        
        _iconLabel.layer.cornerRadius = 20;
        
        _iconLabel.layer.masksToBounds = true;
        
        _iconLabel.font = [UIFont systemFontOfSize:20];
        
        _iconLabel.textColor = [UIColor whiteColor];
        
        _iconLabel.backgroundColor = [UIColor s_transformToColorByHexColorStr:@"e1e1e1"];
        
        _iconLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _iconLabel;
}
- (UILabel *)phoneLabel {
    
    if (!_phoneLabel) {
        
        _phoneLabel = [UILabel new];
        
        _phoneLabel.font = [UIFont systemFontOfSize:15];
        
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        
        _phoneLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#666666"];
        
    }
    return _phoneLabel;
}
- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.iconImageView];
    
    [self.contentView addSubview:self.nameLabel];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.iconLabel];
    
    [self.contentView addSubview:self.phoneLabel];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setKeyValue:(ZCircleBean *)keyValue {
    
    ZKeyValueBean *title = nil;
    
    for (ZKeyValueBean *kv in keyValue.contentMap) {
        
        if ([kv.type isEqualToString:@"title"]) {
            
            title = kv;
            
            break;
        }
    }
    
    self.bottomLineType = ZBottomLineTypeNone;
    
    self.nameLabel.text = title.value;
    
    if (title.value.length > 1) {
        
        self.iconLabel.text = [title.value substringToIndex:1];
    }
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_200,h_200",keyValue.users.headImg]] placeholderImage:[UIImage imageNamed:@ZLogoIcon] options:SDWebImageRefreshCached];
    
    NSMutableAttributedString *mutable = [NSMutableAttributedString new];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:@"已认证" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14] ,NSForegroundColorAttributeName: [UIColor s_transformToColorByHexColorStr:@ZFragmentColor]}]];
    
    self.titleLabel.attributedText = mutable;
    
    if (![keyValue.users.nickname s_validPhone]) {
        
        NSString *result = keyValue.users.nickname;
        
        result = [result stringByReplacingCharactersInRange:NSMakeRange(4, 4) withString:@"****"];
        
        self.phoneLabel.text = result;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(15);
        
        make.height.width.mas_equalTo(40);
    }];
    
    [self.iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(15);
        
        make.height.width.mas_equalTo(40);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        
        make.bottom.equalTo(self.iconImageView.mas_centerY).offset(-1);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        
        make.top.equalTo(self.iconImageView.mas_centerY).offset(1);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self.iconImageView);
    }];
    
}

@end

#elif ZAppFormGlobalTwo

@interface ZGoldCleanerTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *nameLabel;

@property (nonatomic ,strong) UIButton *evaluteItem;

@property (nonatomic ,strong) UILabel *phoneLabel;

@property (nonatomic ,strong) UILabel *iconLabel;
@end

@implementation ZGoldCleanerTableViewCell

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [UIImageView new];
        
        _iconImageView.contentMode = UIViewContentModeCenter;
        
        _iconImageView.layer.cornerRadius = 5;
        
        _iconImageView.layer.masksToBounds = true;
    }
    return _iconImageView;
}
- (UILabel *)iconLabel {
    
    if (!_iconLabel) {
        
        _iconLabel = [UILabel new];
        
        _iconLabel.layer.cornerRadius = 5;
        
        _iconLabel.layer.masksToBounds = true;
        
        _iconLabel.font = [UIFont systemFontOfSize:20];
        
        _iconLabel.textColor = [UIColor whiteColor];
        
        _iconLabel.backgroundColor = [UIColor s_transformToColorByHexColorStr:@"e1e1e1"];
        
        _iconLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _iconLabel;
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
- (UILabel *)phoneLabel {
    
    if (!_phoneLabel) {
        
        _phoneLabel = [UILabel new];
        
        _phoneLabel.font = [UIFont systemFontOfSize:15];
        
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        
        _phoneLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#666666"];
        
    }
    return _phoneLabel;
}
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

- (UIButton *)evaluteItem {
    
    if (!_evaluteItem) {
        
        _evaluteItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_evaluteItem setTitle:@"去评价" forState:UIControlStateNormal];
        
        [_evaluteItem setTitle:@"去评价" forState:UIControlStateHighlighted];
        
        [_evaluteItem setTitle:@"已评价" forState:UIControlStateDisabled];
        
        _evaluteItem.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [_evaluteItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#999999"] forState:UIControlStateDisabled];
        
        [_evaluteItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor] forState:UIControlStateNormal];
        
        [_evaluteItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor] forState:UIControlStateHighlighted];
        
    }
    return _evaluteItem;
}
- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.iconImageView];
    
    [self.contentView addSubview:self.iconLabel];
    
    [self.contentView addSubview:self.nameLabel];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.evaluteItem];
    
    [self.contentView addSubview:self.phoneLabel];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.evaluteItem addTarget:self action:@selector(onEvaluateClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)onEvaluateClick {
    
    if ([self.delegate respondsToSelector:@selector(onEnvaluateItemClick:)]) {
        
        [self.delegate onEnvaluateItemClick:self.keyValue ];
    }
    
}
- (void)setKeyValue:(ZCircleBean *)keyValue {
    
    ZKeyValueBean *title = nil;
    
    for (ZKeyValueBean *kv in keyValue.contentMap) {
        
        if ([kv.type isEqualToString:@"title"]) {
            
            title = kv;
            
            break;
        }
    }
    
    self.bottomLineType = ZBottomLineTypeNone;
    
    self.nameLabel.text = title.value;
    
    if (title.value.length > 1) {
        
        self.iconLabel.text = [title.value substringToIndex:1];
    }
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_200,h_200",keyValue.users.headImg]] placeholderImage:[UIImage imageNamed:@ZLogoIcon] options:SDWebImageRefreshCached];
    
    NSMutableAttributedString *mutable = [NSMutableAttributedString new];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:@"已认证" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14] ,NSForegroundColorAttributeName: [UIColor s_transformToColorByHexColorStr:@ZFragmentColor]}]];
    
    self.titleLabel.attributedText = mutable;
    
    self.evaluteItem.enabled = !keyValue.isLaud;
    
    if (![keyValue.users.nickname s_validPhone]) {
        
        NSString *result = keyValue.users.nickname;
        
        result = [result stringByReplacingCharactersInRange:NSMakeRange(4, 4) withString:@"****"];
        
        self.phoneLabel.text = result;
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(15);
        
        make.height.width.mas_equalTo(40);
    }];
    
    [self.iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(15);
        
        make.height.width.mas_equalTo(40);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        
        make.bottom.equalTo(self.iconImageView.mas_centerY).offset(-1);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        
        make.top.equalTo(self.iconImageView.mas_centerY).offset(1);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.bottom.mas_equalTo(-5);
        
        make.height.mas_equalTo(@30);
        
    }];
    
    [self.evaluteItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self.titleLabel);
        
        make.height.mas_equalTo(@30);
        
    }];
    
    
}

@end

#endif


