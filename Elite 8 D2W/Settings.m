//
//  Settings.m
//  Elite 8 D2W
//
//  Created by GannonCIS on 3/5/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//  This is for static storage of settings used in the Elite 8 D2A App
//

#import "Settings.h"

static NSString * const SettingsRegionKey = @"SettingsRegionKey";
static NSString * const SettingsCountdownKey = @"SettingsCountdownKey";

@implementation Settings

- (id)init
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
    
    //    return [self initWithTitle:nil author:nil publicationDate:nil];
}

// Designated Initializer

- (id)initWithRegion:(NSString *)aRegion
           countdown:(NSString *)aCoundown {
    self = [super init];
    if (self) {
        
        _region = aRegion;
        _countdown = aCoundown;
    }
    
    return self;
}

+ (instancetype)settingWithRegion:(NSString *)aRegion
                        countdown:(NSString *)aCountdown {
    
    return [[self alloc] initWithRegion:aRegion
                              countdown:aCountdown];
    
}

#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    
    if (self) {
        _region = [aDecoder decodeObjectForKey:SettingsRegionKey];
        _countdown = [aDecoder decodeObjectForKey:SettingsCountdownKey];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.region forKey:SettingsRegionKey];
    [aCoder encodeObject:self.countdown forKey:SettingsCountdownKey];
}


@end
