//
//  ZBaseViewController+ZContainer.m
//  ZContainer
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZBaseViewController+ZContainer.h"
#import <objc/runtime.h>

@implementation ZBaseViewController (ZContainer)

- (void)setBridge:(ZBaseBridge *)bridge {
    
    objc_setAssociatedObject(self, @"bridge", bridge, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-  (ZBaseBridge *)bridge {
    
    return objc_getAssociatedObject(self, @"bridge");
}

@end
