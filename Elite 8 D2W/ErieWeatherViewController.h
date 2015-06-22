//
//  ErieWeatherViewController.h
//  NCAA App
//
//  Created by Hassan Al Rawi on 1/8/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ErieWeatherProtocolDelegate <NSObject>

@end

@interface ErieWeatherViewController : UIViewController
@property (nonatomic, assign) id delegate;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@end
