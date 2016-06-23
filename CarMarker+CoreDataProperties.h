//
//  CarMarker+CoreDataProperties.h
//  Parkd
//
//  Created by macbook pro on 6/19/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CarMarker.h"

NS_ASSUME_NONNULL_BEGIN

@interface CarMarker (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) id location;
@property (nullable, nonatomic, retain) NSNumber *latitude;

@end

NS_ASSUME_NONNULL_END
