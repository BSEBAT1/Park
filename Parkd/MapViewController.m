//
//  MapViewController.m
//  Parkd
//
//  Created by macbook pro on 5/25/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//

#import "MapViewController.h"
#import "DisplayDistance.h"
#import "AppDelegate.h"
#import "CarMarker.h"

@interface MapViewController ()
@property MKRoute *route_options;
@property MKDirections *go_directions;
@property CLLocationCoordinate2D carlocation_cord;
@property NSNumber *latitude;
@property NSNumber *longitude;
@property (nonatomic) BOOL start_navigation;




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

- (IBAction)Start_Navigation:(id)sender {
    
    self.start_navigation=YES;
    
    
}


- (IBAction)End_Navigation:(id)sender {
    self.start_navigation=NO;
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
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CarMarker"];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    if ([results count]>0) {
        int i=[results count]-1;
        CarMarker *cart=[results objectAtIndex:i];
        NSLog(@"the latitude is %@",cart.latitude);
        NSLog(@"the longtitude is %@",cart.longitude);
        
        
        
        self.carlocation_cord=CLLocationCoordinate2DMake([cart.latitude doubleValue],[cart.longitude doubleValue]);
        
        CarLocation *carlocation=[[CarLocation alloc]initWithTitle:@"Your Car" Location:self.carlocation_cord];
        
        [self.Map addAnnotation:carlocation];
        
    }
    else{
     
        
        UIAlertController * alert=[UIAlertController
                                   alertControllerWithTitle:@"No Locations Saved"
                                   message:@"Save A Car Location First!"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
        [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:^{
        }];

        
      [NSThread sleepForTimeInterval:1];
        
        
        
        
        
        
        
    }
    
   
    
    
    
    
}


-(void)drawmap{
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    [request setSource:[MKMapItem mapItemForCurrentLocation]];
    MKPlacemark *mkDest = [[MKPlacemark alloc]
                           initWithCoordinate:self.carlocation_cord
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
                
                self.route_options=route;
                int time_to_car=self.route_options.expectedTravelTime/60;
                NSString *mins=@(time_to_car).stringValue;
                NSString *literal_time_s=@" Mins";
                NSString *time_display=[NSString stringWithFormat:@"%@%@",mins,literal_time_s];
                
                
                
                
                DisplayDistance *distance_to_completion=[[DisplayDistance alloc]initWithTitle:time_display Location:self.route_options.polyline.coordinate];
                
                [self.Map addAnnotation:distance_to_completion];
                
                
                [self performSelector:@selector(selectAnnotation:) withObject:distance_to_completion afterDelay:0.5];
                
                
                
            } } }];
    
    

    
    
    
    
    
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
    if (self.start_navigation) {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 1000, 1000);
        [self.Map setRegion:[self.Map regionThatFits:region] animated:YES];
        [self drawmap];
    }
    
    
    
    
    
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
    
   
    
    if ([annotation isKindOfClass:[CarLocation class]]) {
        
    
    CarLocation *carlocation_cor=(CarLocation *)annotation;
        
    
   MKAnnotationView *annotationView =[mapView dequeueReusableAnnotationViewWithIdentifier:@"annotation"];
    if (annotationView==nil) {
        annotationView=carlocation_cor.annotationView;
        NSLog(@"FIRST IF STATEMENT");
        
        annotationView.rightCalloutAccessoryView = [self yesButton];
        
    }
    return annotationView;
    }
   else if ([annotation isKindOfClass:[DisplayDistance class]]){
    
        
       
       DisplayDistance *disp_cord=(DisplayDistance *)annotation;
       
       
      MKAnnotationView *annotationView =[mapView dequeueReusableAnnotationViewWithIdentifier:@"car"];
       if (annotationView==nil) {
           annotationView=disp_cord.annotationView;
           NSLog(@"SECOND IF STATEMENT");
       }
       
       return annotationView;
    }

    return nil;
    
    }
    



- (void)selectAnnotation:(id < MKAnnotation >)annotation
{
    [self.Map selectAnnotation:annotation animated:NO];
}



- (UIButton *)yesButton {
    
    UIImage *image=[UIImage imageNamed:@"button"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, image.size.width, image.size.height); // don't use auto layout
 [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventPrimaryActionTriggered];
    
    return button;
}

- (IBAction)didTapButton:(id)sender
{
    
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:self.carlocation_cord addressDictionary:nil];
    MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:placemark];
    item.name = @"Your Car";
    [item openInMapsWithLaunchOptions:nil];
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
