//
//  ZAddressEditViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

@import ZTable;
#import "ZFragmentConfig.h"
#import "ZFragmentMix.h"
@import ZBean;
NS_ASSUME_NONNULL_BEGIN

@class ZAddressEditViewController;
typedef void(^ZAddressEditBlock)(ZAddressBean *address);

typedef void(^ZAddressAreaTapBlock)(ZAddressEditViewController *from,ZAreaBean *pArea,ZAreaBean *cArea,ZAreaBean *rArea);

@interface ZAddressEditTableViewCell : ZBaseTableViewCell

@end

@interface ZAddressEditViewController : ZTableNoLoadingViewConntroller

+ (instancetype)creatAddressEditWithAddress:(nullable ZAddressBean *)address andEditSucc:(ZAddressEditBlock) block andAreaTapBlock:(ZAddressAreaTapBlock) tapBlock;

- (void)updatePArea:(ZAreaBean *)pArea andCArea:(ZAreaBean *)cArea andRArea:(ZAreaBean *)rArea;

@end

NS_ASSUME_NONNULL_END
