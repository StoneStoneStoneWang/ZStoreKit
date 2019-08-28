//
//  ZBaseViewController.h
//  ZBase
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBaseMix.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZBaseViewController  : UIViewController

- (void)configNaviItem NS_SWIFT_NAME(s_configNaviItem());

- (void)configOwnProperties NS_SWIFT_NAME(s_configOwnProperties());

- (void)addOwnSubViews NS_SWIFT_NAME(s_addOwnSubViews());

- (void)configOwnSubViews NS_SWIFT_NAME(s_configOwnSubViews());

- (void)configLoading NS_SWIFT_NAME(s_configLoading());

- (void)configViewModel NS_SWIFT_NAME(s_configViewModel());

- (void)prepareData NS_SWIFT_NAME(s_prepareData());

- (void)configAuto NS_SWIFT_NAME(s_configAuto());

- (void)addOwnSubViewController NS_SWIFT_NAME(s_addOwnSubViewController());

@end

NS_ASSUME_NONNULL_END
