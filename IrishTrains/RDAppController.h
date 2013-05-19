//
//  RDAppController.h
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/15/13.
//  Copyright (c) 2013 Oleksiy Ivanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RDDataCache;
@class RDNetworkOperationManager;
@class RDLocationManager;

@interface RDAppController : NSObject

@property(strong)RDDataCache*                   dataCache;
@property(strong)RDNetworkOperationManager*     networkManager;
@property(strong)RDLocationManager*             locationManager;

@property BOOL                                  refreshingStations;

-(void)requestUpdatedUserLocation;
-(NSArray*)listOfStations;
-(void)refreshStations;

@end
