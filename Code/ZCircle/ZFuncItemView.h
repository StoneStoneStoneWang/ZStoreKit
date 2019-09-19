//
//  ZFuncItemView.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFragmentMix.h"
#import "ZFragmentConfig.h"
@import ZBean;
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger ,ZFuncItemType) {
    
    ZFuncItemTypeWatch,
    
    ZFuncItemTypeComment,
    
    ZFuncItemTypeFun ,
    
    ZFuncItemTypeMore
};

@protocol ZFuncItemViewDelegate <NSObject>

- (void)onFuncItemClick:(ZFuncItemType )itemType;

@end

@interface ZFuncItemView : UIView

- (void)setCircleBean:(ZCircleBean *)circleBean;

@property (nonatomic ,weak) id <ZFuncItemViewDelegate> mDelegate;

@end

NS_ASSUME_NONNULL_END
