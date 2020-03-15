//
//  ZModifyViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTransition/ZTransition.h>
#import "ZFragmentConfig.h"
#import "ZFragmentMix.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^ZModifyPwdBlock)(ZBaseViewController *vc);

@interface ZModifyViewController : ZTViewController

+ (instancetype)createPwdWithBlock:(ZModifyPwdBlock )block;
@end

NS_ASSUME_NONNULL_END
