//
//  ZVideoViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZVideoViewController.h"
#import "ZCommentViewController.h"
@import ZPlayer;
@import SToolsKit;
#import "ZCommentViewController.h"

@interface ZVideoViewController () <ZVideoPlayerDelegate>

@property (nonatomic ,strong) ZVideoPlayer *videoPlayer;

@property (nonatomic ,strong) ZCommentViewController *commentVC;

@property (nonatomic ,strong) NSString *encode;
@end

@implementation ZVideoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor]];
    
}

+ (instancetype)createVideoWithEncode:(NSString *)encode {
    
    return [[self alloc] initWithEncode:encode];
}
- (instancetype)initWithEncode:(NSString *)endcode {
    
    if (self = [super init]) {
        
        self.encode = endcode;
    }
    return self;
}
- (ZVideoPlayer *)videoPlayer {
    
    if (!_videoPlayer) {
        
        _videoPlayer = [ZVideoPlayer videoPlayerWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds) * 16 / 9) andDelegate:self];
    }
    return _videoPlayer;
}
- (ZCommentViewController *)commentVC {
    
    if (!_commentVC) {
        
        _commentVC = [ZCommentViewController createCommentWithEncode:self.encode];
    }
    return _commentVC;
}
-(void)addOwnSubViews {
    [super addOwnSubViews];
    
    [self.view addSubview:self.commentVC.view];
    
}
- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.view addSubview:self.commentVC.tableView];
    
    self.commentVC.tableView.frame = self.view.bounds;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds) * 16 / 9)];
    
    self.commentVC.tableView.tableHeaderView = headerView;
    
}
- (void)addOwnSubViewController {
    [super addOwnSubViewController];
    
    [self addChildViewController:self.commentVC];
}

- (void)configViewModel {
    
    [self.view addSubview:self.videoPlayer];
    
    [self.videoPlayer showInView:self.view];
}
- (void)onVideoPlayer:(nonnull ZVideoPlayer *)player andCloseBtn:(nonnull UIButton *)closeBtn {
    
    
}

- (void)onVideoPlayer:(nonnull ZVideoPlayer *)player andMoreBtn:(nonnull UIButton *)moreBtn {
    
    
}


@end
