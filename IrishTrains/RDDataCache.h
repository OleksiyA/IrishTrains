//
//  RDDataCache.h
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/15/13.
//  Copyright (c) 2013 Oleksiy Ivanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RDStation;

@interface RDDataCache : NSObject

-(NSArray*)listOfStations;
-(RDStation*)addStationWithInfo:(NSDictionary*)stationInfo;

@end
