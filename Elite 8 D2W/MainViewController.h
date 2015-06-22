//
//  ViewController.h
//  NCAA App
//
//  Created by Hassan Al Rawi on 12/11/13.
//  Copyright (c) 2013 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"

@interface MainViewController : UIViewController <SettingsDelegate>
- (IBAction)showSideMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundPicture;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@end
