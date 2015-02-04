//
//  GlobalVariables.h
//  HealthTip
//
//  Created by Yorke on 14/12/10.
//  Copyright (c) 2014年 Yorke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalVariables : NSObject

+(instancetype) locationManager;


-(void)startUpdatingLocation;

-(void)stopUpdatingLocation;

-(void)startMonitorSignificantLocationChanges;

-(void)stopMonitorSignificantLocationChanges;


@end
