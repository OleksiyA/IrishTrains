//
//  RDCacheEntity.h
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/17/13.
//  Copyright (c) 2013 Oleksiy Ivanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RDCacheEntity : NSManagedObject

@property (nonatomic, retain) NSDate * dateLastRefreshed;
@property (nonatomic, retain) NSNumber * expiresInSeconds;

@end
