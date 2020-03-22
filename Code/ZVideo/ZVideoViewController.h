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
@class ZVideoViewController;

typedef NS_ENUM(NSInteger ,ZVideoActionType) {
    
    ZVideoActionTypeUnLogin,
    
    ZVideoActionTypeReport,
    
    ZVideoActionTypeShare,
    
    ZVideoActionTypeBlack
    
};

typedef void(^ZVideoActionBlock)(ZVideoActionType type,ZVideoViewController *from , ZCircleBean *_Nullable cirlce ,NSIndexPath *_Nullable ip);

@interface ZVideoViewController : ZTViewController

+ (instancetype)createVideoWithEncode:(NSString *)encode andUrl:(NSString *)url andIsMy:(BOOL )isMy andCircleBean:(ZCircleBean *)circleBean andIp:(NSIndexPath *)ip andVideoBlock:(ZVideoActionBlock)videoBlock;

@end

NS_ASSUME_NONNULL_END
