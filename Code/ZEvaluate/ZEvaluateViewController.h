//
//  ZEvaluateViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/11.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>

NS_ASSUME_NONNULL_BEGIN
@import ZBean;

typedef void(^ZEvaluateSucc)(void);
@interface ZEvaluateViewController : ZTableNoLoadingViewConntroller

+ (instancetype)createEvaluateWithCircleBean:(ZCircleBean *)circleBean andOp:(ZEvaluateSucc )op;

@end

NS_ASSUME_NONNULL_END
