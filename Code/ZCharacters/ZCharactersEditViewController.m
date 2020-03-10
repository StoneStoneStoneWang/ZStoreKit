//
//  ZCharactersEditViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2020/3/9.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import "ZCharactersEditViewController.h"
#import "ZCharacterNameViewController.h"
#import "ZEquipViewController.h"
@import SToolsKit;
@import ZBridge;
@import Masonry;
@import JXTAlertManager;
@import ZTField;

@interface ZCharactersEditTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) WLBaseTextField *subTitleLabel;

@property (nonatomic ,strong) ZCharactersEditBean *characterEdit;

@end


@implementation ZCharactersEditTableViewCell

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

- (void)setCharacterEdit:(ZCharactersEditBean *)characterEdit {
    
    self.titleLabel.text = characterEdit.title;
    
    self.bottomLineType = ZBottomLineTypeNormal;
    
    self.subTitleLabel.text = characterEdit.subtitle;
    
    self.subTitleLabel.placeholder = characterEdit.placeholder;
    
    self.subTitleLabel.userInteractionEnabled = false;
    
    switch (characterEdit.type) {
        case ZCharactersEditTypeSpace:
            
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
    
    if (characterEdit.type == ZCharactersEditTypeEquip) {
        
        if (![characterEdit.subtitle isEqualToString:@""]) {
            
            NSString *temp = [characterEdit.subtitle componentsSeparatedByString:@"="].lastObject;
            
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
                    
                    self.subTitleLabel.text = @"T2*8";
                } else {
                    
                    if (t2 == 0) {
                        
                        self.subTitleLabel.text = @"T1*8";
                    } else {
                        
                        self.subTitleLabel.text = [NSString stringWithFormat:@"T1*%d T2*%d",t1,t2];
                    }

                }
            } else {
                
                if (t1 == 0) {
                    
                    self.subTitleLabel.text = [NSString stringWithFormat:@"T0*%d T2*%d",t0,t2];;
                } else {
                    
                    if (t2 == 0) {
                        
                        self.subTitleLabel.text = [NSString stringWithFormat:@"T0*%d T1*%d",t0,t1];
                    } else {
                        
                        self.subTitleLabel.text = [NSString stringWithFormat:@"T0*%d T1*%d T2*%d",t0,t1,t2];
                    }
                    
                }
            }
            
            
        }
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
@interface ZCharactersEditViewController ()

@property (nonatomic ,strong) ZCharactersEditBridge *bridge;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,strong) ZCircleBean *characters;

@property (nonatomic ,strong) ZCharactersEditBlock edit;

@end


@implementation ZCharactersEditViewController

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

+ (instancetype)creatCharactersEdit:(nullable ZCircleBean *)circle andEditSucc:(nonnull ZCharactersEditBlock)succ {
    
    return [[self alloc] initWithCircle:circle andEditSucc:succ];
}
- (instancetype)initWithCircle:(ZCircleBean *)circle andEditSucc:(nonnull ZCharactersEditBlock)succ{
    
    if (self = [super init]) {
        
        self.characters = circle;
        
        self.edit = succ;
        
    }
    return self;
}
- (void)configOwnSubViews {
    
    [self.tableView registerClass:[ZCharactersEditTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZCharactersEditTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[ZCharactersEditTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.characterEdit = data;
    
    return cell;
    
}
- (void)tableViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZCharactersEditBean *edit = (ZCharactersEditBean *)data;
    
    switch (edit.type) {
        case ZCharactersEditTypeSex: {
            
            __weak typeof(self) weakSelf = self;
            
            [self jxt_showActionSheetWithTitle:@"角色性别选择" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                
                alertMaker.
                addActionCancelTitle(@"取消").
                addActionDefaultTitle(@"男").
                addActionDefaultTitle(@"女");
                
            } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                
                if ([action.title isEqualToString:@"取消"]) {
                    
                } else if ([action.title isEqualToString:@"男"]) {
                    
                    [weakSelf.bridge updateCharactersEditWithType:ZCharactersEditTypeSex value:@"男"];
                } else if ([action.title isEqualToString:@"女"]) {
                    
                    [weakSelf.bridge updateCharactersEditWithType:ZCharactersEditTypeSex value:@"女"];
                }
            }];
        }
            break;
        case ZCharactersEditTypeName:
        {
            __weak typeof(self) weakSelf = self;
            
            ZCharacterNameViewController *name = [ZCharacterNameViewController createCharacterName:edit.subtitle andBlock:^(NSString * _Nonnull nameVale) {
                
                [weakSelf.bridge updateCharactersEditWithType:ZCharactersEditTypeName value:nameVale];
            }];
            
            [self presentViewController:[[ZTNavigationController alloc] initWithRootViewController:name] animated:true completion:nil];
        }
            break;
        case ZCharactersEditTypeEquip:
        {
            __weak typeof(self) weakSelf = self;
            
            ZEquipViewController *equip = [ZEquipViewController createEquip: edit.subtitle andBlock:^(NSString * _Nonnull equipsVale) {
                
                [weakSelf.bridge updateCharactersEditWithType:ZCharactersEditTypeEquip value:equipsVale];
            }];
            
            [self.navigationController pushViewController:equip animated:true];
        }
            break;
        case ZCharactersEditTypeCharacter:
        {
            __weak typeof(self) weakSelf = self;
            
            [self jxt_showActionSheetWithTitle:@"请选择种族" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                
                alertMaker.
                addActionCancelTitle(@"取消").
                addActionDefaultTitle(@"亡灵").
                addActionDefaultTitle(@"牛头人").
                addActionDefaultTitle(@"兽人").
                addActionDefaultTitle(@"巨魔");
                
            } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                
                if ([action.title isEqualToString:@"取消"]) {
                    
                } else if ([action.title isEqualToString:@"亡灵"]) {
                    
                    [weakSelf jxt_showActionSheetWithTitle:@"请选择职业" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                        
                        alertMaker.
                        addActionCancelTitle(@"取消").
                        addActionDefaultTitle(@"法师").
                        addActionDefaultTitle(@"术士").
                        addActionDefaultTitle(@"盗贼").
                        addActionDefaultTitle(@"战士").
                        addActionDefaultTitle(@"牧师");
                        
                    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                        
                        if ([action.title isEqualToString:@"取消"]) {
                            
                        } else {
                            
                            [weakSelf.bridge updateCharactersEditWithType:ZCharactersEditTypeCharacter value:[NSString stringWithFormat:@"亡灵&%@",action.title]];
                        }
                        
                    }];
                    
                    
                } else if ([action.title isEqualToString:@"牛头人"]) {
                    
                    [weakSelf jxt_showActionSheetWithTitle:@"请选择职业" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                        
                        alertMaker.
                        addActionCancelTitle(@"取消").
                        addActionDefaultTitle(@"盗贼").
                        addActionDefaultTitle(@"战士").
                        addActionDefaultTitle(@"德鲁伊").
                        addActionDefaultTitle(@"萨满").
                        addActionDefaultTitle(@"猎人");
                        
                    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                        
                        if ([action.title isEqualToString:@"取消"]) {
                            
                        } else {
                            
                            [weakSelf.bridge updateCharactersEditWithType:ZCharactersEditTypeCharacter value:[NSString stringWithFormat:@"牛头人&%@",action.title]];
                        }
                        
                    }];

                } else if ([action.title isEqualToString:@"兽人"]) {
                    
                    [weakSelf jxt_showActionSheetWithTitle:@"请选择职业" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                        
                        alertMaker.
                        addActionCancelTitle(@"取消").
                        addActionDefaultTitle(@"盗贼").
                        addActionDefaultTitle(@"战士").
                        addActionDefaultTitle(@"萨满").
                        addActionDefaultTitle(@"猎人");
                        
                    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                        
                        if ([action.title isEqualToString:@"取消"]) {
                            
                        } else {
                            
                            [weakSelf.bridge updateCharactersEditWithType:ZCharactersEditTypeCharacter value:[NSString stringWithFormat:@"兽人&%@",action.title]];
                        }
                        
                    }];
                } else if ([action.title isEqualToString:@"巨魔"]) {
                    
                    [weakSelf jxt_showActionSheetWithTitle:@"请选择职业" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                        
                        alertMaker.
                        addActionCancelTitle(@"取消").
                        addActionDefaultTitle(@"法师").
                        addActionDefaultTitle(@"战士").
                        addActionDefaultTitle(@"牧师").
                        addActionDefaultTitle(@"猎人");
                        
                    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                        
                        if ([action.title isEqualToString:@"取消"]) {
                            
                        } else {
                            
                            [weakSelf.bridge updateCharactersEditWithType:ZCharactersEditTypeCharacter value:[NSString stringWithFormat:@"巨魔&%@",action.title]];
                        }
                        
                    }];
                }
            
            }];
            
            
        }
            break;

        default:
            break;
    }
}
- (void)configNaviItem {
    
    self.title = self.characters ? @"编辑角色" : @"新增角色";
    
    [self.completeItem sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.completeItem];
    
}
- (void)configViewModel {
    
    self.bridge = [ZCharactersEditBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createCharactersEdit:self temp:self.characters succ:^(ZCircleBean * _Nullable character) {
        
        weakSelf.edit(character);
        
        [weakSelf.navigationController popViewControllerAnimated:true];
    }];
}

@end
