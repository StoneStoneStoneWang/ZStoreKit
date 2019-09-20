//
//  ZVideoViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//


#import <ZTransition/ZTransition.h>
NS_ASSUME_NONNULL_BEGIN
@import ZBean;

typedef void(^ZVideoOperation)(void);

@interface ZVideoViewController : ZTViewController

+ (instancetype)createVideoWithEncode:(NSString *)encode andUrl:(NSString *)url andIsMy:(BOOL )isMy andCircleBean:(ZCircleBean *)circleBean andOp:(ZVideoOperation )op;

@end

NS_ASSUME_NONNULL_END
