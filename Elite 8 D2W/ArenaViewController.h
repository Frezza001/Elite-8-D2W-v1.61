//
//  ArenaViewController.h
//  NCAA App
//
//  Created by Hassan Al Rawi on 1/9/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ErieArenaDelegate <NSObject>

@end

@interface ArenaViewController : UIViewController
@property (nonatomic, assign) id delegate;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIButton *moreInfoButton;
@property (weak, nonatomic) IBOutlet UIImageView *arenaLogo;
@property (weak, nonatomic) IBOutlet UILabel *arenaName;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@end
