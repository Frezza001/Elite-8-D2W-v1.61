//
//  NewFeedViewController.h
//  NCAA App
//
//  Created by Hassan Al Rawi on 12/17/13.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol newsFeedViewControllerProtocol <NSObject>

@optional
-(void) hideMenu;
-(void) showMenu;
@end

@interface NewFeedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) id delegate;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITableView *newsTableView;

@end
