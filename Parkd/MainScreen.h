//
//  MainScreen.h
//  Parkd
//
//  Created by macbook pro on 6/14/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapViewController.h"
#import "CarMarker.h"
#import <CoreData/CoreData.h>


@interface MainScreen : UIViewController<CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocationManager *locationManager;

@end
