//
//  RegionDefinitions.h
//  Elite 8 D2W
//
//  Created by Frezza, Stephen T on 3/4/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum { All, Atlantic, Central, East, Midwest, South, SouthCentral, SouthEast, West } regionCode;

@interface RegionDefinitions : NSObject
+(NSArray*) regionStrings;
+(NSString*) convertToString:(regionCode) whichRegion;
+(regionCode) convertFromString: (NSString *)whichRegion;
@end
