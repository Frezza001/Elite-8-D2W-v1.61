//
//  MapsViewController.h
//  NCAA App
//
//  Created by Hassan Al Rawi on 1/9/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ErieMapsDelegate <NSObject>

@end

@interface MapsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) id delegate;
@end
