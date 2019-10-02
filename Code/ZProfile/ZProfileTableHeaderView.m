//
//  ZProfileTableHeaderView.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZProfileTableHeaderView.h"
#import "ZFragmentConfig.h"
@import ZBridge;
@import SDWebImage;
@import ZBean;
@import SToolsKit;
@import Masonry;

@interface ZProfileTableHeaderView ()

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *nameLabel;

@property (nonatomic ,strong) UITableViewCell *cell;

@end
@implementation ZProfileTableHeaderView

- (UITableViewCell *)cell {
    
    if (!_cell) {
        
        _cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        _cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        _cell.backgroundColor = [UIColor clearColor];
    }
    return _cell;
}

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

- (void)commitInit {
    [super commitInit];
    
    [self addSubview:self.cell];
    
    [self addSubview:self.iconImageView];
    
    [self addSubview:self.nameLabel];
    
    self.backgroundColor = [UIColor whiteColor];
}
- (void)setUser:(ZUserBean *)user {
    
    if (user.nickname.length) {
        
        self.nameLabel.text = user.nickname;
        
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_200,h_200",user.headImg]] placeholderImage:[UIImage imageNamed:@ZLogoIcon] options:SDWebImageRefreshCached];
        
    } else {
        
        self.iconImageView.image = [UIImage imageNamed:@ZLogoIcon];
        
        self.nameLabel.text = @"未登录";
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(@15);
        
        make.width.height.mas_equalTo(@60);
        
        make.centerY.equalTo(self);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
    }];
    
    self.cell.frame = self.bounds;
}

@end
