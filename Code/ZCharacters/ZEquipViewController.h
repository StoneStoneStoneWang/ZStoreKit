//
//  ZEquipViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/10.
//  Copyright © 2020 three stone 王. All rights reserved.
//

@import ZTable;
#import "ZFragmentMix.h"
NS_ASSUME_NONNULL_BEGIN


@interface ZEquipTableViewCell : ZBaseTableViewCell

@end

typedef void(^ZCharacterEquipSucc)(NSString *equipsVale);

@interface ZEquipViewController : ZTableNoLoadingViewConntroller

+ (instancetype)createEquip:(NSString *)equips andBlock:(ZCharacterEquipSucc )block;

@end

NS_ASSUME_NONNULL_END
