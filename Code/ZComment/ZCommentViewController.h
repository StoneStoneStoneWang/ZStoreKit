//
//  ZCommentViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>
#import "ZFragmentMix.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^ZCommentOperation)(void);

@interface ZCommentViewController : ZTableLoadingViewController

+ (instancetype)createCommentWithEncode:(NSString *)encode andOp:(ZCommentOperation) op;

@property (nonatomic ,strong ,readonly) UIView *bottomBar;

@end

NS_ASSUME_NONNULL_END
