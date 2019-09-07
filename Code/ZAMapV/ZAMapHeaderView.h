//
//  ZAMapHeaderView.h
//  ZFragment
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

@import ZTable;
#import "ZFragmentMix.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZAMapHeaderView : ZTableHeaderView

- (void)updateLocationText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
