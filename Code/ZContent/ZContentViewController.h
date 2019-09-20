//
//  ZContentViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/20.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>
@import ZBean;


NS_ASSUME_NONNULL_BEGIN

typedef void(^ZContentOperation)(void);

@interface ZContentViewController : ZTableNoLoadingViewConntroller

+ (instancetype)createContentWithCircleBean:(ZCircleBean *)circleBean andIsMy:(BOOL )isMy andOp:(ZContentOperation)op;

@end

NS_ASSUME_NONNULL_END
