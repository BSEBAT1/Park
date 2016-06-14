//
//  DisplayDistance.m
//  Parkd
//
//  Created by macbook pro on 6/11/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//

#import "DisplayDistance.h"


@implementation DisplayDistance
-(id)initWithTitle:(NSString *)newTitle Location:(CLLocationCoordinate2D)location{
    
    self=[super init];
    
    _title=newTitle;
    _coordinate=location;
    
    return self;
    
}
-(MKAnnotationView* ) annotationView{
    
    MKAnnotationView *annotationView=[[MKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"annotation"];
    annotationView.enabled=YES;
    annotationView.canShowCallout=YES;
//    annotationView.rightCalloutAccessoryView=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.image=[UIImage imageNamed:@"time_target"];
    return annotationView;
    
    
    
}

@end
