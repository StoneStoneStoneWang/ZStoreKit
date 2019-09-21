//
//  ZTextEditViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTransition/ZTransition.h>
#import "ZFragmentMix.h"
typedef void(^ZTextEditSucc)(void);

NS_ASSUME_NONNULL_BEGIN

@interface ZTextEditViewController : ZTViewController

+ (instancetype)createTextEdit:(ZTextEditSucc)succ;

@end

NS_ASSUME_NONNULL_END
