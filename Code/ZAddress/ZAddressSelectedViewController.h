//
//  ZAddressSelectedViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>
#import "ZFragmentConfig.h"
#import "ZFragmentMix.h"
#import "ZAddressEditViewController.h"
@import ZBean;
NS_ASSUME_NONNULL_BEGIN

typedef void(^ZAddressSelectedBlock)(ZAddressBean *address);
@interface ZAddressSelectedViewController : ZTableLoadingViewController

+ (instancetype)createAddressWithSelectedBlock:(ZAddressSelectedBlock) block andAreaTapBlock:(ZAddressAreaTapBlock) tapBlock;

@end

NS_ASSUME_NONNULL_END
