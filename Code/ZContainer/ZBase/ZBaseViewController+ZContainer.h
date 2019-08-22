//
//  ZBaseViewController+ZContainer.h
//  ZContainer
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//


#import <ZBase/ZBaseViewController.h>
@import ZBridge;
NS_ASSUME_NONNULL_BEGIN

@interface ZBaseViewController (ZContainer)

@property (nonatomic ,strong) ZBaseBridge *bridge;

@end

NS_ASSUME_NONNULL_END
