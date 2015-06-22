//
//  RankingsViewController.h
//  NCAA App
//
//  Created by Hassan Al Rawi on 1/9/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"



@protocol RankingsViewControllerDelegate <NSObject>

@end


@interface RankingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,RegionSettingsDelegate>
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UITableView *rankingsTableView;
@property (nonatomic, assign) id delegate;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property regionCode usersRegionCode;

@end
