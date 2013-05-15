//
//  RDTrainMovement.h
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/16/13.
//  Copyright (c) 2013 Oleksiy Ivanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RDCacheEntity.h"

@class RDTrainStop;

@interface RDTrainMovement : RDCacheEntity

@property (nonatomic, retain) NSSet *stops;
@end

@interface RDTrainMovement (CoreDataGeneratedAccessors)

- (void)addStopsObject:(RDTrainStop *)value;
- (void)removeStopsObject:(RDTrainStop *)value;
- (void)addStops:(NSSet *)values;
- (void)removeStops:(NSSet *)values;

@end