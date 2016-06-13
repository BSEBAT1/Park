//
//  MapViewController.m
//  Parkd
//
//  Created by macbook pro on 5/25/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//

#import "MapViewController.h"
#import "DisplayDistance.h"

@interface MapViewController ()
@property MKRoute *route_options;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Map.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate=self;
    [self.locationManager requestWhenInUseAuthorization];
  self.Map.showsUserLocation=YES;
    [self.Map setMapType:MKMapTypeStandard];
    [self.Map setZoomEnabled:YES];
    [self.Map setScrollEnabled:YES];
    
    
    
    
    
   
}




-(void)viewDidAppear:(BOOL)animated{
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    NSLog(@"%@", [self deviceLocation]);
    
    //View Area
    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = self.locationManager.location.coordinate.latitude;
    region.center.longitude = self.locationManager.location.coordinate.longitude;
    region.span.longitudeDelta = 0.005f;
    region.span.longitudeDelta = 0.005f;
    [_Map setRegion:region animated:YES];
    
    CLLocationCoordinate2D carlocation_cord=CLLocationCoordinate2DMake(40.7176582, -73.689845);
    
    CarLocation *carlocation=[[CarLocation alloc]initWithTitle:@"Your Car" Location:carlocation_cord];
    
    [self.Map addAnnotation:carlocation];
    
   
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    [request setSource:[MKMapItem mapItemForCurrentLocation]];
    MKPlacemark *mkDest = [[MKPlacemark alloc]
                           initWithCoordinate:carlocation.coordinate
                           addressDictionary:nil];
    
    [request setDestination:[[MKMapItem alloc] initWithPlacemark:mkDest]];
    [request setTransportType:MKDirectionsTransportTypeWalking]; // This can be limited to automobile and walking directions.
    [request setRequestsAlternateRoutes:NO]; // Gives you several route options.
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (!error) {
            for (MKRoute *route in [response routes]) {
                [self.Map addOverlay:[route polyline] level:MKOverlayLevelAboveRoads]; // Draws the route above roads, but below labels.
                // You can also get turn-by-turn steps, distance, advisory notices, ETA, etc by accessing various route properties
                self.route_options=route; } } }];
    
    
    DisplayDistance *distance_to_completion=[[DisplayDistance alloc]initWithTitles:@"Time To Distance" Location:self.route_options.polyline.coordinate];
    
    [self.Map addAnnotation:distance_to_completion];
    
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        [renderer setStrokeColor:[UIColor blueColor]];
        [renderer setLineWidth:5.0];
        return renderer;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.Map setRegion:[self.Map regionThatFits:region] animated:YES];
}
- (NSString *)deviceLocation {
    return [NSString stringWithFormat:@"latitude: %f longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
}
- (NSString *)deviceLat {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude];
}
- (NSString *)deviceLon {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude];
}
- (NSString *)deviceAlt {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.altitude];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    MKAnnotationView *annotationView=nil;
    
    if ([annotation isKindOfClass:[CarLocation class]]) {
        
    
    CarLocation *carlocation_cord=(CarLocation *)annotation;
        
    
   MKAnnotationView *annotationView =[mapView dequeueReusableAnnotationViewWithIdentifier:@"annotation"];
    if (annotationView==nil) {
        annotationView=carlocation_cord.annotationView;
        NSLog(@"FIRST IF STATEMENT");
    }
    }
   else if ([annotation isKindOfClass:[DisplayDistance class]]){
    
        
       
       DisplayDistance *disp_cord=(DisplayDistance *)annotation;
       
       
      MKAnnotationView *annotationView =[mapView dequeueReusableAnnotationViewWithIdentifier:@"car"];
       if (annotationView==nil) {
           annotationView=disp_cord.annotationsView;
           NSLog(@"SECOND IF STATEMENT");
       }
    }

    return annotationView;

    }
    








/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Parkd:(id)sender {
}
@end
