//
//  ZLoadingView.h
//  TSUIKit
//
//  Created by three stone 王 on 2018/7/10.
//  Copyright © 2018年 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZTransiton/ZTViewController.h>

typedef NS_ENUM(NSInteger,LoadingStatus) {
    
    LoadingStatusBegin,
    
    LoadingStatusWebViewLoading,
    
    LoadingStatusLoading,
    
    LoadingStatusSucc,
    
    LoadingStatusFail,
    
    LoadingStatusReload
};

@protocol ZLoadingViewDelegate <NSObject>

- (void)onReloadItemClick;

@end

@interface ZLoadingView : UIView

+ (instancetype)loadingWithContentViewController:(ZTViewController *)contentViewController;

/*
 设置加载状态
 LoadingStatusBegin 请在viewwillappear里
 LoadingStatusLoading 请在设置begin之后 viewwillappear里
 LoadingStatusSucc 加载成功
 LoadingStatusFail 加载失败
 LoadingStatusReload 重新加载 屏幕上有 点击屏幕重新加载按钮
 */
@property (nonatomic ,assign ,readonly) BOOL isLoading;

@property (nonatomic ,assign)LoadingStatus status;

- (void)changeLoadingStatus:(LoadingStatus )status;

@property (nonatomic ,weak) id<ZLoadingViewDelegate> mDelegate;

- (void)setURLCannotOpenforText:(NSString *)text andLogo:(NSString *)logo;

- (void)setDataEmptyforText:(NSString *)text andLogo:(NSString *)logo;


@end
