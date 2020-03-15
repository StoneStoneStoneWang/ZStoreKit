//
//  ZProfileViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>
#import "ZFragmentMix.h"
#import "ZFragmentConfig.h"

NS_ASSUME_NONNULL_BEGIN
@import ZBridge;

typedef void(^ZProfileBlock)(ZProfileActionType type ,ZBaseViewController *vc);
@interface ZProfileViewController : ZTableNoLoadingViewConntroller

+ (instancetype)createProfileWithBlock:(ZProfileBlock) block;

@end

NS_ASSUME_NONNULL_END
