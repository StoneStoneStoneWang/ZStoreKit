//
//  ZCommentViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>
@import ZBean;
NS_ASSUME_NONNULL_BEGIN

@class ZCommentViewController;

typedef NS_ENUM(NSInteger ,ZCommentActionType) {
    
    ZCommentActionTypeUnLogin,
    
    ZCommentActionTypeComment,
    
    ZCommentActionTypeReport
    
};

typedef void(^ZCommentBlock)(ZCommentViewController *from ,ZCommentActionType type ,ZCircleBean *circleBean);

@interface ZCommentViewController : ZTableLoadingViewController

+ (instancetype)createCommentWithEncode:(NSString *)encode andCircleBean:(ZCircleBean *)circleBean andOp:(ZCommentBlock) block;

@property (nonatomic ,strong ,readonly) UIView *bottomBar;

@end

NS_ASSUME_NONNULL_END
