//
//  ZCircleViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/17.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>
#import "ZFragmentConfig.h"
#import "ZFragmentMix.h"
@import ZActionBridge;
NS_ASSUME_NONNULL_BEGIN
@class ZCircleViewController;
typedef void(^ZCircleBlock)(ZTListActionType type,ZCircleViewController *from , ZCircleBean *_Nullable cirlce ,NSIndexPath *_Nullable ip);

@interface ZCircleViewController : ZTableLoadingViewController

+ (instancetype)createCircleWithIsMy:(BOOL )isMy andTag:(NSString *)tag andBlock:(ZCircleBlock )block;

@property (nonatomic ,strong ,readonly) ZTListBridge *bridge;

- (void)updateCircle:(ZCircleBean *)circle;

- (void)insertCircle:(ZCircleBean *)circle;

@end

NS_ASSUME_NONNULL_END
