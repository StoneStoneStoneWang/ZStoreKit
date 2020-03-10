//
//  ZCharacterNameViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/10.
//  Copyright © 2020 three stone 王. All rights reserved.
//

@import ZTransition;
#import "ZFragmentMix.h"


NS_ASSUME_NONNULL_BEGIN

typedef void(^ZCharacterNameSucc)(NSString *nameVale);

@interface ZNickNameViewController : ZTViewController


@end
@interface ZCharacterNameViewController : ZTViewController

+ (instancetype)createCharacterName:(NSString *)name andBlock:(ZCharacterNameSucc)succ;

@end

NS_ASSUME_NONNULL_END
