//
//  MapViewController.h
//  Parkd
//
//  Created by macbook pro on 5/25/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CarLocation.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface MapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *Map;
@property(nonatomic, retain) CLLocationManager *locationManager;
- (IBAction)Parkd:(id)sender;

@end
