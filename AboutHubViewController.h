//
//  AboutHubViewController.h
//  NCAA App
//
//  Created by Hassan Al Rawi on 1/9/14.
//  Copyright (c) 2014 Hassan Al Rawi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AboutViewControllerDelegate <NSObject>

@end

@interface AboutHubViewController : UIViewController
@property (nonatomic, assign) id delegate;
@end
