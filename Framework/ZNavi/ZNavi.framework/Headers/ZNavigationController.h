//
//  ZNavigationController.h
//  ZNavi
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationBar+BackgroundColor.h"
#import "UIBarButtonItem+ZBarButtonItem.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZNavigationConfig <NSObject>

@property (nonatomic ,assign) CGFloat fontSize;

@property (nonatomic ,strong) UIColor *titleColor;

@property (nonatomic ,strong) UIColor *backgroundColor;

@property (nonatomic ,strong) NSString *backImage;

@end

@interface ZNavigationController : UINavigationController

+ (void)initWithConfig:(id <ZNavigationConfig>) config;

@end

NS_ASSUME_NONNULL_END
