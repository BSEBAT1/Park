//
//  CarMarker.h
//  Parkd
//
//  Created by macbook pro on 6/16/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarMarker : NSManagedObject
@property (nullable, nonatomic, retain) id location;

@end

NS_ASSUME_NONNULL_END

#import "CarMarker+CoreDataProperties.h"
