//
//  RegionDefinitions.m
//  Elite 8 D2W
//
//  Created by Frezza, Stephen T on 3/4/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import "RegionDefinitions.h"

@implementation RegionDefinitions

+(NSArray *) regionStrings
{
    static  NSArray *_regionStrings;
    if(!_regionStrings) {
        _regionStrings = [NSArray arrayWithObjects: @"All", @"Atlantic", @"Central", @"East", @"Midwest", @"South", @"SouthCentral", @"SouthEast", @"West", nil];

    }
    return _regionStrings;
}

+(regionCode) convertFromString: whichRegion {
    regionCode code = All;
    
    NSArray* words = [whichRegion componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceCharacterSet]];
    NSString* nospacestring = [words componentsJoinedByString:@""];

    for (id regionString in self.regionStrings) {
        NSString *regionStringToMatch = (NSString *)regionString;
        // NSComparisonResult matchResult1 = [regionStringToMatch localizedCaseInsensitiveCompare: whichRegion];
        // NSComparisonResult matchResult2 = (regionStringToMatch && [regionStringToMatch caseInsensitiveCompare:whichRegion]);
        NSString *uc1 = [nospacestring uppercaseString];
        NSString *uc2 = [regionStringToMatch uppercaseString];
        if([uc1 isEqualToString: uc2]) {
            return code;
        }
        code ++;
    }

    return All;
}
+(NSString*) convertToString:(regionCode) whichRegion {
    NSString *result = nil;
    
    switch(whichRegion) {
        case All:
            result = @"All";
            break;
        case Atlantic:
            result = @"ATLANTIC";
            break;
        case Central:
            result = @"CENTRAL";
            break;
        case East:
            result = @"EAST";
            break;
        case Midwest:
            result = @"MIDWEST";
            break;
        case South:
            result = @"SOUTH";
            break;
        case SouthCentral:
            result = @"SOUTH CENTRAL";
            break;
        case SouthEast:
            result = @"SOUTHEAST";
            break;
        case West:
            result = @"WEST";
            break;
        default:
            result = @"unknown";
    }
    
    return result;
}
@end
