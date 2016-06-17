//
//  CarMarker.m
//  Parkd
//
//  Created by macbook pro on 6/16/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//

#import "CarMarker.h"
#

@implementation CarMarker
@dynamic location;


+ (Class)transformedValueClass
{
    return [CLLocation class];
}
+ (BOOL)allowsReverseTransformation
{
    return YES;
}

- (id)transformedValue:(id)value
{
    return [NSKeyedArchiver archivedDataWithRootObject:value];
}

- (id)reverseTransformedValue:(id)value
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:value];
}



@end
