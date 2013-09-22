//
//  RDDataCache.m
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/15/13.
//  Copyright (c) 2013 Oleksiy Ivanov.
//  The MIT License (MIT).
//

#import "RDDataCache.h"
#import "RDStation.h"
#import "RDCacheEntity.h"
#import "RDTrainStop.h"
#import "RDTrainMovement.h"

@implementation RDDataCache

#pragma mark Internal interface
- (NSURL *)applicationFilesDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return appSupportURL;
}

- (void)setupCoreDataStack
{
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"Model" withExtension:@"momd"];
    self.model = [[NSManagedObjectModel alloc]initWithContentsOfURL:url];
    
    self.storeCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:self.model];
    
    NSURL *databaseUrl = [[self applicationFilesDirectory]URLByAppendingPathComponent:@"CacheDb.sqlite"];
    NSError *error = nil;
    if (![self.storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:databaseUrl options:nil error:&error]) {
        NSLog(@"Error setting up Core Data stack, [%@].", error);
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            //try to setup Core Date once more with clear database
            
            [[NSFileManager defaultManager]removeItemAtURL:databaseUrl error:nil];
            
            NSLog(@"Will try to resetup Core Data stack after error.");
            
            [self setupCoreDataStack];
        });
        return;
    }
    
    self.managedContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    [self.managedContext setPersistentStoreCoordinator:self.storeCoordinator];
}

- (void)save
{
    dispatch_block_t block = ^{
        NSError* error = nil;
        [self.managedContext save:&error];
        
        if (error) {
            NSLog(@"Error saving managed object context [%@].", error);
        }
    };
    
    [self.managedContext performBlockAndWait:block];
}

#pragma mark Allocation and Deallocation
- (instancetype)init
{
    self = [super init];
    
    [self setupCoreDataStack];
    
    return self;
}

- (void)dealloc
{
    [self save];
}

#pragma mark Public interface
- (NSArray *)listOfStations
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Station"];
    
    NSError *error = nil;
    NSArray *results = [self.managedContext executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"Fetch error [%@].", error);
    }
    
    return results;
}

- (RDStation *)addStationWithInfo:(NSDictionary *)stationInfo
{
    NSLog(@"Will add station with info [%@].",stationInfo);
    
    NSString *stationId = [stationInfo objectForKey:@"StationId"];
    
    if (![stationId length]) {
        NSLog(@"Unable to add station with empty id, stationInfo[%@].", stationInfo);
        return nil;
    }
    
    RDStation *station = [self stationWithId:stationId];
    
    if (!station) {
        station = [NSEntityDescription insertNewObjectForEntityForName:@"Station" inManagedObjectContext:self.managedContext];
    }
    
    station.stationId = stationId;
    
    if ([[stationInfo objectForKey:@"StationCode"] length]) {
        station.staionCode = [stationInfo objectForKey:@"StationCode"];
    }
    if ([[stationInfo objectForKey:@"StationDesc"] length]) {
        station.stationDesc = [stationInfo objectForKey:@"StationDesc"];
    }
    if ([[stationInfo objectForKey:@"StationLatitude"] length]) {
        station.latitude = @([[stationInfo objectForKey:@"StationLatitude"]doubleValue]);
    }
    if ([[stationInfo objectForKey:@"StationLongitude"] length]) {
        station.longitude = @([[stationInfo objectForKey:@"StationLongitude"]doubleValue]);
    }
    
    [self save];
    
    return station;
}

- (RDStation *)stationWithId:(NSString *)stationId
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Station"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"stationId == %@", stationId];
    request.predicate = predicate;
    
    NSError *error = nil;
    NSArray *results = [self.managedContext executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"Fetch error [%@].", error);
    }
    
    return [results lastObject];
}

@end
