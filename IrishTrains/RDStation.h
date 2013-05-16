//
//  RDStation.h
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/17/13.
//  Copyright (c) 2013 Oleksiy Ivanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RDCacheEntity.h"


@interface RDStation : RDCacheEntity

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * staionCode;
@property (nonatomic, retain) NSString * stationAlias;
@property (nonatomic, retain) NSString * stationDesc;
@property (nonatomic, retain) NSString * stationId;

@end
