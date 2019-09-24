//
//  ZPublishFooterView.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFragmentMix.h"
#import "ZFragmentConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZPublishFooterView : UIView

@property (nonatomic ,strong ,readonly) UIButton *textItem;

@property (nonatomic ,strong ,readonly) UIButton *imageItem;

@property (nonatomic ,strong ,readonly) UIButton *videoItem;

@end

NS_ASSUME_NONNULL_END
