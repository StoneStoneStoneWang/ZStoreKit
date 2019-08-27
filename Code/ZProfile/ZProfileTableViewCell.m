//
//  ZProfileTableViewCell.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZProfileTableViewCell.h"
#import "ZFragmentConfig.h"
@import SToolsKit;
@import Masonry;

@interface ZProfileTableViewCell()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *subTitleLabel;

@end


@implementation ZProfileTableViewCell

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @ZLogoIcon]];
        
        _iconImageView.layer.cornerRadius = 30;
        
        _iconImageView.layer.masksToBounds = true;
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.font = [UIFont systemFontOfSize:15];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#666666"];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    
    if (!_subTitleLabel) {
        
        _subTitleLabel = [UILabel new];
        
        _subTitleLabel.font = [UIFont systemFontOfSize:15];
        
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
        
        _subTitleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#333333"];
    }
    return _subTitleLabel;
}
- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.subTitleLabel];
    
    [self.contentView addSubview:self.iconImageView];
}

- (void)setProfile:(ZProfileBean *)profile {
    
    self.titleLabel.text = profile.title;
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    self.subTitleLabel.hidden = true;
    
    self.bottomLineType = ZBottomLineTypeNormal;
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    switch (profile.type) {
        case ZProfileTypeAbout:
            
            self.iconImageView.image = [UIImage imageNamed: @AboutIcon];
            break;
        case  ZProfileTypeFocus:
            
            self.iconImageView.image = [UIImage imageNamed: @FocusIcon];
            break;
        case  ZProfileTypeOrder:
            
            self.iconImageView.image = [UIImage imageNamed: @OrderIcon];
            break;
        case ZProfileTypeAddress:
            
            self.iconImageView.image = [UIImage imageNamed: @AddressIcon];
            break;
        case  ZProfileTypePravicy:
            
            self.iconImageView.image = [UIImage imageNamed: @PravicyIcon];
            break;
        case  ZProfileTypeSetting:
            
            self.iconImageView.image = [UIImage imageNamed: @SettingIcon];
            break;
        case ZProfileTypeMyCircle:
            
            self.iconImageView.image = [UIImage imageNamed: @CircleIcon];
            break;
        case ZProfileTypeContactUS:
            
            self.iconImageView.image = [UIImage imageNamed: @CircleIcon];
            
            self.subTitleLabel.text = @ZPhoneNum;
            
            self.subTitleLabel.hidden = false;
            break;
        case  ZProfileTypeSpace:
            
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            
            self.bottomLineType = ZBottomLineTypeNone;
            
            self.backgroundColor = [UIColor clearColor];
            
            self.accessoryType = UITableViewCellSeparatorStyleNone;
            break;
        default:
            break;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.width.height.mas_equalTo(20);
        
        make.centerY.equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(15);
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self);
    }];
}
@end
