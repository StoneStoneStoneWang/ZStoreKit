//
//  ZProfileTableViewCell.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZProfileTableViewCell.h"
@import SToolsKit;
@import Masonry;
@import ZSign;

@interface ZProfileTableViewCell()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UIImageView *iconImageView;

@end


@implementation ZProfileTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.font = [UIFont systemFontOfSize:15];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#666666"];
    }
    return _titleLabel;
}

- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.iconImageView];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
}

- (void)setProfile:(ZProfileBean *)profile {
    
    self.titleLabel.text = profile.title;
    
    switch (profile.type) {
        case ZProfileTypeAbout:
            
            self.iconImageView.image = [UIImage imageNamed:@""];
            break;
            
        default:
            break;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(@15);
        
        make.width.height.mas_equalTo(20);
        
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(15);
        
        make.right.mas_equalTo(@-15);
        
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}
@end
