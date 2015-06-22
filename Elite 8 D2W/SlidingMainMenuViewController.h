//
//  SlidingMainMenuViewController.h
//  NCAA App
//
//  Created by Hassan Al Rawi on 12/11/13.
//  Copyright (c) 2013 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlidingMainMenuViewControllerProtocol <NSObject>

@optional
-(void) hideSlidingMainMenu;

@required
-(void) showSlidingMainMenu;
-(void) viewSelectedMenu:(NSString *) menuName;

@end

@interface SlidingMainMenuViewController : UIViewController <UIScrollViewDelegate>
- (IBAction)viewHubs:(id)sender;
- (IBAction)menuButton:(id)sender;
- (IBAction)changePage;

@property (nonatomic, strong) NSTimer* slidingMenuTimer;
@property (weak, nonatomic) IBOutlet UIButton *menuButtonStatus;
@property (weak, nonatomic) IBOutlet UIView *mainMenuView;
@property (nonatomic, assign) id <SlidingMainMenuViewControllerProtocol> delegate;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollingMenu;
@property (weak, nonatomic) IBOutlet UIPageControl *pageIndicator;

@property (weak, nonatomic) IBOutlet UILabel *daysLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *minutesLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondsLabel;
@property (weak, nonatomic) IBOutlet UIView *countdownView;


@end
