//
//  MainScreen.m
//  Parkd
//
//  Created by macbook pro on 6/14/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//

#import "MainScreen.h"
#import "CarMarker.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
@import CoreGraphics;

@interface MainScreen ()


@property double latitude;
@property double longitude;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (strong, nonatomic) IBOutlet UIButton *Go_To_Map;
@property (strong, nonatomic) IBOutlet UIButton *Save_Location;


@end

@implementation MainScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager startUpdatingLocation];
    } else {
        NSLog(@"Location services are not enabled");
    }
   
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.colors = @[ (__bridge id)[UIColor colorWithRed:0.10 green:0.84 blue:0.99 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0.11 green:0.38 blue:0.94 alpha:1.0].CGColor ];
    self.Go_To_Map.layer.cornerRadius=20;
    self.Save_Location.layer.cornerRadius=20;
    
    [self.view.layer insertSublayer:self.gradientLayer atIndex:0];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.gradientLayer.frame = self.view.bounds;
}



 


    


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    
   
    self.longitude=location.coordinate.longitude;
    self.latitude=location.coordinate.latitude;
    
 
}
- (IBAction)Set_Location:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
  
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CarMarker"];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }

    if (results.count==0) {
        CarMarker *currentlocation =[NSEntityDescription insertNewObjectForEntityForName:@"CarMarker" inManagedObjectContext:context];
        
        [currentlocation setLatitude:[NSNumber numberWithDouble:self.latitude]];
        [currentlocation setLongitude:[NSNumber numberWithDouble:self.longitude]];
        
        NSLog(@"double value is %f",self.latitude);
        NSLog(@"doube value is %f",self.longitude);
        NSLog(@"the array was empty ");
        
        
        if ([context save:&error] == NO) {
            NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
        }
        
        
    }
    
    else{
        
        int i=[results count]-1;
        CarMarker *currentlocation=[results objectAtIndex:i];
    
    
    
 
    
  [currentlocation setLatitude:[NSNumber numberWithDouble:self.latitude]];
   [currentlocation setLongitude:[NSNumber numberWithDouble:self.longitude]];
    
    NSLog(@"double value is %f",self.latitude);
    NSLog(@"doube value is %f",self.longitude);
    NSLog(@"the array has a location");
    
    
   
    if ([context save:&error] == NO) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }
    
    
    
}
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
