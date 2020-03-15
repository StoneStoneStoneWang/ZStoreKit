//
//  ZEnrollsViewController.m
//  龙卷风竞技
//
//  Created by three stone 王 on 2020/3/12.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import "ZEnrollsViewController.h"
@import ZActionBridge;
@import SToolsKit;
@import Masonry;
@import SDWebImage;
@import ZCache;
@import ZNoti;

#import "ZFragmentConfig.h"
#import "ZEnrollViewController.h"
@interface ZEnrollsTableViewCell: ZBaseTableViewCell

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *charactersLabel;

@property (nonatomic ,strong) UILabel *time;

@property (nonatomic ,strong) UILabel *team;

@property (nonatomic ,strong) UILabel *equip;

@property (nonatomic ,strong) ZCircleBean *circleBean;

@end

@implementation ZEnrollsTableViewCell

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [UIImageView new];
        
        _iconImageView.layer.cornerRadius = 10;
        
        _iconImageView.layer.masksToBounds = true;
        
    }
    return _iconImageView;
}

- (UILabel *)charactersLabel {
    
    if (!_charactersLabel) {
        
        _charactersLabel = [UILabel new];
        
        _charactersLabel.textAlignment = NSTextAlignmentLeft;
        
        _charactersLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#666666"];
        
        _charactersLabel.font = [UIFont systemFontOfSize:15];
        
    }
    return _charactersLabel;
}

- (UILabel *)time {
    
    if (!_time) {
        
        _time = [UILabel new];
        
        _time.textAlignment = NSTextAlignmentRight;
        
        _time.textColor = [UIColor s_transformToColorByHexColorStr:@"#666666"];
        
        _time.font = [UIFont systemFontOfSize:15];
        
    }
    return _time;
}

- (UILabel *)team {
    
    if (!_team) {
        
        _team = [UILabel new];
        
        _team.textAlignment = NSTextAlignmentLeft;
        
        _team.textColor = [UIColor s_transformToColorByHexColorStr:@"#666666"];
        
        _team.font = [UIFont systemFontOfSize:15];
        
    }
    return _team;
}

- (UILabel *)equip {
    
    if (!_equip) {
        
        _equip = [UILabel new];
        
        _equip.textAlignment = NSTextAlignmentLeft;
        
        _equip.textColor = [UIColor s_transformToColorByHexColorStr:@"#666666"];
        
        _equip.font = [UIFont systemFontOfSize:15];
        
    }
    return _equip;
}


- (void)setCircleBean:(ZCircleBean *)circleBean {
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_200,h_200",circleBean.users.headImg]] placeholderImage:[UIImage imageNamed:@ZLogoIcon] options:SDWebImageRefreshCached];
    
    ZKeyValueBean *title = nil;
    
    ZKeyValueBean *team = nil;
    
    ZKeyValueBean *equip = nil;
    
    
    for (ZKeyValueBean *keyValue in circleBean.contentMap) {
        
        if ([keyValue.type isEqualToString:@"title"]) {
            
            title = keyValue;
            
            continue;
        }else if ([keyValue.type isEqualToString:@"txt"]) {
            
            if ([keyValue.value containsString:@"team="]) {
                
                team = keyValue;
            } else if ([keyValue.value containsString:@"equip="]) {
                
                equip = keyValue;
            }
        }
    }
    
    self.charactersLabel.text = title.value;
    
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
                
                self.equip.text = @"装备信息: T2*8";
            } else {
                
                if (t2 == 0) {
                    
                    self.equip.text = @"装备信息: T1*8";
                } else {
                    
                    self.equip.text = [NSString stringWithFormat:@"装备信息: T1*%d T2*%d",t1,t2];
                }
                
            }
        } else {
            
            if (t1 == 0) {
                
                self.equip.text = [NSString stringWithFormat:@"装备信息: T0*%d T2*%d",t0,t2];;
            } else {
                
                if (t2 == 0) {
                    
                    self.equip.text = [NSString stringWithFormat:@"装备信息: T0*%d T1*%d",t0,t1];
                } else {
                    
                    self.equip.text = [NSString stringWithFormat:@"装备信息: T0*%d T1*%d T2*%d",t0,t1,t2];
                }
                
            }
        }
    }
    
    if (team) {
        
        self.team.text = [NSString stringWithFormat:@"报名团队: %@",[team.value componentsSeparatedByString:@"="].lastObject];
    }
}
- (void)commitInit {
    [super commitInit];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.iconImageView];
    
    [self.contentView addSubview:self.charactersLabel];
    
    [self.contentView addSubview:self.time];
    
    [self.contentView addSubview:self.team];
    
    [self.contentView addSubview:self.equip];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(10);
        
        make.width.height.mas_equalTo(50);
    }];
    
    [self.charactersLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(15);
        
        make.centerY.mas_equalTo(self.iconImageView.mas_centerY);
    }];
    
    [self.equip mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(15);
        
        make.top.mas_equalTo(self.iconImageView.mas_bottom);
    }];
    
    [self.team mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(15);
        
        make.top.mas_equalTo(self.equip.mas_bottom).offset(10);
    }];
}
@end
@interface ZEnrollsViewController ()

@property (nonatomic ,strong) ZEnrollsBridge *bridge;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,strong) NSString *tag;

@property (nonatomic ,strong) NSString *sTitle;

@property (nonatomic ,assign) BOOL his;

@property (nonatomic ,copy) ZEnrollsActionBlock block;
@end

@implementation ZEnrollsViewController

+ (instancetype)createEnrolls:(NSString *)tag andTitle:(NSString *)title isHis:(BOOL )his andBlock:( ZEnrollsActionBlock)block {
    
    return [[self alloc] initWithEnrolls:tag andTitle:title isHis:his andBlock:block];
}
- (instancetype)initWithEnrolls:(NSString *)tag andTitle:(NSString *)title isHis:(BOOL )his andBlock:( ZEnrollsActionBlock)block{
    
    if (self = [super init]) {
        
        self.sTitle = title;
        
        self.title = title;
        
        self.tag = tag;
        
        self.his = his;
        
        self.block = block;
    }
    return self;
}

- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _completeItem.tag = 301;
        
        [_completeItem setBackgroundImage:[UIImage s_transformFromHexColor:@ZFragmentColor] forState:UIControlStateNormal];
        
        [_completeItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@ZFragmentColor]] forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@"报名" forState: UIControlStateNormal];
        
        [_completeItem setTitle:@"报名" forState: UIControlStateHighlighted];
        
        [_completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        _completeItem.layer.cornerRadius = 24;
        
        _completeItem.layer.masksToBounds = true;
        
        _completeItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _completeItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor]];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:false];
}

- (void)addOwnSubViews {
    [super addOwnSubViews];
    
    [self.view addSubview:self.completeItem];
    
}
- (void)configOwnSubViews {
    
    [self.tableView registerClass:[ZEnrollsTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.completeItem addTarget:self action:@selector(onCharactersAddTap) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onCharactersAddTap {
    
    
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZEnrollsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[ZEnrollsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.circleBean = data;
    
    return cell;
}
- (CGFloat)caculateForCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    return 120;
}

- (void)tableViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip  {
    
    
}

- (void)configViewModel {
    
    self.bridge = [ZEnrollsBridge new];
    // -1 失败  0 成功  1空
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createEnrolls:self tag:self.tag status:^(NSInteger status) {
        
        if (status == -1) {
            
            
        } else if (status == 0) {
            
            [weakSelf.view addSubview:weakSelf.completeItem];
            
            [weakSelf.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(20);
                
                make.right.bottom.mas_equalTo(-20);
                
                make.height.mas_equalTo(48);
            }];
            
            NSIndexPath *last = self.tableView.indexPathsForVisibleRows.lastObject;
            
            self.title = [NSString stringWithFormat:@"%@:%ld",self.sTitle,last.row + 1];
            
        } else if (status == 1) {
            
            UIView *emptyView = nil;
            
            for (UIView *aView in weakSelf.view.subviews) {
                
                if ([aView isKindOfClass:NSClassFromString(@"ZEmptyView")]) {
                    
                    emptyView = (UIView *)NSClassFromString(@"ZEmptyView");
                    
                    break;
                }
            }
            
            if (emptyView) {
                
                [weakSelf.view insertSubview:weakSelf.completeItem aboveSubview:emptyView];
            } else {
                
                [weakSelf.view addSubview:weakSelf.completeItem];
            }
            
            [weakSelf.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(20);
                
                make.right.bottom.mas_equalTo(-20);
                
                make.height.mas_equalTo(48);
            }];
        }
        
        if (weakSelf.his) {
            
            weakSelf.completeItem.hidden = true;
        }
    } enrollsAction:^(ZBaseViewController * _Nonnull vc) {
        
        if (![ZAccountCache shared].isLogin) {
            
            weakSelf.block(ZEnrollsActionTypeUnLogin ,vc);
            
        } else {
            
            __weak typeof(self) weakSelf = self;
            
            ZEnrollViewController *enroll = [ZEnrollViewController creatEnrollEditEditSucc:^(ZEnrollEditActionType type, ZBaseViewController * _Nonnull from, ZCircleBean * _Nullable cirlce) {
                
                switch (type) {
                    case ZEnrollEditActionTypeCompleted:
                    {
                        [weakSelf.bridge insertEnrolls:cirlce status:^(NSInteger status) {
                            
                        }];
                        
                        [from.navigationController popViewControllerAnimated:true];
                    }
                        break;
                    case ZEnrollEditActionTypeCharacterSelected:
                    {
                        weakSelf.block(ZEnrollsActionTypeCharacerSelected, from);
                        
                    }
                        break;
                    default:
                        break;
                }
                
            } andTag:self.tag];
            
            [self.navigationController pushViewController:enroll animated:true];
        }
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)onReloadItemClick {
    [super onReloadItemClick];
    
    [self.tableView.mj_header beginRefreshing];
}

- (BOOL)canPanResponse { return true; }

- (void)configNaviItem {
    
    
}

- (BOOL)prefersStatusBarHidden {
    
    return false;
}


@end
