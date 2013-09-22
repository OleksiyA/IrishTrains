//
//  RDDataCache.h
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/15/13.
//  Copyright (c) 2013 Oleksiy Ivanov.
//  The MIT License (MIT).
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RDStation;

@interface RDDataCache : NSObject

@property(strong)NSManagedObjectContext * managedContext;
@property(strong)NSPersistentStoreCoordinator * storeCoordinator;
@property(strong)NSManagedObjectModel * model;

- (NSArray *)listOfStations;
- (RDStation *)addStationWithInfo:(NSDictionary *)stationInfo;
- (RDStation *)stationWithId:(NSString *)stationId;

@end
