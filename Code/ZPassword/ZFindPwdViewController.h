//
//  ZFindPwdViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTransition/ZTransition.h>
#import "ZFragmentConfig.h"
#import "ZFragmentMix.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^ZFindPwdBlock)(ZBaseViewController *vc);
@interface ZFindPwdViewController : ZTViewController

+ (instancetype)createPwdWithBlock:(ZFindPwdBlock )block;

@end

NS_ASSUME_NONNULL_END
