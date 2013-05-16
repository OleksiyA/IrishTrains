//
//  RDLocationManager.h
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/16/13.
//  Copyright (c) 2013 Oleksiy Ivanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface RDLocationManager : NSObject<CLLocationManagerDelegate>
{
    void(^completionBlock) (CLLocation* location, NSString* errorDescription);
}

@property(strong)CLLocationManager*         locationManager;
@property(strong)NSTimer*                   timer;
@property float                             precisionBetterThan;

-(void)requestLocationWithMaxAcquisitionTime:(NSTimeInterval)timeout withPrecisionBetterThan:(float)precisionBetterThan withCompletionBlock:(void(^)(CLLocation* location, NSString* errorDescription))block;

@end
