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
@import ZActionBridge;

NS_ASSUME_NONNULL_BEGIN

typedef void(^ZEnrollCharacterSelectedBlock)(ZEnrollEditActionType type,ZBaseViewController *from , ZCircleBean *_Nullable cirlce);

@interface ZEnrollEditTableViewCell : ZBaseTableViewCell

@property (nonatomic ,strong) ZEnrollBean *enrollBean;

@end

@interface ZEnrollViewController : ZTableNoLoadingViewConntroller

+ (instancetype)creatEnrollEditEditSucc:(ZEnrollCharacterSelectedBlock) action andTag:(NSString *)tag;

- (void)updateCharacters:(ZCircleBean *)circle;

@end

NS_ASSUME_NONNULL_END
