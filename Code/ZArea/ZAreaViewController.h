//
//  ZAreaViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

@import ZTable;
@import ZBombBridge;
#import "ZFragmentConfig.h"
#import "ZFragmentMix.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^ZAreaBlock)(ZBaseViewController *from ,ZAreaBean *selectedArea ,ZAreaType type ,BOOL hasNext);
@interface ZAreaViewController : ZTableNoLoadingViewConntroller

+ (instancetype)createAreaWithType:(ZAreaType )type andAreaBlock:(ZAreaBlock) block;

- (void)selectedArea:(NSInteger )sid andBlock:(ZAreaBlock)block;

- (void)updateAreas:(NSInteger )sid ;

- (ZAreaBean *)fetchAreaWithId:(NSInteger)sid ;
@end

NS_ASSUME_NONNULL_END
