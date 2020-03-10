//
//  ZEquipViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2020/3/10.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import "ZEquipViewController.h"
@import ZBridge;
@import ZTField;
@import SToolsKit;
@import Masonry;
@import JXTAlertManager;

@interface ZEquipTableViewCell ()

@property (nonatomic ,strong) ZEquipBean *equipBean;

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) WLBaseTextField *subTitleLabel;

@end

@implementation ZEquipTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.font = [UIFont systemFontOfSize:15];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#666666"];
    }
    return _titleLabel;
}

- (WLBaseTextField *)subTitleLabel {
    
    if (!_subTitleLabel) {
        
        _subTitleLabel = [[WLBaseTextField alloc] initWithFrame:CGRectZero];
        
        _subTitleLabel.font = [UIFont systemFontOfSize:15];
        
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
        
        _subTitleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#333333"];
    }
    return _subTitleLabel;
}

- (void)setEquipBean:(ZEquipBean *)equipBean {
    
    self.titleLabel.text = equipBean.title;
    
    self.bottomLineType = ZBottomLineTypeNormal;
    
    self.subTitleLabel.text = equipBean.subtitle;
    
    self.subTitleLabel.placeholder = equipBean.placeholder;
    
    self.subTitleLabel.userInteractionEnabled = false;
    
    switch (equipBean.type) {
        case ZEquipTypeSpace:
            
            self.backgroundColor = [UIColor clearColor];
            
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            
            self.accessoryType = UITableViewCellAccessoryNone;
            
            break;
            
        default:
            
            self.backgroundColor = [UIColor whiteColor];
            
            self.selectionStyle = UITableViewCellSelectionStyleDefault;
            
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            
            break;
    }
}

- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.subTitleLabel];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-15);
        
        make.width.mas_equalTo(CGRectGetWidth(self.bounds) / 2);
        
        make.centerY.equalTo(self);
    }];
}

@end

@interface ZEquipViewController()

@property (nonatomic ,copy) ZCharacterEquipSucc equipsBlock;

@property (nonatomic ,copy) NSString *equipsValue;

@property (nonatomic ,strong) ZEquipBridge *bridge;

@property (nonatomic ,strong) UIButton *completeItem;

@end

@implementation ZEquipViewController

- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateNormal];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateSelected];
        
        _completeItem.titleLabel.font = [UIFont systemFontOfSize:15];
        
        if ([@ZFragmentColor isEqualToString:@"#ffffff"]) {
            
            [_completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#666666"] forState:UIControlStateNormal];
            
            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#66666680"] forState:UIControlStateHighlighted];
            
            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#66666650"] forState:UIControlStateDisabled];
            
        } else {
            
            [_completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
            
            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff80"] forState:UIControlStateHighlighted];
            
            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff50"] forState:UIControlStateDisabled];
        }
    }
    return _completeItem;
}

+ (instancetype)createEquip:(NSString *)equips andBlock:(nonnull ZCharacterEquipSucc)block {
    
    return [[self alloc] initWithEquip:equips andBlock:block];
}
- (instancetype)initWithEquip:(NSString *)equips andBlock:(nonnull ZCharacterEquipSucc)block {
    
    if (self = [super init]) {
        
        self.equipsValue = equips;
        
        self.equipsBlock = block;
    }
    return self;
}

- (void)configOwnSubViews {
    
    [self.tableView registerClass:[ZEquipTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)configViewModel {
    
    self.bridge = [ZEquipBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createEquip:self equips:self.equipsValue succ:^(NSString * _Nonnull equips) {
        
        weakSelf.equipsBlock(equips);
    }];
}
- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZEquipTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[ZEquipTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.equipBean = data;
    
    return cell;
}
- (void)tableViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZEquipBean *equip = (ZEquipBean *)data;
    
    switch (equip.type) {
        case ZEquipTypeSpace:
            
            break;
            
        default:
        {
            __weak typeof(self) weakSelf = self;
            
            [self jxt_showActionSheetWithTitle:[NSString stringWithFormat:@"请选择%@等级",equip.title] message:@"装备名称比较多样性,这里以T0 T1 T2 代替" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                
                alertMaker.
                addActionCancelTitle(@"取消").
                addActionDefaultTitle(@"T0").
                addActionDefaultTitle(@"T1").
                addActionDefaultTitle(@"T2");
            } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                
                if ([action.title isEqualToString:@"取消"]) {
                    
                } else if ([action.title isEqualToString:@"T0"]) {
                    
                    [weakSelf.bridge updateEquipWithType:equip.type level:ZEquipLevelZero];
                    
                } else if ([action.title isEqualToString:@"T1"]) {
                    
                    [weakSelf.bridge updateEquipWithType:equip.type level:ZEquipLevelOne];
                } else if ([action.title isEqualToString:@"T2"]) {
                    
                    [weakSelf.bridge updateEquipWithType:equip.type level:ZEquipLevelTwo];
                }
                
            }];
        }

            break;
    }
    
}
- (void)configNaviItem {
    
    self.title = @"编辑装备信息";
    
    [self.completeItem sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.completeItem];
    
}
@end
