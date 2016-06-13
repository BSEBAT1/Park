//
//  DisplayDistance.h
//  Parkd
//
//  Created by macbook pro on 6/11/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface DisplayDistance : NSObject<MKAnnotation>
@property(nonatomic,readonly) CLLocationCoordinate2D pinadress;
@property (copy, nonatomic) NSString *time_to_target;

-(id)initWithTitles:(NSString *)newTitles Location:(CLLocationCoordinate2D)location;
-(MKAnnotationView* ) annotationsView;

@end
