//
//  RDAppController.h
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/15/13.
//  Copyright (c) 2013 Oleksiy Ivanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RDDataCache;
@class RDNetworkOperationManager;

@interface RDAppController : NSObject

@property(strong)RDDataCache*                   dataCache;
@property(strong)RDNetworkOperationManager*     networkManager;

@end