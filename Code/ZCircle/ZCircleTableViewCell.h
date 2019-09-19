//
//  ZCircleTableViewCell.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/17.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>
#import "ZFragmentMix.h"
#import "ZFragmentConfig.h"
#import "ZFuncItemView.h"
NS_ASSUME_NONNULL_BEGIN
@import ZBean;

@protocol ZCircleTableViewCellDelegate <NSObject>

- (void)onFuncItemClick:(ZFuncItemType )itemType forCircleBean:(ZCircleBean *)circleBean;

@end

@interface ZCircleTableViewCell : ZBaseTableViewCell

@property (nonatomic ,strong) ZCircleBean *circleBean;

@property (nonatomic ,weak) id <ZCircleTableViewCellDelegate> mDelegate;

@end

#if ZCircleFormOne

@interface ZCircleImageTableViewCell : ZCircleTableViewCell


@end

@interface ZCircleVideoTableViewCell : ZCircleTableViewCell


@end

#endif



NS_ASSUME_NONNULL_END
