//
//  ZLoadingViewController.h
//  TSUIKit
//
//  Created by three stone 王 on 2018/7/10.
//  Copyright © 2018年 three stone 王. All rights reserved.
//

#import <ZTransition/ZTViewController.h>
#import "ZLoadingView.h"
@interface ZLoadingViewController : ZTViewController

@property (nonatomic ,strong ,readonly) ZLoadingView *loadingView;

@property (nonatomic ,assign) LoadingStatus loadingStatus;

// 重新加载
- (void)onReloadItemClick;

@end
