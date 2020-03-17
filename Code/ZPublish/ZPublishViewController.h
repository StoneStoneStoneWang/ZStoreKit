//
//  ZPublishViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger ,ZPublishActionType) {
    
    ZPublishActionTypeAddText,
    
    ZPublishActionTypeUpdateText,
    
    ZPublishActionTypePublish
    
};
@import ZBean;
@class ZPublishViewController;
typedef void(^ZPublishBlock)(ZCircleBean *_Nullable circleBean ,ZPublishViewController * from ,ZPublishActionType type,ZKeyValueBean *_Nullable keyValue);

@interface ZPublishViewController : ZTableNoLoadingViewConntroller

+ (instancetype)createPublishWithTag:(NSString *)tag andBlock:(ZPublishBlock ) block;

- (void)addContent:(NSString *)text;

- (void)updateContent:(ZKeyValueBean *)keyValue;

@end

NS_ASSUME_NONNULL_END
