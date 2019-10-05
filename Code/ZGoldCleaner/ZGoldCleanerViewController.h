//
//  ZGoldCleanerViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>
#import "ZFragmentConfig.h"
#import "ZFragmentMix.h"

NS_ASSUME_NONNULL_BEGIN

#if ZAppFormGlobalOne
@import ZBridge;
@interface ZGoldCleanerViewController : ZTableLoadingViewController

+ (instancetype)createGoldCleaner;

@property (nonatomic ,strong ,readonly) ZTListBridge *bridge;

@end

#elif ZAppFormGlobalTwo
@import ZBridge;
@interface ZGoldCleanerViewController : ZTableLoadingViewController

@property (nonatomic ,strong ,readonly) ZTListBridge *bridge;

+ (instancetype)createGoldCleaner;

@end

#endif

NS_ASSUME_NONNULL_END
