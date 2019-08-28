//
//  ZSignatureViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/8/28.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTransition/ZTransition.h>

typedef void(^ZSignatureSucc)(void);

NS_ASSUME_NONNULL_BEGIN

@interface ZSignatureViewController : ZTViewController

+ (instancetype)createSignature:(ZSignatureSucc)succ;

@end

NS_ASSUME_NONNULL_END
