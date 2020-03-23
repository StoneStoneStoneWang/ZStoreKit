//
//  ZVideoViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZVideoViewController.h"
@import ZPlayer;
@import SToolsKit;
@import ZBombBridge;
@import JXTAlertManager;

@interface ZVideoViewController () <ZVideoPlayerDelegate>

@property (nonatomic ,strong) ZVideoPlayer *videoPlayer;

@property (nonatomic ,strong) NSString *encode;

@property (nonatomic ,strong) NSString *url;

@property (nonatomic ,strong) ZCircleBean *circleBean;

@property (nonatomic ,copy) ZVideoActionBlock videoBlock;

@property (nonatomic ,strong) ZVideoBridge *bridge;

@property (nonatomic ,strong) NSIndexPath *ip;
@end

@implementation ZVideoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:true];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:false animated:true];
}
+ (instancetype)createVideoWithEncode:(NSString *)encode andUrl:(NSString *)url andIsMy:(BOOL )isMy andCircleBean:(ZCircleBean *)circleBean andIp:(NSIndexPath *)ip andVideoBlock:(nonnull ZVideoActionBlock)videoBlock {
    
    return [[self alloc] initWithEncode:encode andUrl:url andIsMy:isMy andCircleBean:circleBean andIp:ip andVideoBlock:videoBlock];
}

- (instancetype)initWithEncode:(NSString *)encode andUrl:(NSString *)url andIsMy:(BOOL )isMy andCircleBean:(ZCircleBean *)circleBean andIp:(NSIndexPath *)ip andVideoBlock:(nonnull ZVideoActionBlock)videoBlock{
    
    if (self = [super init]) {
        
        self.encode = encode;
        
        self.url = url;
        
        self.circleBean = circleBean;
        
        self.ip = ip;
        
        self.videoBlock = videoBlock;
    }
    return self;
}
- (ZVideoPlayer *)videoPlayer {
    
    if (!_videoPlayer) {
        
        _videoPlayer = [ZVideoPlayer videoPlayerWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds) * 9 / 16) andDelegate:self];
        
    }
    return _videoPlayer;
}

-(void)addOwnSubViews {
    [super addOwnSubViews];
    
    [self.view addSubview:self.videoPlayer];
}
- (void)configOwnSubViews {
    [super configOwnSubViews];
    
}
//http://vf1.mtime.cn/Video/2012/04/23/mp4/120423212602431929.mp4
- (void)configViewModel {
    
    self.videoPlayer.mediaURL = [NSURL URLWithString:self.url];
    
    [self.view addSubview:self.videoPlayer];
    
    [self.videoPlayer showInView:self.view];
    
    [self prefersStatusBarHidden];
    
    self.bridge = [ZVideoBridge new];
}
- (void)onVideoPlayer:(nonnull ZVideoPlayer *)player andCloseBtn:(nonnull UIButton *)closeBtn {
    
    [self.videoPlayer stop];
    
    [self.navigationController popViewControllerAnimated:true];
    
}

- (void)onVideoPlayer:(nonnull ZVideoPlayer *)player andMoreBtn:(nonnull UIButton *)moreBtn {
    
    __weak typeof(self) weakSelf = self;
    
    [self jxt_showActionSheetWithTitle:@"操作" message:@"" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        
        alertMaker.
        addActionCancelTitle(@"取消").
        addActionDefaultTitle(@"举报").
        addActionDestructiveTitle(@"黑名单(慎重选择)");
        
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        
        if ([action.title isEqualToString:@"取消"]) {
            
            
        }
        else if ([action.title isEqualToString:@"举报"]) {
            
            weakSelf.videoBlock(ZVideoActionTypeReport, weakSelf, weakSelf.circleBean, weakSelf.ip);
        } else if ([action.title isEqualToString:@"黑名单(慎重选择)"]) {
            
            [weakSelf.bridge addBlack:weakSelf.circleBean.users.encoded targetEncoded:weakSelf.circleBean.encoded content:@"" action:^(enum ZVideoActionType type, ZTViewController * _Nonnull vc) {
               
                weakSelf.videoBlock(ZVideoActionTypeBlack, weakSelf, weakSelf.circleBean, weakSelf.ip);
                
            }];
            
        } else if ([action.title isEqualToString:@"分享"]) {
            
            
        }
    }];
}

- (BOOL)prefersStatusBarHidden {
    
    return true;
}
- (BOOL)shouldAutorotate {
    
    return self.videoPlayer.canRotate;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return UIInterfaceOrientationPortrait;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return self.videoPlayer.canRotate ? UIInterfaceOrientationMaskAllButUpsideDown : UIInterfaceOrientationMaskPortrait;
}
- (BOOL)canPanResponse {
    
    return true;
}

@end
