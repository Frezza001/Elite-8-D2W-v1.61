//
//  ScheduleViewController.h
//  NCAA App
//
//  Created by Hassan Al Rawi on 1/9/14.
//  Copyright (c) 2014 Hassan Al Rawi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScheduleViewControllerDelegate <NSObject>

@end

@interface ScheduleViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (nonatomic, assign) id delegate;
@end
