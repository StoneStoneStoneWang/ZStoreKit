//
//  ZStoreRootManager.h
//  ZStoreTest
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

@import Foundation;
@import UIKit;
NS_ASSUME_NONNULL_BEGIN

@interface ZStoreRootManager : NSObject

+ (instancetype)shared;

@end

@interface ZStoreRootManager (Config)

- (void)makeRoot:( UIResponder <UIApplicationDelegate> * _Nullable)appdelegate;

@end


NS_ASSUME_NONNULL_END
