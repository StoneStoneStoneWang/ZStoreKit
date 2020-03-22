//
//  ZAreaHeaderViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import <ZCollection/ZCollection.h>
#import "ZFragmentConfig.h"
#import "ZFragmentMix.h"
@import ZBean;
NS_ASSUME_NONNULL_BEGIN

typedef void(^ZAreaHeaderBlock)(ZBaseViewController *from ,ZAreaBean *pArea ,ZAreaBean *cArea ,ZAreaBean *_Nullable rArea);

@interface ZAreaHeaderViewController : ZCollectionNoLoadingViewController

+ (instancetype)createAreaHeaderWithPid:(NSInteger)pid andCid:(NSInteger)cid andRid:(NSInteger )rid andAreaHeaderBlock:(ZAreaHeaderBlock) block;

@end

@interface ZAreaPresentAnimation : NSObject <UIViewControllerAnimatedTransitioning>


@end

@interface ZAreaDismissAnimation : NSObject <UIViewControllerAnimatedTransitioning>


@end

NS_ASSUME_NONNULL_END
