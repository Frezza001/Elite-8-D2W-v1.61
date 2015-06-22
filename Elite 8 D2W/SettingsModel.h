//
//  SettingsModel.h
//  Elite 8 D2W
//
//  Created by GannonCIS on 3/5/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Settings.h"
#import "RegionDefinitions.h"

@interface SettingsModel : NSObject
- (void)saveSettingsToFile;
- (void)loadSettingsFromFile;

- (void)saveRegion: (regionCode) region;
- (void)saveCountdownState:(BOOL) state;

- (regionCode)getRegion;
- (BOOL)getCountdown;
@end
