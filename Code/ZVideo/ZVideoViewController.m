//
//  ZVideoViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZVideoViewController.h"
#import "ZCommentViewController.h"
//@import ZPlayer;
//@import SToolsKit;
//@import JXTAlertManager;
//@import ZBridge;
//@import ZNoti;
//@import ZSign;

#import "ZCommentViewController.h"

@interface ZVideoCommentViewController :ZCommentViewController

@end

@implementation ZVideoCommentViewController

- (BOOL)canPanResponse {
    return false;
}

@end
@interface ZVideoViewController () 

//@property (nonatomic ,strong) ZVideoPlayer *videoPlayer;
//
//@property (nonatomic ,strong) ZVideoCommentViewController *commentVC;
//
//@property (nonatomic ,strong) NSString *encode;
//
//@property (nonatomic ,strong) NSString *url;
//
//@property (nonatomic ,strong) ZCircleBean *circleBean;
//
//@property (nonatomic ,strong) ZContentBridge *bridge;
//
//@property (nonatomic ,copy) ZVideoOperation op;
@end

@implementation ZVideoViewController

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//
//    [self.navigationController setNavigationBarHidden:true];
//}
//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//
//    [self.navigationController setNavigationBarHidden:false animated:true];
//}
//+ (instancetype)createVideoWithEncode:(NSString *)encode andUrl:(NSString *)url andIsMy:(BOOL )isMy andCircleBean:(ZCircleBean *)circleBean andOp:(ZVideoOperation )op{
//
//    return [[self alloc] initWithEncode:encode andUrl:url andIsMy:isMy andCircleBean:circleBean andOp:op];
//}
//
//- (instancetype)initWithEncode:(NSString *)endcode andUrl:(NSString *)url andIsMy:(BOOL) isMy andCircleBean:(ZCircleBean *)circleBean andOp:(ZVideoOperation )op{
//
//    if (self = [super init]) {
//
//        self.encode = endcode;
//
//        self.url = url;
//
//        self.circleBean = circleBean;
//
//        self.op = op;
//    }
//    return self;
//}
//- (ZVideoPlayer *)videoPlayer {
//
//    if (!_videoPlayer) {
//
//        _videoPlayer = [ZVideoPlayer videoPlayerWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds) * 9 / 16) andDelegate:self];
//
//    }
//    return _videoPlayer;
//}
//- (ZCommentViewController *)commentVC {
//
//    if (!_commentVC) {
//
//        _commentVC = [ZVideoCommentViewController createCommentWithEncode:self.encode andOp:^{
//
//            self.op();
//        }];
//    }
//    return _commentVC;
//}
//-(void)addOwnSubViews {
//    [super addOwnSubViews];
//
//    [self.view addSubview:self.commentVC.view];
//
//    [self.view addSubview:self.videoPlayer];
//}
//- (void)configOwnSubViews {
//    [super configOwnSubViews];
//
//    [self.view addSubview:self.commentVC.view];
//
//    self.commentVC.tableView.frame = self.view.bounds;
//
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds) * 9 / 16)];
//
//    self.commentVC.tableView.tableHeaderView = headerView;
//    //
//    self.commentVC.tableView.mj_insetT = -KSTATUSBAR_HEIGHT;
//
//    [self addChildViewController:self.commentVC];
//
//}
//
//- (void)configViewModel {
//
//    self.bridge = [ZContentBridge new];
//
//    self.videoPlayer.mediaURL = [NSURL URLWithString:self.url];
//
//    [self.view addSubview:self.videoPlayer];
//
//    [self.videoPlayer showInView:self.view];
//
//    [self prefersStatusBarHidden];
//}
//- (void)onVideoPlayer:(nonnull ZVideoPlayer *)player andCloseBtn:(nonnull UIButton *)closeBtn {
//
//    [self.videoPlayer stop];
//
//    [self.navigationController popViewControllerAnimated:true];
//
//}
//
//- (void)onVideoPlayer:(nonnull ZVideoPlayer *)player andMoreBtn:(nonnull UIButton *)moreBtn {
//
//    __weak typeof(self) weakSelf = self;
//
//    [self jxt_showActionSheetWithTitle:@"操作" message:@"" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
//
//        alertMaker.
//        addActionCancelTitle(@"取消").
//        addActionDefaultTitle(@"举报").
//        addActionDefaultTitle(@"分享").
//        addActionDefaultTitle(weakSelf.circleBean.isattention ? @"取消关注" : @"关注").
//        addActionDestructiveTitle(@"黑名单(慎重选择)");
//
//    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
//
//        if ([action.title isEqualToString:@"取消"]) {
//
//
//        }
//        else if ([action.title isEqualToString:@"举报"]) {
//
//            [ZNotiConfigration postNotificationWithName:ZNotiCircleGotoReport andValue:weakSelf.circleBean andFrom:self];
//
//        } else if ([action.title isEqualToString:@"关注"] || [action.title isEqualToString:@"取消关注"]) {
//
//            [weakSelf.bridge focus:weakSelf.circleBean.users.encoded encode:weakSelf.circleBean.encoded isFocus:weakSelf.circleBean.isattention succ:^{
//
//                weakSelf.circleBean.isattention = !weakSelf.circleBean.isattention;
//
//                weakSelf.op();
//            }];
//
//
//        } else if ([action.title isEqualToString:@"黑名单(慎重选择)"]) {
//
//            [weakSelf.bridge addBlack:weakSelf.circleBean.users.encoded targetEncoded:weakSelf.circleBean.encoded content:@"" succ:^{
//
//                [weakSelf.navigationController popViewControllerAnimated:true];
//
//                [weakSelf.videoPlayer stop];
//
//                [ZNotiConfigration postNotificationWithName:ZNotiAddBlack andValue:nil andFrom:self];
//
//            }];
//
//        } else if ([action.title isEqualToString:@"分享"]) {
//
//            NSString *displayname = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
//
//            [ZNotiConfigration postNotificationWithName:ZNotiCircleShare andValue: @{@"webUrl": [NSString stringWithFormat:@"%@mob/circleFriends_wexCircleFriendsInfo?cfs.encoded=\(item.encoded)",[ZConfigure fetchAppKey]],@"title": displayname,@"desc":[NSString stringWithFormat:@"%@欢迎您",displayname]} andFrom:self];
//        }
//    }];
//}
//
//- (BOOL)prefersStatusBarHidden {
//
//    return true;
//}
//- (BOOL)shouldAutorotate {
//
//    return self.videoPlayer.canRotate;
//}
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//
//    return UIInterfaceOrientationPortrait;
//}
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//
//    return self.videoPlayer.canRotate ? UIInterfaceOrientationMaskAllButUpsideDown : UIInterfaceOrientationMaskPortrait;
//}
//- (BOOL)canPanResponse {
//
//    return true;
//}

@end
