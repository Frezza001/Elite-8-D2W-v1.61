//
//  WeatherMenuViewController.h
//  NCAA App
//
//  Created by Hassan Al Rawi on 12/16/13.
//  Copyright (c) 2013 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WeatherMenuProtocol <NSObject>

@required


@optional
-(void) hideWeatherMenu;
@end

@interface WeatherMenuViewController : UIViewController <WeatherMenuProtocol>
@property (nonatomic, assign) id delegate;
@end
