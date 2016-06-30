//
//  CarLocation.m
//  Parkd
//
//  Created by macbook pro on 6/1/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//

#import "CarLocation.h"
#import <Mapkit/Mapkit.h>



@implementation CarLocation
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
    
    annotationView.image=[UIImage imageNamed:@"Park"];
    return annotationView;
    
    
    
}

@end
