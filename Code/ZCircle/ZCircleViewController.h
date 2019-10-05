//
//  ZCircleViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/17.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>
#import "ZFragmentConfig.h"
#import "ZFragmentMix.h"

NS_ASSUME_NONNULL_BEGIN
@import ZBridge;

@interface ZCircleViewController : ZTableLoadingViewController

+ (instancetype)createTableList:(BOOL )isMy andTag:(NSString *)tag;

@property (nonatomic ,strong ,readonly) ZTListBridge *bridge;

@end

NS_ASSUME_NONNULL_END
