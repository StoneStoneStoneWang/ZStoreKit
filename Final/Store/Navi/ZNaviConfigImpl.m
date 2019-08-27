//
//  ZNaviConfigImpl.m
//  ZStoreTest
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZNaviConfigImpl.h"
#import "ZFragmentConfig.h"
@import SToolsKit;
@implementation ZNaviConfigImpl

@synthesize backgroundColor;

- (UIColor *)backgroundColor {
    
    return [UIColor s_transformToColorByHexColorStr:@ZFragmentColor];
}
@synthesize backImage;
- (NSString *)backImage {
    
    return @"返回";
}
@synthesize fontSize;

- (CGFloat)fontSize {
    
    return 20.0f;
}
@synthesize titleColor;
- (UIColor *)titleColor {
    
    return [UIColor s_transformToColorByHexColorStr:@"#ffffff"];
}
@end
