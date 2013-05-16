//
//  RDNetworkOperationManager.h
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/15/13.
//  Copyright (c) 2013 Oleksiy Ivanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDNetworkOperationManager : NSObject

-(void)downloadDescriptionsForAllStationsWithCompletionBlock:(void(^)(NSArray* stationsDescriptions, BOOL completed))block;
-(void)downloadTrainMovementInfoForTrainWithId:(NSString*)trainId withCompletionBlock:(void(^)(NSDictionary* trainMovementDescription, BOOL completed))block;

@end
