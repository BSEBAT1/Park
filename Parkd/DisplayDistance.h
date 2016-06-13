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
@property(nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *title;
-(id)initWithTitle:(NSString *)newTitle Location:(CLLocationCoordinate2D)location;
-(MKAnnotationView* ) annotationView;

@end
