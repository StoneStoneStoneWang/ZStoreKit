//
//  ZRoutePlanUtil.h
//  WLThirdUtilDemo
//
//  Created by 张丽 on 2019/6/12.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AMapRoutePlanningType)
{
    AMapRoutePlanningTypeDrive NS_SWIFT_NAME(dirve) = 0,
    AMapRoutePlanningTypeWalk NS_SWIFT_NAME(walk) = 1,
    AMapRoutePlanningTypeBus NS_SWIFT_NAME(bus) = 2,
    AMapRoutePlanningTypeBusCrossCity NS_SWIFT_NAME(busCrossCity) = 3,
    AMapRoutePlanningTypeRiding NS_SWIFT_NAME(riding) = 4
};

@interface ZRoutePlanUtil : NSObject

/**
 * @brief 规划路线
 * @param routePlanningType 交通方式
 * @param origin 出发点
 * @param destination 目的地
 * @param city 城市,
 * @param destinationCity 目的城市, 跨城时需要填写，否则会出错
 */
- (void)searchRoutePlanningWithRoutePlanningType:(AMapRoutePlanningType)routePlanningType andOrigin:(AMapGeoPoint *)origin andDestination:(AMapGeoPoint *)destination andCity:(NSString *)city andDestinationCity:(NSString *)destinationCity  NS_SWIFT_NAME(searchRoutePlanning(WithRoutePlanningType:andOrigin:andDestination:andCity:andDestinationCity:));

@end

NS_ASSUME_NONNULL_END
