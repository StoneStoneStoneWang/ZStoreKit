//
//  ZEnrollViewController.h
//  龙卷风竞技
//
//  Created by three stone 王 on 2020/3/12.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>
#import "ZFragmentConfig.h"
#import "ZFragmentMix.h"
@import ZBean;
NS_ASSUME_NONNULL_BEGIN

typedef void(^ZEnrollEditBlock)(ZCircleBean *circle);

typedef void(^ZCharactersEditBlock)(ZCircleBean *circle);
@interface ZEnrollEditTableViewCell : ZBaseTableViewCell


@end

@interface ZEnrollViewController : ZTableNoLoadingViewConntroller

+ (instancetype)creatEnrollEditEditSucc:(ZEnrollEditBlock) succ andTag:(NSString *)tag;

@end

NS_ASSUME_NONNULL_END
