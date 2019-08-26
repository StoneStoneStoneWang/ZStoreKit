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

typedef NS_ENUM(NSInteger ,WLMainType) {
    
    WLMainTypeHome,
    
    WLMainTypeCart,
    
    WLMainTypeStore,
    
    WLMainTypeList,
    
    WLMainTypeProfile
};

@interface WLMainBean : NSObject

@property (nonatomic ,assign) WLMainType type;

@property (nonatomic ,copy) NSString *title;

@property (nonatomic ,copy) NSString *tag;

@property (nonatomic ,copy) NSString *normalIcon;

@property (nonatomic ,copy) NSString *selectedIcon;

+ (instancetype)mainBeanWithType:(WLMainType )type andTitle:(NSString *)title andTag:(NSString *)tag andNormalIcon:(NSString *)normalIcon andSelectedIcon:(NSString *)selectedIcon;

@end

@interface ZStoreRootManager : NSObject

+ (instancetype)shared;

@property (nonatomic, strong) NSArray *tabs;

@property (nonatomic ,strong) NSMutableArray *catas;

@end

@interface ZStoreRootManager (Config)

- (void)makeRoot:( UIResponder <UIApplicationDelegate> * _Nullable)appdelegate;

@end


NS_ASSUME_NONNULL_END
