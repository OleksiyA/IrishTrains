//
//  RDAppDelegate.h
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/15/13.
//  Copyright (c) 2013 Oleksiy Ivanov.
//  The MIT License (MIT).
//

#import <UIKit/UIKit.h>

@class RDAppController;

@interface RDAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow * window;
@property (strong, nonatomic) RDAppController * appController;

@end
