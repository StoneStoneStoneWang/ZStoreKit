//
//  ZEnrollsViewController.h
//  龙卷风竞技
//
//  Created by three stone 王 on 2020/3/12.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>
@import ZBean;
#import "ZEnrollViewController.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger ,ZEnrollsActionType) {
    
    ZEnrollsActionTypeUnLogin,
    
    ZEnrollsActionTypeCharacerSelected,
};

typedef void(^ZEnrollsActionBlock)(ZEnrollsActionType type ,ZBaseViewController *from);

@interface ZEnrollsViewController : ZTableLoadingViewController

+ (instancetype)createEnrolls:(NSString *)tag andTitle:(NSString *)title isHis:(BOOL )his andBlock:(ZEnrollsActionBlock )block;

@end

NS_ASSUME_NONNULL_END
