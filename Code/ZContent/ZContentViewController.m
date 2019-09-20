//
//  ZContentViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/20.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZContentViewController.h"
#import "ZContentTableViewCell.h"
#import "ZContentFuncItemView.h"
#import "ZContentHeaderView.h"
#import "ZCommentViewController.h"
@import ZBridge;
@import SToolsKit;
@import JXTAlertManager;
@import ZNoti;
@import ZSign;

@interface ZContentViewController () <ZContentFuncItemViewDelegate>

@property (nonatomic ,strong) ZContentBridge *bridge;

@property (nonatomic ,assign) BOOL isMy;

@property (nonatomic ,strong) ZContentFuncItemView *funcView;

@property (nonatomic ,strong) ZCircleBean *circleBean;

@property (nonatomic ,copy) ZContentOperation op;
@end

@implementation ZContentViewController

+ (instancetype)createContentWithCircleBean:(ZCircleBean *)circleBean andIsMy:(BOOL )isMy andOp:(ZContentOperation)op {
    
    return [[self alloc] initWithCircleBean:circleBean andIsMy:isMy andOp:op];
}
- (instancetype)initWithCircleBean:(ZCircleBean *)circleBean andIsMy:(BOOL)isMy andOp:(ZContentOperation) op{
    
    if (self = [super init]) {
        
        self.circleBean = circleBean;
        
        self.isMy = isMy;
        
        self.op = op;
    }
    return self;
    
}
- (ZContentFuncItemView *)funcView {
    
    if (!_funcView) {
        
        _funcView = [[ZContentFuncItemView alloc] initWithFrame:CGRectZero];
    }
    return _funcView;
}

- (void)addOwnSubViews {
    [super addOwnSubViews];
    
    [self.view addSubview:self.funcView];
    
}
- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[ZContentTextTableViewCell class] forCellReuseIdentifier:@"text"];
    
    [self.tableView registerClass:[ZContentImageTableViewCell class] forCellReuseIdentifier:@"image"];
    
    if (KISIPHONEX_UP) {
        
        self.funcView.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - 40 - 34, CGRectGetWidth(self.view.bounds), 40 + 34);
        
        self.tableView.mj_insetB = 34;
    } else {
        
        self.funcView.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - 40, CGRectGetWidth(self.view.bounds), 40);
    }
    
    [self.view bringSubviewToFront:self.funcView];
    
    self.funcView.mDelegate = self;
    
    ZContentHeaderView *headerView = [[ZContentHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 70)];
    
    self.headerView = headerView;
    
    self.tableView.tableHeaderView = self.headerView;
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZKeyValueBean *keyValue = (ZKeyValueBean *)data;
    
    if ([keyValue.type isEqualToString:@"txt"]) {
        
        ZContentTextTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"text"];
        
        cell.keyValue = data;
        
        return cell;
    } else {
        
        ZContentImageTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"image"];
        
        cell.keyValue = data;
        
        return cell;
    }
}

- (void)configViewModel {
    
    self.bridge = [ZContentBridge new];
    
    [self.funcView setCircleBean:self.circleBean];
    
    [self.bridge createContent:self circleBean:self.circleBean type:ZContentTypeMixed];
    
    ZContentHeaderView *headerView = (ZContentHeaderView *)self.headerView;
    
    [headerView setCircleBean:self.circleBean];
    
    [headerView.focusItem addTarget:self action:@selector(onFocusItemClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onFocusItemClick:(UIButton *)sender {
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge focus:self.circleBean.users.encoded encode:self.circleBean.encoded isFocus:self.circleBean.isattention succ:^{
        
        sender.selected = !sender.isSelected;
        
        weakSelf.circleBean.isattention = !weakSelf.circleBean.isattention;
    }];
}
- (void)configNaviItem {
    
    NSString *title = @"";
    
    for (ZKeyValueBean *json in self.circleBean.contentMap) {
        
        if ([json.type isEqualToString:@"title"]) {
            
            title = json.value;
            
            break;
        }
    }
    
    self.title = title;
}
- (CGFloat)caculateForCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZKeyValueBean *keyValue = (ZKeyValueBean *)data;
    
    if ([keyValue.type isEqualToString:@"txt"]) {
        
        CGFloat height = 0;
        
        CGFloat contnetHeight = [keyValue.value boundingRectWithSize:CGSizeMake(KSSCREEN_WIDTH - 30, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size.height;
        
        height += contnetHeight;
        
        height += 20;
        
        return height;
    } else {
        
        return (KSSCREEN_WIDTH - 30) / 2  + 10;
    }
}

- (void)onFuncItemClick:(ZContentFuncItemType)itemType {
    
    __weak typeof(self) weakSelf = self;
    
    if (itemType == ZContentFuncItemTypeFun) {
        
        [self jxt_showAlertWithTitle:self.circleBean.isLaud ? @"是否取消点赞" : @"是否点赞" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            
            alertMaker.
            addActionCancelTitle(@"取消").
            addActionDefaultTitle(weakSelf.circleBean.isLaud ? @"取消点赞" : @"点赞");
            
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            
            if ([action.title isEqualToString:@"取消"]) {
                
            }
            else if ([action.title isEqualToString:@"点赞"] || [action.title isEqualToString:@"取消点赞"]) {
                
                [weakSelf.bridge like:weakSelf.circleBean.encoded isLike:weakSelf.circleBean.isLaud succ:^{
                    
                    weakSelf.circleBean.isLaud = !weakSelf.circleBean.isLaud;
                    
                    if (weakSelf.circleBean.isLaud) {
                        
                        weakSelf.circleBean.countLaud += 1;
                        
                    } else {
                        
                        weakSelf.circleBean.countLaud -= 1;
                    }
                    
                    weakSelf.op();
                    
                    [weakSelf.funcView setCircleBean:weakSelf.circleBean];
                }];
            }
            
        }];
    } else if (itemType == ZContentFuncItemTypeMore){
        
        [self jxt_showActionSheetWithTitle:@"操作" message:@"" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            
            alertMaker.
            addActionCancelTitle(@"取消").
            addActionDefaultTitle(@"举报").
            addActionDefaultTitle(@"分享").
            addActionDefaultTitle(weakSelf.circleBean.isattention ? @"取消关注" : @"关注").
            addActionDestructiveTitle(@"黑名单(慎重选择)");
            
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            
            if ([action.title isEqualToString:@"取消"]) {
                
                
            }
            else if ([action.title isEqualToString:@"举报"]) {
                
                [ZNotiConfigration postNotificationWithName:ZNotiCircleGotoReport andValue:weakSelf.circleBean andFrom:self];
                
            } else if ([action.title isEqualToString:@"关注"] || [action.title isEqualToString:@"取消关注"]) {
                
                [weakSelf.bridge focus:weakSelf.circleBean.users.encoded encode:weakSelf.circleBean.encoded isFocus:weakSelf.circleBean.isattention succ:^{
                    
                    weakSelf.circleBean.isattention = !weakSelf.circleBean.isattention;
                    
                    ZContentHeaderView *headerView = (ZContentHeaderView *)weakSelf.headerView;
                    
                    [headerView setCircleBean:weakSelf.circleBean];
                    
                    weakSelf.op();
                }];
                
            } else if ([action.title isEqualToString:@"黑名单(慎重选择)"]) {
                
                [weakSelf.bridge addBlack:weakSelf.circleBean.users.encoded targetEncoded:weakSelf.circleBean.encoded content:@"" succ:^{
                    
                    [weakSelf.navigationController popViewControllerAnimated:true];
                    
                    [ZNotiConfigration postNotificationWithName:ZNotiAddBlack andValue:nil andFrom:self];
                    
                    weakSelf.op();
                }];
                
            } else if ([action.title isEqualToString:@"分享"]) {
                
                NSString *displayname = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
                
                [ZNotiConfigration postNotificationWithName:ZNotiCircleShare andValue: @{@"webUrl": [NSString stringWithFormat:@"%@mob/circleFriends_wexCircleFriendsInfo?cfs.encoded=\(item.encoded)",[ZConfigure fetchAppKey]],@"title": displayname,@"desc":[NSString stringWithFormat:@"%@欢迎您",displayname]} andFrom:self];
            }
        }];
    } else if (itemType == ZContentFuncItemTypeComment){
        
        ZCommentViewController *comment = [ZCommentViewController createCommentWithEncode:self.circleBean.encoded andOp:^{
            
            weakSelf.op();
        }];
        
        [self.navigationController pushViewController:comment animated:true];
    }
}

@end
