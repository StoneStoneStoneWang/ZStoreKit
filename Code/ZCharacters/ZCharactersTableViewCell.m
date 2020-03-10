//
//  ZCharactersTableViewCell.m
//  ZFragment
//
//  Created by three stone 王 on 2020/3/9.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import "ZCharactersTableViewCell.h"
#import "ZFragmentConfig.h"
@import Masonry;
@import SToolsKit;

@interface ZCharactersTableViewCell()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UILabel *iconImageView;

@property (nonatomic ,strong) UILabel *subTitleLabel;

@property (nonatomic ,strong) UILabel *equipsLabel;
@end
@implementation ZCharactersTableViewCell


- (UILabel *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [[UILabel alloc] init];
     
        _iconImageView.backgroundColor = [UIColor s_transformToColorByHexColorStr:@ZFragmentColor];
        
        _iconImageView.textAlignment = NSTextAlignmentCenter;
        
        _iconImageView.font = [UIFont systemFontOfSize:20];
        
        _iconImageView.textColor = [UIColor whiteColor];
        
        _iconImageView.layer.cornerRadius = 45;
        
        _iconImageView.layer.masksToBounds = true;
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.font = [UIFont systemFontOfSize:15];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#333333"];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    
    if (!_subTitleLabel) {
        
        _subTitleLabel = [UILabel new];
        
        _subTitleLabel.font = [UIFont systemFontOfSize:15];
        
        _subTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        _subTitleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#333333"];
    }
    return _subTitleLabel;
}
- (UILabel *)equipsLabel {
    
    if (!_equipsLabel) {
        
        _equipsLabel = [UILabel new];
        
        _equipsLabel.font = [UIFont systemFontOfSize:15];
        
        _equipsLabel.textAlignment = NSTextAlignmentLeft;
        
        _equipsLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#333333"];
    }
    return _equipsLabel;
}
- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.subTitleLabel];
    
    [self.contentView addSubview:self.iconImageView];
    
    [self.contentView addSubview:self.equipsLabel];
    
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setCharacters:(ZCircleBean *)characters {
    
    ZKeyValueBean *title = nil;
    
    ZKeyValueBean *sex = nil;
    
    ZKeyValueBean *cname = nil;
    
    ZKeyValueBean *equip = nil;
    
    for (ZKeyValueBean *keyValue in characters.contentMap) {
        
        if ([keyValue.type isEqualToString:@"title"]) {
            
            title = keyValue;
            
            continue;
        }
        else if ([keyValue.type isEqualToString:@"txt"]) {
            
            if ([keyValue.value containsString:@"cName="]) {
                
                cname = keyValue;
            } else if ([keyValue.value containsString:@"sex="]) {
                
                sex = keyValue;
            } else if ([keyValue.value containsString:@"equip="]) {
                
                equip = keyValue;
            }
        }
    }
    
    self.titleLabel.text = [NSString stringWithFormat:@"昵称: %@",[cname.value componentsSeparatedByString:@"="].lastObject];
    
    NSString *a = [title.value componentsSeparatedByString:@"&"].firstObject;
    
    NSString *b = [title.value componentsSeparatedByString:@"&"].lastObject;
    
    self.iconImageView.text = a;
    
    self.subTitleLabel.text = [NSString stringWithFormat:@"角色信息&性别: %@&%@",b,[sex.value componentsSeparatedByString:@"="].lastObject];
    
    self.equipsLabel.text = @"";
    
    self.accessoryType = UITableViewCellAccessoryDetailButton;
    
    if (equip) {
        
        NSString *temp = [equip.value componentsSeparatedByString:@"="].lastObject;
        
        NSArray *mutable = [temp componentsSeparatedByString:@","];
        
        int t0 = 0;
        
        int t1 = 0;
        
        int t2 = 0;
        
        for (NSString *kv in mutable) {
            
            NSString *last = [kv componentsSeparatedByString:@":"].lastObject;
            
            if ([last isEqualToString: @"T0"]) {
                
                t0 += 1;
            } else if ([last isEqualToString: @"T1"]) {
                
                t1 += 1;
            } else if ([last isEqualToString: @"T2"]) {
                
                t2 += 1;
            }
        }
        
        if (t0 == 0) {
            
            if (t1 == 0) {
                
                self.equipsLabel.text = @"装备信息: T2*8";
            } else {
                
                if (t2 == 0) {
                    
                    self.equipsLabel.text = @"装备信息: T1*8";
                } else {
                    
                    self.equipsLabel.text = [NSString stringWithFormat:@"装备信息: T1*%d T2*%d",t1,t2];
                }
                
            }
        } else {
            
            if (t1 == 0) {
                
                self.equipsLabel.text = [NSString stringWithFormat:@"装备信息: T0*%d T2*%d",t0,t2];;
            } else {
                
                if (t2 == 0) {
                    
                    self.equipsLabel.text = [NSString stringWithFormat:@"装备信息: T0*%d T1*%d",t0,t1];
                } else {
                    
                    self.equipsLabel.text = [NSString stringWithFormat:@"装备信息: T0*%d T1*%d T2*%d",t0,t1,t2];
                }
                
            }
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.width.height.mas_equalTo(90);
        
        make.top.mas_equalTo(15);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(15);
        
        make.right.mas_equalTo(-15);
        
        make.top.equalTo(self.iconImageView.mas_top);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(15);
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self);
        
    }];
    
    [self.equipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(15);
        
        make.right.mas_equalTo(-15);
        
        make.bottom.equalTo(self.iconImageView.mas_bottom);
    }];
}
@end
