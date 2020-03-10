//
//  ZCharactersTableViewCell.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/9.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>
@import ZBridge;
@import ZBean;

NS_ASSUME_NONNULL_BEGIN

@interface ZCharactersTableViewCell : ZBaseTableViewCell

@property (nonatomic ,strong) ZCircleBean *characters;

@end

NS_ASSUME_NONNULL_END
