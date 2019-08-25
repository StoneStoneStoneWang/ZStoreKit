//
//  ZWelcomeViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/8/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//
@import ZCollection;
@import ZConfig;

NS_ASSUME_NONNULL_BEGIN


@protocol ZWelcomeConfig <NSObject>

@property (nonatomic ,copy) NSString *itemColor;

@property (nonatomic ,strong) NSArray *welcomeImgs;

@end

@interface ZWelcomeViewController : ZCollectionNoLoadingViewController

+ (instancetype)createWelcomeWithConfig:(id <ZWelcomeConfig>)config;

@end

NS_ASSUME_NONNULL_END
