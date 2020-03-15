//
//  ZEnrollViewController.m
//  龙卷风竞技
//
//  Created by three stone 王 on 2020/3/12.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import "ZEnrollViewController.h"
@import SToolsKit;
@import ZActionBridge;
@import Masonry;
@import JXTAlertManager;
@import ZTField;

@interface ZEnrollEditTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) WLBaseTextField *subTitleLabel;

@end


@implementation ZEnrollEditTableViewCell

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
- (void)setEnrollBean:(ZEnrollBean *)enrollBean {

    self.titleLabel.text = enrollBean.title;
    
    self.bottomLineType = ZBottomLineTypeNormal;
    
    self.subTitleLabel.text = enrollBean.subtitle;
    
    self.subTitleLabel.placeholder = enrollBean.placeholder;
    
    self.subTitleLabel.userInteractionEnabled = false;
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (enrollBean.type == ZEnrollTypeCharacter) {
        
        if (![enrollBean.subtitle isEqualToString:@""]) {
            
            NSData *data = [enrollBean.subtitle dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            NSString *contentString = json[@"content"];
            
            NSArray *contentJson = [NSJSONSerialization JSONObjectWithData:[contentString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            
            for (NSDictionary *j in contentJson) {
                
                if ([j[@"type"] isEqualToString:@"title"]) {
                    
                    self.subTitleLabel.text = j[@"value"];
                }
            }
            
            NSLog(@"%@",contentJson);
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

@interface ZEnrollViewController ()

@property (nonatomic ,copy) ZEnrollCharacterSelectedBlock block;

@property (nonatomic ,strong) ZEnrollBridge *bridge;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,copy) NSString *tag;
@end

@implementation ZEnrollViewController

+ (instancetype)creatEnrollEditEditSucc:(ZEnrollCharacterSelectedBlock) action andTag:(NSString *)tag {
    
    return [[self alloc] initWithEnrollEditEditSucc:action andTag:tag];
}
- (instancetype)initWithEnrollEditEditSucc:(ZEnrollCharacterSelectedBlock)action andTag:(NSString *)tag {
    
    if (self = [super init]) {
        
        self.block = action;
        
        self.tag = tag;
    }
    return self;
}

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


- (void)configOwnSubViews {
    
    [self.tableView registerClass:[ZEnrollEditTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZEnrollEditTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[ZEnrollEditTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.enrollBean = data;
    
    return cell;
    
}
- (void)updateCharacters:(ZCircleBean *)circle {
    
    [self.bridge updateCharactersEditWithType:ZEnrollTypeCharacter value:[self.bridge converToJsonString:circle]];
    
}
- (void)tableViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZEnrollBean *edit = (ZEnrollBean *)data;
    
    switch (edit.type) {
        case ZEnrollTypeCharacter:
        {
            
            self.block(ZEnrollEditActionTypeCharacterSelected, self, nil);

        }
            break;
            
        case ZEnrollTypeTeam:
        {
            
            __weak typeof(self) weakSelf = self;
            
            [self jxt_showActionSheetWithTitle:@"报名团队" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                
                alertMaker.
                addActionCancelTitle(@"取消").
                addActionDefaultTitle(@"一团").
                addActionDefaultTitle(@"二团").
                addActionDefaultTitle(@"三团");
            } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                
                if ([action.title isEqualToString:@"取消"]) {
                    
                } else if ([action.title isEqualToString:@"一团"]) {
                    
                    
                    [weakSelf.bridge updateCharactersEditWithType:ZEnrollTypeTeam value:@"一团"];
                } else if ([action.title isEqualToString:@"二团"]) {
                    
                    [weakSelf.bridge updateCharactersEditWithType:ZEnrollTypeTeam value:@"二团"];
                } else if ([action.title isEqualToString:@"三团"]) {
                    
                    [weakSelf.bridge updateCharactersEditWithType:ZEnrollTypeTeam value:@"三团"];
                }
            }];
        }
            break;
        default:
            break;
    }
    
}
- (void)configNaviItem {
    
    self.title = @"活动报名";
    
    [self.completeItem sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.completeItem];
    
}
- (void)configViewModel {
    
    self.bridge = [ZEnrollBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createEnrollEdit:self tag:self.tag action:^(ZEnrollEditActionType type,ZCircleBean * _Nullable circle) {
        
        weakSelf.block(ZEnrollEditActionTypeCompleted, weakSelf, circle);
    }];
}

@end
