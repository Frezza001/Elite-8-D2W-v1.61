//
//  Elite8MenuViewController.h
//  NCAA App
//
//  Created by Hassan Al Rawi on 1/7/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Elite8MenuViewControllerDelegate <NSObject>

@optional
-(void) hideSideMenu;
-(void) viewSelectedMenu:(NSString *) menuName;

@end

@interface Elite8MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) id delegate;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (nonatomic, strong) NSArray* elite8MenusArray;
- (IBAction)hideMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *elite8TableView;
@end
