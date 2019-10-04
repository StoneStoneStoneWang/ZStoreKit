//
//  ZCircleViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/17.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZCircleViewController.h"
#import "ZCircleTableViewCell.h"
@import ZBridge;
@import SToolsKit;
@import JXTAlertManager;
@import ZNoti;
@import ZSign;

@interface ZCircleViewController () <ZCircleTableViewCellDelegate>

@property (nonatomic ,strong) ZTListBridge *bridge;

@property (nonatomic ,assign) BOOL isMy;

@property (nonatomic ,strong) NSString *tag;

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
+ (instancetype)createTableList:(BOOL )isMy andTag:(NSString *)tag {
    
    return [[self alloc] initWithTableList:isMy andTag:tag];
}

- (instancetype)initWithTableList:(BOOL )isMy andTag:(NSString *)tag {
    
    if (self = [super init]) {
        
        self.isMy = isMy;
        
        self.tag = tag;
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
    
    [self.bridge createTList:self isMy:self.isMy tag:self.tag];
    
    [self.tableView.mj_header beginRefreshing];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addBlack) name:ZNotiAddBlack object:nil];
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
    
    if (itemType == ZFuncItemTypeFun) {
        
        [self jxt_showAlertWithTitle:circleBean.isLaud ? @"是否取消点赞" : @"是否点赞" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            
            alertMaker.
            addActionCancelTitle(@"取消").
            addActionDefaultTitle(circleBean.isLaud ? @"取消点赞" : @"点赞");
            
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            
            if ([action.title isEqualToString:@"取消"]) {
                
            }
            else if ([action.title isEqualToString:@"点赞"] || [action.title isEqualToString:@"取消点赞"]) {
                
                [weakSelf.bridge like:circleBean.encoded isLike:circleBean.isLaud succ:^{
                    
                    
                }];
            }
            
        }];
    } else if (itemType == ZFuncItemTypeMore){
        
        [self jxt_showActionSheetWithTitle:@"操作" message:@"" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            
            alertMaker.
            addActionCancelTitle(@"取消").
            addActionDefaultTitle(@"举报").
            addActionDefaultTitle(@"分享").
            addActionDefaultTitle(circleBean.isattention ? @"取消关注" : @"关注").
            addActionDestructiveTitle(@"黑名单(慎重选择)");
            
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            
            if ([action.title isEqualToString:@"取消"]) {
                
            }
            else if ([action.title isEqualToString:@"举报"]) {
                
                [ZNotiConfigration postNotificationWithName:ZNotiCircleGotoReport andValue:circleBean andFrom:self];
                
            } else if ([action.title isEqualToString:@"关注"] || [action.title isEqualToString:@"取消关注"]) {
                
                [self.bridge focus:circleBean.users.encoded encode:circleBean.encoded isFocus:circleBean.isattention succ:^{
                    
                    
                }];
                
            } else if ([action.title isEqualToString:@"黑名单(慎重选择)"]) {
                
                [self.bridge addBlack:circleBean.users.encoded targetEncoded:circleBean.encoded content:@"" succ:^{
                    
                }];
                
            } else if ([action.title isEqualToString:@"分享"]) {
                
                NSString *displayname = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
                
                [ZNotiConfigration postNotificationWithName:ZNotiCircleShare andValue: @{@"webUrl": [NSString stringWithFormat:@"%@mob/circleFriends_wexCircleFriendsInfo?cfs.encoded=\(item.encoded)",[ZConfigure fetchAppKey]],@"title": displayname,@"desc":[NSString stringWithFormat:@"%@欢迎您",displayname]} andFrom:self];
            }
        }];
    } else if (itemType == ZFuncItemTypeComment){
        
        [ZNotiConfigration postNotificationWithName:ZNotiCircleItemClick andValue:circleBean andFrom:self];
        
    } else if (itemType == ZFuncItemTypeWatch){
        
        [ZNotiConfigration postNotificationWithName:ZNotiCircleItemClick andValue:circleBean andFrom:self];
    }
}

- (BOOL)prefersStatusBarHidden {
    
    return false;
}

@end

