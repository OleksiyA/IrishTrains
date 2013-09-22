//
//  RDTrainStop.h
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/17/13.
//  Copyright (c) 2013 Oleksiy Ivanov.
//  The MIT License (MIT).
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RDCacheEntity.h"

@class RDTrainMovement;

@interface RDTrainStop : RDCacheEntity

@property (nonatomic, retain) NSDate * arrivalActual;
@property (nonatomic, retain) NSNumber * autoArrival;
@property (nonatomic, retain) NSNumber * autoDepart;
@property (nonatomic, retain) NSDate * departureActual;
@property (nonatomic, retain) NSString * locationCode;
@property (nonatomic, retain) NSString * locationFullName;
@property (nonatomic, retain) NSString * locationOrder;
@property (nonatomic, retain) NSString * locationType;
@property (nonatomic, retain) NSDate * scheduledArrival;
@property (nonatomic, retain) NSDate * scheduledDeparture;
@property (nonatomic, retain) NSString * stopType;
@property (nonatomic, retain) RDTrainMovement *movements;

@end
