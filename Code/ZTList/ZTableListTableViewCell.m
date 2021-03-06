//
//  ZTableListTableViewCell.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZTableListTableViewCell.h"
@import SToolsKit;
@import Masonry;
@import SDWebImage;

#if ZAppFormGlobalOne

@interface ZTableListTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UILabel *subTitleLabel;

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *nameLabel;

@property (nonatomic ,strong) UILabel *remarkLabel;

@property (nonatomic ,strong) UILabel *phoneLabel;

@property (nonatomic ,strong) UIButton *contactItem;

@property (nonatomic ,strong) UILabel *timeLabel;

@property (nonatomic ,strong) UIButton *moreItem;

@property (nonatomic ,strong) UIView *aContentView;

@end
@implementation ZTableListTableViewCell

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
- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        
        _timeLabel = [UILabel new];
        
        _timeLabel.font = [UIFont systemFontOfSize:13];
        
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        
        _timeLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#999999"];
    }
    return _timeLabel;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.font = [UIFont systemFontOfSize:14];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#333333"];
        
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}
- (UILabel *)subTitleLabel {
    
    if (!_subTitleLabel) {
        
        _subTitleLabel = [UILabel new];
        
        _subTitleLabel.font = [UIFont systemFontOfSize:13];
        
        _subTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        _subTitleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#666666"];
    }
    return _subTitleLabel;
}
- (UIButton *)moreItem {
    
    if (!_moreItem) {
        
        _moreItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_moreItem setImage:[UIImage imageNamed:@ZMoreIcon] forState:UIControlStateNormal];
        
        [_moreItem setImage:[UIImage imageNamed:@ZMoreIcon] forState:UIControlStateSelected];
    }
    return _moreItem;
}

- (UIButton *)contactItem {
    
    if (!_contactItem) {
        
        _contactItem = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _contactItem;
}

- (UIView *)aContentView {
    
    if (!_aContentView) {
        
        _aContentView = [UIView new];
        
        _aContentView.layer.cornerRadius = 5;
        
        _aContentView.layer.masksToBounds = true;
        
        _aContentView.backgroundColor = [UIColor whiteColor];
    }
    return _aContentView;
}
- (UILabel *)phoneLabel {
    
    if (!_phoneLabel) {
        
        _phoneLabel = [UILabel new];
        
        _phoneLabel.font = [UIFont systemFontOfSize:13];
        
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        
        _phoneLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#999999"];
        
    }
    return _phoneLabel;
}

- (UILabel *)remarkLabel {
    
    if (!_remarkLabel) {
        
        _remarkLabel = [UILabel new];
        
        _remarkLabel.font = [UIFont systemFontOfSize:13];
        
        _remarkLabel.textAlignment = NSTextAlignmentLeft;
        
        _remarkLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#999999"];
        
    }
    return _remarkLabel;
}
- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.aContentView];
    
    [self.aContentView addSubview:self.iconImageView];
    
    [self.aContentView addSubview:self.nameLabel];
    
    [self.aContentView addSubview:self.timeLabel];
    
    [self.aContentView addSubview:self.titleLabel];
    
    [self.aContentView addSubview:self.phoneLabel];
    
    [self.aContentView addSubview:self.moreItem];
    
    [self.aContentView addSubview:self.contactItem];
    
    [self.aContentView addSubview:self.subTitleLabel];
    
    [self.aContentView addSubview:self.remarkLabel];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setKeyValue:(ZCircleBean *)keyValue {
    
    self.bottomLineType = ZBottomLineTypeNone;
    
    for (ZKeyValueBean *k in keyValue.contentMap) {
        
        if ([k.value containsString:@"时间"]) {
            
            self.timeLabel.text = [[k.value componentsSeparatedByString:@" "].firstObject componentsSeparatedByString:@":"].lastObject;
            
        } else if ([k.value containsString:@"address"]) {
            
            self.titleLabel.text = [NSString stringWithFormat:@"服务地址: %@",[k.value componentsSeparatedByString:@":"].lastObject];
            
        } else if ([k.value containsString:@"详细地址"]) {
            
            self.subTitleLabel.text = [NSString stringWithFormat:@"详细地址: %@",[k.value componentsSeparatedByString:@":"].lastObject];
        } else if ([k.value containsString:@"备注"]) {
            
            self.remarkLabel.text = [NSString stringWithFormat:@"备注: %@",[k.value componentsSeparatedByString:@":"].lastObject];
        } else if ([k.value containsString:@"手机"]) {
            
            self.phoneLabel.text = [NSString stringWithFormat:@"联系电话: %@",[k.value componentsSeparatedByString:@":"].lastObject];
        }
    }
    
    self.nameLabel.text = keyValue.users.nickname;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_200,h_200",keyValue.users.headImg]] placeholderImage:[UIImage imageNamed:@ZLogoIcon] options:SDWebImageRefreshCached];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.aContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.top.mas_equalTo(5);
        
        make.bottom.mas_equalTo(-5);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.height.width.mas_equalTo(30);
        
        make.top.mas_equalTo(15);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        
        make.centerY.equalTo(self.iconImageView);
    }];
    
    [self.moreItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self.iconImageView);
    }];
    //
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.moreItem.mas_left).offset(-15);
        
        make.centerY.equalTo(self.iconImageView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.top.equalTo(self.iconImageView.mas_bottom).offset(15);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.top.equalTo(self.phoneLabel.mas_bottom).offset(5);
        
    }];
    
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.top.equalTo(self.subTitleLabel.mas_bottom).offset(5);
        
    }];
}

@end

#elif ZAppFormGlobalTwo


@interface ZTableListTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UILabel *subTitleLabel;

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *nameLabel;

@property (nonatomic ,strong) UILabel *remarkLabel;

@property (nonatomic ,strong) UILabel *phoneLabel;

@property (nonatomic ,strong) UIButton *contactItem;

@property (nonatomic ,strong) UILabel *timeLabel;

@property (nonatomic ,strong) UIButton *moreItem;

@property (nonatomic ,strong) UIView *aContentView;

@end
@implementation ZTableListTableViewCell

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
- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        
        _timeLabel = [UILabel new];
        
        _timeLabel.font = [UIFont systemFontOfSize:13];
        
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        
        _timeLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#999999"];
    }
    return _timeLabel;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.font = [UIFont systemFontOfSize:14];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#333333"];
        
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}
- (UILabel *)subTitleLabel {
    
    if (!_subTitleLabel) {
        
        _subTitleLabel = [UILabel new];
        
        _subTitleLabel.font = [UIFont systemFontOfSize:13];
        
        _subTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        _subTitleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#666666"];
    }
    return _subTitleLabel;
}
- (UIButton *)moreItem {
    
    if (!_moreItem) {
        
        _moreItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_moreItem setImage:[UIImage imageNamed:@ZMoreIcon] forState:UIControlStateNormal];
        
        [_moreItem setImage:[UIImage imageNamed:@ZMoreIcon] forState:UIControlStateSelected];
    }
    return _moreItem;
}

- (UIButton *)contactItem {
    
    if (!_contactItem) {
        
        _contactItem = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _contactItem;
}

- (UIView *)aContentView {
    
    if (!_aContentView) {
        
        _aContentView = [UIView new];
        
        _aContentView.layer.cornerRadius = 5;
        
        _aContentView.layer.masksToBounds = true;
        
        _aContentView.backgroundColor = [UIColor whiteColor];
    }
    return _aContentView;
}
- (UILabel *)phoneLabel {
    
    if (!_phoneLabel) {
        
        _phoneLabel = [UILabel new];
        
        _phoneLabel.font = [UIFont systemFontOfSize:13];
        
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        
        _phoneLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#999999"];
        
    }
    return _phoneLabel;
}

- (UILabel *)remarkLabel {
    
    if (!_remarkLabel) {
        
        _remarkLabel = [UILabel new];
        
        _remarkLabel.font = [UIFont systemFontOfSize:13];
        
        _remarkLabel.textAlignment = NSTextAlignmentLeft;
        
        _remarkLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#999999"];
        
    }
    return _remarkLabel;
}
- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.aContentView];
    
    [self.aContentView addSubview:self.iconImageView];
    
    [self.aContentView addSubview:self.nameLabel];
    
    [self.aContentView addSubview:self.timeLabel];
    
    [self.aContentView addSubview:self.titleLabel];
    
    [self.aContentView addSubview:self.phoneLabel];
    
    [self.aContentView addSubview:self.moreItem];
    
    [self.aContentView addSubview:self.contactItem];
    
    [self.aContentView addSubview:self.subTitleLabel];
    
    [self.aContentView addSubview:self.remarkLabel];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setKeyValue:(ZCircleBean *)keyValue {
    
    self.bottomLineType = ZBottomLineTypeNone;
    
    for (ZKeyValueBean *k in keyValue.contentMap) {
        
        if ([k.value containsString:@"时间"]) {
            
            self.timeLabel.text = [[k.value componentsSeparatedByString:@" "].firstObject componentsSeparatedByString:@":"].lastObject;
            
        } else if ([k.value containsString:@"address"]) {
            
            self.titleLabel.text = [NSString stringWithFormat:@"服务地址: %@",[k.value componentsSeparatedByString:@":"].lastObject];
            
        } else if ([k.value containsString:@"详细地址"]) {
            
            self.subTitleLabel.text = [NSString stringWithFormat:@"详细地址: %@",[k.value componentsSeparatedByString:@":"].lastObject];
        } else if ([k.value containsString:@"备注"]) {
            
            self.remarkLabel.text = [NSString stringWithFormat:@"备注: %@",[k.value componentsSeparatedByString:@":"].lastObject];
        } else if ([k.value containsString:@"手机"]) {
            
            self.phoneLabel.text = [NSString stringWithFormat:@"联系电话: %@",[k.value componentsSeparatedByString:@":"].lastObject];
        }
    }
    
    self.nameLabel.text = keyValue.users.nickname;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_200,h_200",keyValue.users.headImg]] placeholderImage:[UIImage imageNamed:@ZLogoIcon] options:SDWebImageRefreshCached];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.aContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.top.mas_equalTo(5);
        
        make.bottom.mas_equalTo(-5);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.height.width.mas_equalTo(30);
        
        make.top.mas_equalTo(15);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        
        make.centerY.equalTo(self.iconImageView);
    }];
    
    [self.moreItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self.iconImageView);
    }];
    //
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.moreItem.mas_left).offset(-15);
        
        make.centerY.equalTo(self.iconImageView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.top.equalTo(self.iconImageView.mas_bottom).offset(15);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.top.equalTo(self.phoneLabel.mas_bottom).offset(5);
        
    }];
    
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.top.equalTo(self.subTitleLabel.mas_bottom).offset(5);
        
    }];
}

@end

#endif


