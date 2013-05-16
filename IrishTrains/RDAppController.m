//
//  RDAppController.m
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/15/13.
//  Copyright (c) 2013 Oleksiy Ivanov. All rights reserved.
//

#import "RDAppController.h"
#import "RDDataCache.h"
#import "RDNetworkOperationManager.h"
#import "RDLocationManager.h"

@implementation RDAppController

#pragma mark Internal interface


#pragma mark Allocation and Deallocation
-(id)init
{
    self = [super init];
    
    self.dataCache = [[RDDataCache alloc]init];
    self.networkManager = [[RDNetworkOperationManager alloc]init];
    self.locationManager = [[RDLocationManager alloc]init];
    
    return self;
}

#pragma mark Public interface
-(void)requestUpdatedUserLocation
{
    [self.locationManager requestLocationWithMaxAcquisitionTime:30 withPrecisionBetterThan:1000 withCompletionBlock:^(CLLocation *location, NSString *errorDescription) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter]postNotificationName:@"LocationUpdated" object:location];
        });
        
    }];
}

-(NSArray*)listOfStations
{
    return [self.dataCache listOfStations];
}

@end
