//
//  ZWelcomeViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/8/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//
@import ZCollection;
#import "ZFragmentConfig.h"
#import "ZFragmentMix.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^ZWelcomeSkipBlock)(ZBaseViewController *vc);
@interface ZWelcomeViewController : ZCollectionNoLoadingViewController

+ (instancetype)createWelcomeWithSkipBlock:(ZWelcomeSkipBlock )block;

@end

NS_ASSUME_NONNULL_END
