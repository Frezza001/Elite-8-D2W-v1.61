//
//  Settings.h
//  Elite 8 D2W
//
//  Created by GannonCIS on 3/5/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject
@property (strong, nonatomic, readonly) NSString *region;
@property (strong, nonatomic, readonly) NSString *countdown;

- (id)initWithRegion:(NSString *)aRegion
             countdown:(NSString *)aCoundown;

+ (instancetype)settingWithRegion:(NSString *)aRegion
                       countdown:(NSString *)aCountdown;

@end
