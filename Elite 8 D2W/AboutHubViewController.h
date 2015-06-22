//
//  AboutHubViewController.h
//  NCAA App
//
//  Created by Hassan Al Rawi on 1/9/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AboutViewControllerDelegate <NSObject>

@end

@interface AboutHubViewController : UIViewController
@property (nonatomic, assign) id delegate;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollArea;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIButton *headerButton;
@end
