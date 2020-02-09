//
//  ZHandleFooterView.h
//  ZFragment
//
//  Created by three stone 王 on 2019/10/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZhandleButton : UIButton

- (void)layoutButtonWithImageTitleSpace:(CGFloat)space;

@end

@interface ZHandleFooterView : UIView

@property (nonatomic ,strong ,readonly) ZhandleButton *completeItem;

@end

NS_ASSUME_NONNULL_END
