//
//  LocalContributorsViewController.h
//  NCAA App
//
//  Created by Hassan Al Rawi on 1/9/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ErieLocalContributorsDelegate <NSObject>

@end

@interface LocalContributorsViewController : UIViewController
@property (nonatomic, assign) id delegate;
@end
