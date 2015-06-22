//
//  BracketViewController.h
//  NCAA App
//
//  Created by Hassan Al Rawi on 1/9/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BracketViewControllerDelegate <NSObject>

@end

@interface BracketViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (nonatomic, assign) id delegate;
@end
