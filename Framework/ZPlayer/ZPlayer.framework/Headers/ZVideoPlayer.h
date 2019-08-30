//
//  ZVideoPlayer.h
//  DViewasd
//
//  Created by three stone 王 on 2019/8/7.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 创建
//- (ZVideoPlayer *)player {
//
//    if (!_player) {
//
//        _player = [ZVideoPlayer videoPlayerWithFrame:CGRectZero andDelegate:self];;
//    }
//    return _player;
//}
//self.player.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds) * 9 / 16);
//
//self.player.mediaURL = [NSURL URLWithString:@"https://vd4.bdstatic.com/mda-igdegujtg2v79rr9/sc/mda-igdegujtg2v79rr9.mp4?auth_key=1565246037-0-0-733399ffece3c8a9f6ef69fefe21e472&bcevod_channel=searchbox_feed&pd=bjh&abtest=all"];
//
//[self.player showInView:self.view andThumb:[UIImage imageNamed:@"颜色"] ];
//
//[self prefersStatusBarHidden];

// 在项目配置时 需要勾选除了 upside down
// vc 需要
//- (BOOL)prefersStatusBarHidden {
//
//    return true;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//
//    return UIInterfaceOrientationPortrait;
//}
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//
//    return self.player.canRotate ? UIInterfaceOrientationMaskAllButUpsideDown : UIInterfaceOrientationMaskPortrait;
//}
//- (BOOL)shouldAutorotate {
//
//    return self.player.canRotate;
//}

@class ZVideoPlayer;

@protocol ZVideoPlayerDelegate <NSObject>
// 更多按钮事件 代理
- (void)onVideoPlayer:(ZVideoPlayer *)player andMoreBtn:(UIButton *)moreBtn;
// 关闭按钮事件 代理
- (void)onVideoPlayer:(ZVideoPlayer *)player andCloseBtn:(UIButton *)closeBtn;

@end

@interface ZVideoPlayer : UIView
// 创建 video player 对象。 内部做了4g 能否播放的处理 、加载视频失败的处理 视频全屏 都处理好了

+ (instancetype)videoPlayerWithFrame:(CGRect)frame andDelegate:(id <ZVideoPlayerDelegate>) mdelegate;

// 视频链接
@property (nonatomic,strong) NSURL *mediaURL;
// 是否全屏
@property (nonatomic,assign ,readonly) BOOL isFullscreenModel;

// 展示在那个view上 占位图
- (void)showInView:(UIView *)view;
// 能否旋转
@property (nonatomic ,assign ,readonly) BOOL canRotate;

// 播放完成时 增加一个自定义view
- (void)addCustomViewForVideoEnd:(UIView *)someView;

- (void)play;

- (void)pause;

- (void)stop;

@end

NS_ASSUME_NONNULL_END
