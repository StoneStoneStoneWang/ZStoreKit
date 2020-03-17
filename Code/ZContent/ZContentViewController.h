//
//  ZContentViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/20.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>
@import ZBean;
@import ZActionBridge;

NS_ASSUME_NONNULL_BEGIN
@class ZContentViewController;
typedef void(^ZContentBlock)(ZContentActionType type,ZContentViewController * from,ZKeyValueBean *_Nullable keyValue,ZCircleBean *_Nullable circleBean);

@interface ZContentViewController : ZTableNoLoadingViewConntroller

+ (instancetype)createContentWithCircleBean:(ZCircleBean *)circleBean andIsMy:(BOOL )isMy andOp:(ZContentBlock)op;

- (void)updateCircle:(ZCircleBean *)circle;

@end

NS_ASSUME_NONNULL_END
