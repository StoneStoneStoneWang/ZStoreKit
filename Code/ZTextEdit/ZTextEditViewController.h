//
//  ZTextEditViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTransition/ZTransition.h>
#import "ZFragmentMix.h"
typedef void(^ZTextEditBlock)(NSString * _Nonnull text);

NS_ASSUME_NONNULL_BEGIN

@interface ZTextEditViewController : ZTViewController

+ (instancetype)createTextEditWithHis:(NSString *)his andBlock:(ZTextEditBlock)block;

@end

NS_ASSUME_NONNULL_END
