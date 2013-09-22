//
//  RDLocationManager.m
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/16/13.
//  Copyright (c) 2013 Oleksiy Ivanov.
//  The MIT License (MIT).
//

#import "RDLocationManager.h"

@implementation RDLocationManager

#pragma mark Internal interface
- (void)startGatheringLocation
{
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc]init];
        
        self.locationManager.delegate = self;
    }
    
    [self.locationManager startUpdatingLocation];
}

- (void)stopGatheringLocation
{
    [self.locationManager stopUpdatingLocation];
}

- (void)onTimerTimeout:(NSTimer *)timer
{
    [self stopGatheringLocation];
    [self stopTimer];
    
    completionBlock(nil, @"Unable to retrieve location");
}

- (void)startTimerWithDelay:(NSTimeInterval)delay
{
    [self stopTimer];
    
    dispatch_block_t block = ^{
        self.timer = [NSTimer scheduledTimerWithTimeInterval:delay target:self selector:@selector(onTimerTimeout:) userInfo:nil repeats:NO];
    };
    
    if (![NSThread isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), block);
    } else {
        block();
    }
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark Allocation and Deallocation
- (instancetype)init
{
    self = [super init];
    
    return self;
}

- (void)dealloc
{
    [self stopTimer];
}

#pragma mark Public interface
- (void)requestLocationWithMaxAcquisitionTime:(NSTimeInterval)timeout withPrecisionBetterThan:(float)precisionBetterThan withCompletionBlock:(void(^)(CLLocation *location, NSString *errorDescription))block
{
    completionBlock = [block copy];
    self.precisionBetterThan = precisionBetterThan;
    
    [self startGatheringLocation];
}

#pragma mark CLLocationManagerDelegate methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    
    if (!location) {
        return;
    }
    
    if (location.horizontalAccuracy <= self.precisionBetterThan) {
        //report about completion
        
        [self stopGatheringLocation];
        [self stopTimer];
        
        completionBlock(location,nil);
    }
}

@end
