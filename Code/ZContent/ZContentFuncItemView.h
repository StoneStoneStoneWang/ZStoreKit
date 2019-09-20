//
//  ZContentFuncItemView.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/20.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFragmentMix.h"
#import "ZFragmentConfig.h"
@import ZBean;
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger ,ZContentFuncItemType) {
    
    ZContentFuncItemTypeWatch,
    
    ZContentFuncItemTypeComment,
    
    ZContentFuncItemTypeFun ,
    
    ZContentFuncItemTypeMore
};

@protocol ZContentFuncItemViewDelegate <NSObject>

- (void)onFuncItemClick:(ZContentFuncItemType )itemType;

@end

@interface ZContentFuncItemView : UIView

- (void)setCircleBean:(ZCircleBean *)circleBean;

@property (nonatomic ,weak) id <ZContentFuncItemViewDelegate> mDelegate;

@end

NS_ASSUME_NONNULL_END
