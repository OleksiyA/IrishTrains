//
//  RDTrainStop.h
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/16/13.
//  Copyright (c) 2013 Oleksiy Ivanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RDCacheEntity.h"

@class RDTrainMovement;

@interface RDTrainStop : RDCacheEntity

@property (nonatomic, retain) NSSet *movements;
@end

@interface RDTrainStop (CoreDataGeneratedAccessors)

- (void)addMovementsObject:(RDTrainMovement *)value;
- (void)removeMovementsObject:(RDTrainMovement *)value;
- (void)addMovements:(NSSet *)values;
- (void)removeMovements:(NSSet *)values;

@end
