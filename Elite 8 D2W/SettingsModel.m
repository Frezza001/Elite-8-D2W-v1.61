//
//  SettingsModel.m
//  Elite 8 D2W
//
//  Created by GannonCIS on 3/5/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import "SettingsModel.h"
static NSString *settingsFileName = @"elite8d2a_settings.data";

@interface SettingsModel ()
@property (nonatomic, strong) Settings *mySettings;
@end

@implementation SettingsModel
- (void)saveSettingsToFile {
    
    NSURL *url = [self urlForDataFile];
    NSMutableDictionary *rootObject;
    rootObject = [NSMutableDictionary dictionary];
    [rootObject setValue:self.mySettings forKey:@"mySettings"];
    [NSKeyedArchiver archiveRootObject:rootObject toFile:[url path]];
}

- (void)loadSettingsFromFile {
    NSURL *url = [self urlForDataFile];
    NSMutableDictionary *rootObject;
    rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:[url path]];
    
    if ([rootObject valueForKey:@"mySettings"]) {
        self.mySettings = [rootObject valueForKey:@"mySettings"];
    } else {
        self.mySettings= [[Settings alloc] initWithRegion: @"All" countdown: @"YES"];
    }
}

- (void)saveRegion: (regionCode) region {
    NSString *regionString = [RegionDefinitions convertToString:region];
    self.mySettings = [[Settings alloc] initWithRegion:regionString countdown:self.mySettings.countdown];
}

- (void)saveCountdownState:(BOOL) state {
    NSString *boolString = [NSString stringWithFormat:@"%s", (state ? "YES" : "NO") ];
    self.mySettings = [[Settings alloc] initWithRegion:self.mySettings.region countdown: boolString];
}
- (regionCode)getRegion {
    return [RegionDefinitions convertFromString:self.mySettings.region];
}
- (BOOL)getCountdown {
    NSString *uc1 = [self.mySettings.countdown uppercaseString];
    NSString *uc2 = @"YES";
    if([uc1 isEqualToString: uc2]) {
        return YES;
    }
    return NO;
}
#pragma mark - Private Methods
- (NSURL *)urlForDataFile {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSArray *directories =
    [manager URLsForDirectory:NSDocumentDirectory
                    inDomains:NSUserDomainMask];
    NSURL *directory = [directories lastObject];
    
    return [directory URLByAppendingPathComponent:settingsFileName];
}

@end
