//
//  DisplayDistance.m
//  Parkd
//
//  Created by macbook pro on 6/11/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//

#import "DisplayDistance.h"


@implementation DisplayDistance
@synthesize coordinate;

-(MKAnnotationView* ) annotationsView{
    
    MKAnnotationView *annotationView=[[MKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"car"];
    annotationView.enabled=YES;
    annotationView.canShowCallout=YES;
    annotationView.rightCalloutAccessoryView=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.image=[UIImage imageNamed:@"Park"];
    return annotationView;
    
    
    
}
-(id)initWithTitles:(NSString *)newTitles Location:(CLLocationCoordinate2D)location{
    
    self=[super init];
    
    _time_to_target=newTitles;
    _pinadress=location;
    NSLog(@"wank");
    return self;
    
    
    
}

@end
