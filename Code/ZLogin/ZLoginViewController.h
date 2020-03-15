//
//  ZLoginViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/8/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTransition/ZTransition.h>
#import "ZFragmentConfig.h"
#import "ZFragmentMix.h"
@import ZBridge;

NS_ASSUME_NONNULL_BEGIN

typedef void(^ZLoginBlock)(ZLoginActionType type ,ZBaseViewController *vc);
@interface ZLoginViewController : ZTViewController

+ (instancetype)createLoginWithBlock:(ZLoginBlock)block;
@end

NS_ASSUME_NONNULL_END
