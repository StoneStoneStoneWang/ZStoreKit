//
//  ZCharactersViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2020/3/9.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import "ZCharactersViewController.h"
@import SToolsKit;
#import "ZCharactersTableViewCell.h"
#import "ZCharactersEditViewController.h"
@import ZBridge;
@import Masonry;
@import ZNoti;

@interface ZCharactersViewController ()

@property (nonatomic ,strong) ZCharactersBridge *bridge;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,assign) BOOL isSelected;

@property (nonatomic ,copy) ZCharactersIsSelectedBlock block;
@end

@implementation ZCharactersViewController

- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _completeItem.tag = 301;
        
        [_completeItem setBackgroundImage:[UIImage s_transformFromHexColor:@ZFragmentColor] forState:UIControlStateNormal];
        
        [_completeItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@ZFragmentColor]] forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@"增加角色" forState: UIControlStateNormal];
        
        [_completeItem setTitle:@"增加角色" forState: UIControlStateHighlighted];
        
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
+ (instancetype)createCharacters:(BOOL )isSelected andBlock:(ZCharactersIsSelectedBlock )block {
    
    return [[self alloc] initWithIsSelected:isSelected andBlock:block];
}
- (instancetype)initWithIsSelected:(BOOL )isSelected andBlock:(ZCharactersIsSelectedBlock )block{
    
    if (self = [super init]) {
        
        self.isSelected = isSelected;
        
        self.block = block;
    }
    return self;
}
- (void)addOwnSubViews {
    [super addOwnSubViews];
    
    [self.view addSubview:self.completeItem];
    
}
- (void)configOwnSubViews {
    
    [self.tableView registerClass:[ZCharactersTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCharactersAddTap) name:ZNotiCharacterAddClick object:nil ];
}


- (void)onCharactersAddTap {
    
    __weak typeof(self) weakSelf = self;
    
    ZCharactersEditViewController *edit = [ZCharactersEditViewController creatCharactersEdit:nil andEditSucc:^(ZCircleBean * _Nonnull circle) {
        
        [weakSelf.bridge insertCharacters:circle status:^(NSInteger status) {
            
            
        }];
    }];
    
    [self.navigationController pushViewController:edit animated:true];
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZCharactersTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[ZCharactersTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.characters = data;
    
    return cell;
}
- (void)tableViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip  {
    
    __weak typeof(self) weakSelf = self;
    
    if (self.isSelected) {
        
        self.block(data);
    } else {
        
        ZCharactersEditViewController *edit = [ZCharactersEditViewController creatCharactersEdit:data andEditSucc:^(ZCircleBean * _Nonnull circle) {
            
            [weakSelf.bridge updateCharacters:circle ip:ip];
            
        }];
        
        [self.navigationController pushViewController:edit animated:true];
    }
    
    
}

- (CGFloat)caculateForCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    return 120;
}

- (void)configViewModel {
    
    self.bridge = [ZCharactersBridge new];
    // -1 失败  0 成功  1空
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createCharacters:self status:^(NSInteger status) {
        
        if (status == -1) {
            
            
        } else if (status == 0) {
            
            [weakSelf.view addSubview:weakSelf.completeItem];
            
            [weakSelf.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(20);
                
                make.right.bottom.mas_equalTo(-20);
                
                make.height.mas_equalTo(48);
            }];
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
    } accessoryBlock:^(NSIndexPath * _Nonnull ip, ZCircleBean * _Nonnull circle) {
       
        __weak typeof(self) weakSelf = self;
        
        ZCharactersEditViewController *edit = [ZCharactersEditViewController creatCharactersEdit:circle andEditSucc:^(ZCircleBean * _Nonnull result) {
            
            [weakSelf.bridge updateCharacters:result ip:ip];
        
        }];
        
        [self.navigationController pushViewController:edit animated:true];
    }];

    [self.tableView.mj_header beginRefreshing];
}

- (void)onReloadItemClick {
    [super onReloadItemClick];
    
    [self.tableView.mj_header beginRefreshing];
}

- (BOOL)canPanResponse { return true; }

- (void)configNaviItem {
    
    self.title = self.isSelected ? @"选择角色" : @"我的角色";
}

- (BOOL)prefersStatusBarHidden {
    
    return false;
}

@end
