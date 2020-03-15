//
//  ZRegViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTransition/ZTransition.h>
#import "ZFragmentConfig.h"
#import "ZFragmentMix.h"
@import ZBridge;
NS_ASSUME_NONNULL_BEGIN

typedef void(^ZRegBlock)(ZRegActionType type ,ZBaseViewController *vc);

@interface ZRegViewController : ZTViewController

+ (instancetype)createRegWithBlock:(ZRegBlock) block;

@end

NS_ASSUME_NONNULL_END
