//
//  ZContentHeaderView.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/20.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFragmentMix.h"
#import "ZFragmentConfig.h"
@import ZBean;
#import <ZTable/ZTable.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZContentHeaderView : ZTableHeaderView

- (void)setCircleBean:(ZCircleBean *)circleBean;

@property (nonatomic ,strong ,readonly) UIButton *focusItem;
@end

NS_ASSUME_NONNULL_END
