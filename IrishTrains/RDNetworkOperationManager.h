//
//  RDNetworkOperationManager.h
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/15/13.
//  Copyright (c) 2013 Oleksiy Ivanov.
//  The MIT License (MIT).
//

#import <Foundation/Foundation.h>

@interface RDNetworkOperationManager : NSObject

- (void)downloadDescriptionsForAllStationsWithCompletionBlock:(void(^)(BOOL completed, NSError *error))block withStationDownloadedBlock:(void(^)(NSDictionary *stationDescription))blockStationReady;
- (void)downloadTrainMovementInfoForTrainWithId:(NSString *)trainId withCompletionBlock:(void(^)(NSDictionary *trainMovementDescription, BOOL completed))block;
- (void)downloadStationUsageForStation:(NSString *)station withCompletionBlock:(void(^)(NSArray *stationUsageDescriptions, BOOL completed))block;

@end
