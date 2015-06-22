//
//  ErieHubViewController.h
//  NCAA App
//
//  Created by Hassan Al Rawi on 1/7/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ErieHubViewControllerDelegate <NSObject>

@optional
-(void)hideSideMenu;
-(void) viewSelectedMenu:(NSString *) menuName;

@end


@interface ErieHubViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) id delegate;
@property (nonatomic, strong) NSArray * erieMenusArray;
@property (weak, nonatomic) IBOutlet UITableView *erieHubTableView;
@property (weak, nonatomic) IBOutlet UIView *mainView;

- (IBAction)hideMenu:(id)sender;
@end
