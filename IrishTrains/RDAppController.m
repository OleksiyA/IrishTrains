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

@implementation RDAppController

#pragma mark Internal interface


#pragma mark Allocation and Deallocation
-(id)init
{
    self = [super init];
    
    self.dataCache = [[RDDataCache alloc]init];
    self.networkManager = [[RDNetworkOperationManager alloc]init];
    
    return self;
}

#pragma mark Public interface


@end
