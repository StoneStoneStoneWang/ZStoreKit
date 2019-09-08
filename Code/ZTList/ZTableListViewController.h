//
//  ZTableListViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>
#import "ZFragmentConfig.h"
#import "ZFragmentMix.h"
NS_ASSUME_NONNULL_BEGIN


#if ZAppFormGlobalOne
@interface ZTableListViewController : ZTableLoadingViewController

+ (instancetype)createTableList:(BOOL )isMy andTag:(NSString *)tag;

@end

#endif


NS_ASSUME_NONNULL_END




