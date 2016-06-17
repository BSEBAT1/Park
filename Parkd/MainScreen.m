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

@interface MainScreen ()
@property (strong, nonatomic) IBOutlet UILabel *LatitudeValue;
@property (strong, nonatomic) IBOutlet UILabel *Longitudevalue;
@property CLLocationCoordinate2D pinplace;


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
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    
    self.pinplace=CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude);
    
    
    self.LatitudeValue.text = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    self.Longitudevalue.text = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
}
- (IBAction)Set_Location:(id)sender {
//  [[[UIApplication sharedApplication] delegate] managedObjectContext];
    
//    
//    NSManagedObjectContext *mymo=[NSEntityDescription insertNewObjectForEntityForName:@"CarMarker" inManagedObjectContext:;
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
