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
-(void)updateStationsIfNeeded
{
    if(![[NSUserDefaults standardUserDefaults]boolForKey:@"StationsUpdated"] || ![[self.dataCache listOfStations]count])
    {
        [self refreshStations];
        
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"StationsUpdated"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

#pragma mark Allocation and Deallocation
-(id)init
{
    self = [super init];
    
    self.dataCache = [[RDDataCache alloc]init];
    self.networkManager = [[RDNetworkOperationManager alloc]init];
    self.locationManager = [[RDLocationManager alloc]init];
    
    [self updateStationsIfNeeded];
    
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

-(void)refreshStations
{
    if(self.refreshingStations)
    {
        return;
    }
    
    NSLog(@"Will refresh stations.");
    
    self.refreshingStations = YES;
    
    [self.networkManager downloadDescriptionsForAllStationsWithCompletionBlock:^(BOOL completed, NSError *error) {
        self.refreshingStations = NO;
        
        if(completed)
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"StationsUpdated" object:self];
        }
        
        NSLog(@"Refresh stations finished.");
        
    } withStationDownloadedBlock:^(NSDictionary *stationDescription) {
        
        [self.dataCache addStationWithInfo:stationDescription];
        
    }];
}

@end
