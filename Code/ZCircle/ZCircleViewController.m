//
//  ZCircleViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/17.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZCircleViewController.h"
#import "ZCircleTableViewCell.h"
@import SToolsKit;
@import JXTAlertManager;
@import ZSign;
@import ZCache;

@interface ZCircleViewController () <ZCircleTableViewCellDelegate>

@property (nonatomic ,strong ,readwrite) ZTListBridge *bridge;

@property (nonatomic ,assign) BOOL isMy;

@property (nonatomic ,strong) NSString *tag;

@property (nonatomic ,strong) ZCircleBlock block;
@end

@implementation ZCircleViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor]];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:false];
}
+ (instancetype)createCircleWithIsMy:(BOOL )isMy andTag:(NSString *)tag andBlock:(nonnull ZCircleBlock)block {
    
    return [[self alloc] initWithIsMy:isMy andTag:tag andBlock:block];
}

- (instancetype)initWithIsMy:(BOOL )isMy andTag:(NSString *)tag andBlock:(nonnull ZCircleBlock)block {
    
    if (self = [super init]) {
        
        self.isMy = isMy;
        
        self.tag = tag;
        
        self.block = block;
    }
    return self;
}
- (void)configOwnSubViews {
    
    [self.tableView registerClass:[ZCircleImageTableViewCell class] forCellReuseIdentifier:@"image"];
    
    
    [self.tableView registerClass:[ZCircleVideoTableViewCell class] forCellReuseIdentifier:@"video"];
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZCircleBean *circleBean = (ZCircleBean *)data;
    
    BOOL isVideo = false;
    
    for (ZKeyValueBean *keyValue in circleBean.contentMap) {
        
        if ([keyValue.type isEqualToString:@"video"]) {
            
            isVideo = true;
            
            break;
        }
    }
    
    if (isVideo) {
        
        ZCircleVideoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"video"];
        
        cell.circleBean = data;
        
        cell.bottomLineType = ZBottomLineTypeNormal;
        
        cell.mDelegate = self;
        
        return cell;
    } else {
        
        ZCircleImageTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"image"];
        
        cell.circleBean = data;
        
        cell.bottomLineType = ZBottomLineTypeNormal;
        
        cell.mDelegate = self;
        
        return cell;
    }
}

- (CGFloat)caculateForCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    return 120;
}

- (void)configViewModel {
    
    self.bridge = [ZTListBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createTList:self isMy:self.isMy tag:self.tag tAction:^(enum ZTListActionType type, ZTableLoadingViewController * _Nonnull from, ZCircleBean * _Nonnull circle, NSIndexPath * _Nonnull ip) {
        
        switch (type) {
            case ZTListActionTypeMyCircle:
                
                weakSelf.block(type, weakSelf, circle, ip);
                break;
            case ZTListActionTypeCircle:
                
                weakSelf.block(type, weakSelf, circle, ip);
                break;
                
            default:
                break;
        }
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)addBlack {
    
    [self.tableView.mj_header beginRefreshing];
}
- (void)onReloadItemClick {
    [super onReloadItemClick];
    
    [self.tableView.mj_header beginRefreshing];
}
- (BOOL)canPanResponse { return true; }

- (void)configNaviItem {
    
    if (self.isMy) {
        
        self.title = @"我的发布";
        
    } else {
        
        self.title = self.tag;
    }
}
- (void)onFuncItemClick:(ZFuncItemType)itemType forCircleBean:(ZCircleBean *)circleBean {
    
    __weak typeof(self) weakSelf = self;
    
    if (![[ZAccountCache shared] isLogin]) {
        
        self.block(ZTListActionTypeUnLogin, self, nil, nil);
        
        return;
    }
    
    if (itemType == ZFuncItemTypeFun) {
        
        [self jxt_showAlertWithTitle:circleBean.isLaud ? @"是否取消点赞" : @"是否点赞" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            
            alertMaker.
            addActionCancelTitle(@"取消").
            addActionDefaultTitle(circleBean.isLaud ? @"取消点赞" : @"点赞");
            
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            
            if ([action.title isEqualToString:@"取消"]) {
                
            }
            else if ([action.title isEqualToString:@"点赞"] || [action.title isEqualToString:@"取消点赞"]) {
                
                [weakSelf.bridge like:circleBean.encoded isLike:circleBean.isLaud action:^(enum ZTListActionType type, ZTableLoadingViewController * _Nonnull vc, ZCircleBean * _Nullable circle, NSIndexPath * _Nullable ip) {
                    
                    switch (type) {
                        case ZTListActionTypeUnLogin:
                            
                            weakSelf.block(type, weakSelf, nil, nil);
                            break;
                            
                        default:
                            break;
                    }
                }];
            }
            
        }];
    } else if (itemType == ZFuncItemTypeMore){
        
        [self jxt_showActionSheetWithTitle:@"" message:@"" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            
            alertMaker.
            addActionCancelTitle(@"取消").
            addActionDefaultTitle(@"举报").
            addActionDefaultTitle(circleBean.isattention ? @"取消关注" : @"关注").
            addActionDestructiveTitle(@"黑名单(慎重选择)");
            
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            
            if ([action.title isEqualToString:@"取消"]) {
                
            }
            else if ([action.title isEqualToString:@"举报"]) {
                
                self.block(ZTListActionTypeReport, self, circleBean,  [self.bridge fetchIp:circleBean]);
            } else if ([action.title isEqualToString:@"关注"] || [action.title isEqualToString:@"取消关注"]) {
                
                [weakSelf.bridge focus:circleBean.users.encoded encode:circleBean.encoded isFocus:circleBean.isattention action:^(enum ZTListActionType type, ZTableLoadingViewController * _Nonnull vc, ZCircleBean * _Nullable circle, NSIndexPath * _Nullable ip) {
                    
                    switch (type) {
                        case ZTListActionTypeUnLogin:
                            
                            weakSelf.block(type, weakSelf, nil, nil);
                            break;
                            
                        default:
                            break;
                    }
                }];
                
            } else if ([action.title isEqualToString:@"黑名单(慎重选择)"]) {
                
                [weakSelf.bridge addBlack:circleBean.users.encoded targetEncoded:circleBean.encoded content:@"" action:^(enum ZTListActionType type, ZTableLoadingViewController * _Nonnull vc, ZCircleBean * _Nullable circle, NSIndexPath * _Nullable ip) {
                    
                    switch (type) {
                        case ZTListActionTypeUnLogin:
                            
                            weakSelf.block(type, weakSelf, nil, nil);
                            break;
                        case ZTListActionTypeBlack:
                            
                            break;
                        default:
                            break;
                    }
                }];
                
            } else if ([action.title isEqualToString:@"分享"]) {
                
                self.block(ZTListActionTypeShare, self, circleBean,  [self.bridge fetchIp:circleBean]);
                
            }
        }];
    } else if (itemType == ZFuncItemTypeComment){
        
        self.block(ZTListActionTypeComment, self, circleBean, [self.bridge fetchIp:circleBean]);
        
    } else if (itemType == ZFuncItemTypeWatch){
        
        self.block(self.isMy ? ZTListActionTypeMyCircle : ZTListActionTypeCircle, self, circleBean, [self.bridge fetchIp:circleBean]);
    }
}

- (BOOL)prefersStatusBarHidden {
    
    return false;
}
- (void)updateCircle:(ZCircleBean *)circle {
    
    [self.bridge updateCircle:circle ip:[self.bridge fetchIp:circle]];
}
@end

