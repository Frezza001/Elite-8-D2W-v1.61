//
//  ViewController.m
//  NCAA App
//
//  Created by Hassan Al Rawi on 12/11/13.
//  Copyright (c) 2013 Gannon University. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "MainViewController.h"
#import "SlidingMainMenuViewController.h"
#import "NewFeedViewController.h"
#import "ErieHubViewController.h"
#import "Elite8MenuViewController.h"
#import "ErieWeatherViewController.h"
#import "TicketsViewController.h"
#import "ArenaViewController.h"
#import "LocalContributorsViewController.h"
#import "MapsViewController.h"
#import "TwitterViewController.h"
#import "CoachesPollViewController.h"
#import "RankingsViewController.h"
#import "BracketViewController.h"
#import "ScheduleViewController.h"
#import "AboutHubViewController.h"
#import "SettingsViewController.h"
#import "SettingsModel.h"

#define MENU_TAG 1
#define NEWS_TAG 2
#define ERIE_HUB_TAG 3
#define ELITE_8_HUB 4
#define ERIE_WEATHER 5
#define TICKETS_TAG 6
#define ERIE_ARENA_TAG 7
#define ERIE_LOCAL_CONTRIBUTORS_TAG 8
#define ERIE_MAPS_TAG 9
#define TWITTER_FEED_TAG 10
#define COACHES_POLL_TAG 11
#define RANKINGS_TAG 12
#define BRACKET_TAG 13
#define SCHEDULE_TAG 14
#define SETTINGS_TAG 15
#define ABOUT_US_TAG 16
#define degreesToRadian(X) (M_PI * (X)/180.0)

#define SLIDE_TIMING .25
#define SLIDE_TIMING_FOR_VIEWS .40
#define MENU_HEIGHT 50
#define HIDING_TIMING .25

#define MENU_ARRAY_SIZE 10


@interface MainViewController () <SlidingMainMenuViewControllerProtocol, newsFeedViewControllerProtocol, ErieHubViewControllerDelegate, Elite8MenuViewControllerDelegate, ErieWeatherProtocolDelegate, TicketsDelegate, ErieArenaDelegate, ErieLocalContributorsDelegate, ErieMapsDelegate, TwitterViewControllerDelecate, CoachesPollViewControllerDelegate, RankingsViewControllerDelegate, BracketViewControllerDelegate, ScheduleViewControllerDelegate, AboutViewControllerDelegate, CountdownSettingsDelegate, RankingsViewControllerDelegate>

@property (nonatomic, strong) Elite8MenuViewController *elite8HubViewController;
@property (nonatomic, strong) ErieHubViewController *erieHubViewController;
@property (nonatomic, strong) NewFeedViewController *newsFeedViewContoller;
@property (nonatomic, strong) SlidingMainMenuViewController *slidingMainMenuViewController;
@property (nonatomic, strong) ErieWeatherViewController *erieWeatherViewController;
@property (nonatomic, strong) TicketsViewController *ticketsViewController;
@property (nonatomic, strong) ArenaViewController * erieArenaViewController;
@property (nonatomic, strong) LocalContributorsViewController * erieLocalContributorsViewController;
@property (nonatomic, strong) MapsViewController * erieMapsViewController;
@property (nonatomic, strong) TwitterViewController * twitterViewController;
@property (nonatomic, strong) CoachesPollViewController * coachesPollViewController;
@property (nonatomic, strong) RankingsViewController * rankingsViewController;
@property (nonatomic, strong) BracketViewController * bracketViewController;
@property (nonatomic, strong) ScheduleViewController * scheduleViewController;
@property (nonatomic, strong) AboutHubViewController * aboutUsViewController;
@property (nonatomic, strong) SettingsViewController * settingsViewController;

@property (nonatomic, strong) UIView * childView;
@property (nonatomic, assign) BOOL showPanel;
@property (nonatomic, assign) BOOL showingElite8Menu;
@property (nonatomic, assign) BOOL showingSideMenu;

@property (nonatomic, assign) BOOL viewBeingCalledBySwipe;
@property (nonatomic, assign) BOOL isItRightSwipe;
@property int pagecounter;
@property (nonatomic, strong) NSMutableArray * viewedMenuesArray;

@property (nonatomic, strong) NSOperationQueue *backgroundQueue;
@property (nonatomic, strong) id didEnterBackgroundObserver;

@end

@implementation MainViewController
@synthesize mySettings;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.viewedMenuesArray = [NSMutableArray arrayWithCapacity:MENU_ARRAY_SIZE];
    self.pagecounter = 1;
    [self setupNavigationBar];
    [self setupSlidingMenuView];
    [self setupGestures];
    [self setupBackgroundPicture];
    self.viewBeingCalledBySwipe = NO;
    self.showingElite8Menu = YES;
    self.showingSideMenu = NO;
    self.isItRightSwipe = YES;
    
    [self initializeSettings];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupGestures {
    UISwipeGestureRecognizer * previousViewSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight)];
    UISwipeGestureRecognizer * nextViewSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeLeft)];
    
    nextViewSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:previousViewSwipe];
    [self.view addGestureRecognizer:nextViewSwipe];
}

-(void) didSwipeRight {
    self.viewBeingCalledBySwipe = YES;
    self.isItRightSwipe = YES;
    if ([self.viewedMenuesArray count] > 0) {
        if (self.pagecounter > 0) {
            self.pagecounter = self.pagecounter - 1;
            [self viewSelectedMenu:[self.viewedMenuesArray objectAtIndex:self.pagecounter]];
        }
    } else {
        NSLog(@"Empty Menu Array");
    }
    
    NSLog(@"Page Counter: %i", self.pagecounter);
}

-(void) didSwipeLeft {
    self.viewBeingCalledBySwipe = YES;
    self.isItRightSwipe = NO;
    if ([self.viewedMenuesArray count] > 0) {
        if (self.pagecounter < [self.viewedMenuesArray count] - 1) {
            self.pagecounter = self.pagecounter + 1;
            [self viewSelectedMenu:[self.viewedMenuesArray objectAtIndex:self.pagecounter]];
        }
    } else {
        NSLog(@"Empty Menu Array");
    }
    NSLog(@"Page Counter: %i", self.pagecounter);
}

-(void)viewWillAppear:(BOOL)animated {
    [self setupNavigationBar];
}

-(void) setupNavigationBar {
    UIColor * mycolor = [UIColor colorWithRed:0.0 green:120.0/255.0 blue:239.0/255.0 alpha:1];
    
    [self.navigationController.navigationBar setBarTintColor:mycolor];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBarStyle: (UIBarStyle)UIStatusBarStyleLightContent];
//    [self.menuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.menuButton setImage:[UIImage imageNamed:@"Ap_Icons_Basketball_Lines.png"] forState:UIControlStateNormal];
    [self.navigationItem.backBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
}

-(void)setupSlidingMenuView {
    self.slidingMainMenuViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SlidingMainMenu"];
    self.slidingMainMenuViewController.view.tag = MENU_TAG;
    self.slidingMainMenuViewController.delegate = self;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    
    self.slidingMainMenuViewController.view.frame = CGRectMake(0, screenHeight - self.slidingMainMenuViewController.mainMenuView.frame.size.height, self.slidingMainMenuViewController.view.frame.size.width , self.slidingMainMenuViewController.view.frame.size.height);
    [self.view addSubview:self.slidingMainMenuViewController.view];
    [self addChildViewController:_slidingMainMenuViewController];
    
    [_slidingMainMenuViewController didMoveToParentViewController:self];
}

-(BOOL) isSelectedViewAlreadyBeenViewed: (NSString *) selectedMenu {
    for (NSString * viewedMenuName in self.viewedMenuesArray) {
        if ( viewedMenuName == selectedMenu ) {
            return YES;
        }
    }
    return NO;
}

-(void) viewSelectedMenu:(NSString *) menuName {
    [self hideSlidingMainMenu];
    
    if (self.viewBeingCalledBySwipe == NO) {
        
        if ([self.viewedMenuesArray count] == MENU_ARRAY_SIZE) {
            [self.viewedMenuesArray removeObjectAtIndex:0];
        }
        
        if ([self isSelectedViewAlreadyBeenViewed:menuName]) {
            int selectedViewIndex;
            for (int i=0; i < [self.viewedMenuesArray count]; i++) {
                if (menuName == [self.viewedMenuesArray objectAtIndex:i]) {
                    selectedViewIndex = i;
                }
            }
            [self.viewedMenuesArray exchangeObjectAtIndex:[self.viewedMenuesArray count] - 1 withObjectAtIndex:selectedViewIndex];
        } else {
            [self.viewedMenuesArray addObject:menuName];
            self.pagecounter = [self.viewedMenuesArray count] - 1.0f;
        }
    }
    
    NSLog(@"%@", [self.viewedMenuesArray description]);
    UIView * previousView;
    if (self.childView != nil) {
        previousView = self.childView;
        [UIView animateWithDuration:HIDING_TIMING
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^ {
                             previousView.alpha = 0.0f;
                         }
                         completion:^(BOOL finished) {
                         }];
    }
    
    if ([menuName isEqual: @"Elite8HubNews"] || [menuName isEqualToString:@"News"]) {
        
        self.childView = [self getPresentedMenu:@"News" withMenuTag:NEWS_TAG withAViewController:self.newsFeedViewContoller andMenuDelegate:self.newsFeedViewContoller.delegate];
        self.showingElite8Menu = YES;
        [self.menuButton setImage:[UIImage imageNamed:@"Ap_Icons_Basketball_Lines.png"] forState:UIControlStateNormal];
        [self showMenuButton];
        
    } else if ([menuName isEqualToString:@"Schedule"]) {
        self.childView = [self getPresentedMenu:@"Schedule" withMenuTag:SCHEDULE_TAG withAViewController:self.scheduleViewController andMenuDelegate:self.scheduleViewController.delegate];
        [self.menuButton setImage:[UIImage imageNamed:@"Ap_Icons_Basketball_Lines.png"] forState:UIControlStateNormal];
        self.showingElite8Menu = YES;
        [self showMenuButton];
        
    } else if ([menuName isEqualToString:@"Bracket"]) {
        self.childView = [self getPresentedMenu:@"Bracket" withMenuTag:BRACKET_TAG withAViewController:self.bracketViewController andMenuDelegate:self.bracketViewController.delegate];
        [self.menuButton setImage:[UIImage imageNamed:@"Ap_Icons_Basketball_Lines.png"] forState:UIControlStateNormal];
        self.showingElite8Menu = YES;
        [self showMenuButton];
        
    } else if ([menuName isEqualToString:@"Rankings"]) {
//        self.childView = [self getPresentedMenu:@"Rankings" withMenuTag:RANKINGS_TAG withAViewController:self.rankingsViewController andMenuDelegate:self.rankingsViewController.delegate];
        self.rankingsViewController = (RankingsViewController *)[self getPresentedMenuViewController:@"Rankings" withMenuTag:RANKINGS_TAG withAViewController:self.rankingsViewController andMenuDelegate:self.rankingsViewController.delegate];
        self.childView = self.rankingsViewController.view;
        self.settingsViewController.regionSettingDelegate = self.rankingsViewController;
        self.rankingsViewController.usersRegionCode = [self.mySettings getRegion];

        [self.menuButton setImage:[UIImage imageNamed:@"Ap_Icons_Basketball_Lines.png"] forState:UIControlStateNormal];
        self.showingElite8Menu = YES;
        [self showMenuButton];
        
    } else if ([menuName isEqualToString:@"Twitter"]) {
        self.childView = [self getPresentedMenu:@"Twitter" withMenuTag:TWITTER_FEED_TAG withAViewController:self.twitterViewController andMenuDelegate:self.twitterViewController.delegate];
        [self.menuButton setImage:[UIImage imageNamed:@"Ap_Icons_Basketball_Lines.png"] forState:UIControlStateNormal];
        self.showingElite8Menu = YES;
        [self showMenuButton];
        
    } else if ([menuName isEqualToString:@"Erie Hub"] || [menuName isEqualToString:@"Arena"]) {
        self.childView = [self getPresentedMenu:@"Arena" withMenuTag:ERIE_ARENA_TAG withAViewController:self.erieArenaViewController andMenuDelegate:self.erieArenaViewController.delegate];
        self.showingElite8Menu = NO;
        [self.menuButton setImage:[UIImage imageNamed:@"Ap_Icons_ErieHub_Lines.png"] forState:UIControlStateNormal];
        [self showMenuButton];

    } else if ([menuName isEqualToString:@"Tickets"]) {
        self.childView = [self getPresentedMenu:@"Tickets" withMenuTag:TICKETS_TAG withAViewController:self.ticketsViewController andMenuDelegate:self.ticketsViewController.delegate];
        if (self.showingElite8Menu == NO) {
            [self.menuButton setImage:[UIImage imageNamed:@"Ap_Icons_ErieHub_Lines.png"] forState:UIControlStateNormal];
        } else {
            [self.menuButton setImage:[UIImage imageNamed:@"Ap_Icons_Basketball_Lines.png"] forState:UIControlStateNormal];
        }
        [self showMenuButton];
        
    } else if ([menuName isEqualToString:@"Weather"]) {
        self.childView = [self getPresentedMenu:@"Weather" withMenuTag:ERIE_WEATHER withAViewController:self.erieWeatherViewController andMenuDelegate:self.erieWeatherViewController.delegate];
        [self.menuButton setImage:[UIImage imageNamed:@"Ap_Icons_ErieHub_Lines.png"] forState:UIControlStateNormal];
        self.showingElite8Menu = NO;
        [self showMenuButton];
        
    } else if ([menuName isEqualToString:@"Maps"]) {
        self.childView = [self getPresentedMenu:@"Maps" withMenuTag:ERIE_MAPS_TAG withAViewController:self.erieMapsViewController andMenuDelegate:self.erieMapsViewController.delegate];
        [self.menuButton setImage:[UIImage imageNamed:@"Ap_Icons_ErieHub_Lines.png"] forState:UIControlStateNormal];
        self.showingElite8Menu = NO;
        [self showMenuButton];
        
    } else if ([menuName isEqualToString:@"Contributors"]) {
        self.childView = [self getPresentedMenu:@"Contributors" withMenuTag:ERIE_LOCAL_CONTRIBUTORS_TAG withAViewController:self.erieLocalContributorsViewController andMenuDelegate:self.erieLocalContributorsViewController.delegate];
        [self.menuButton setImage:[UIImage imageNamed:@"Ap_Icons_ErieHub_Lines.png"] forState:UIControlStateNormal];
        self.showingElite8Menu = NO;
        [self showMenuButton];
        
    } else if ([menuName isEqualToString:@"Settings"]) {
        if (self.settingsViewController) {
            [self.settingsViewController loadView];
        }
        else {
        self.settingsViewController = (SettingsViewController *)[self getPresentedMenuViewController:@"Settings" withMenuTag:SETTINGS_TAG withAViewController:self.settingsViewController andMenuDelegate:self.settingsViewController.countdownDelegate];
        }
        self.childView = self.settingsViewController.view;
        self.settingsViewController.countdownDelegate = self;
        self.settingsViewController.regionSettingDelegate = self.rankingsViewController;
        self.settingsViewController.settingsMasterDelegate = self;
        [self.settingsViewController populateFromSettings];
        [self hideMenuButton];
        /*
        regionCode currentCode = self.settingsViewController.myRegionCode;
        if (currentCode != All) {
            [self.settingsViewController.regionSettingDelegate resetRegionSetting: currentCode];
        }
        */
    } else if ([menuName isEqualToString:@"About"]) {
        self.childView = [self getPresentedMenu:@"About" withMenuTag:ABOUT_US_TAG withAViewController:self.aboutUsViewController andMenuDelegate:self.aboutUsViewController.delegate];
        [self hideMenuButton];

    }
    
    [self hideSideMenu];
    
    [self.view insertSubview:self.childView belowSubview:self.slidingMainMenuViewController.view];
    
    [UIView animateWithDuration:SLIDE_TIMING_FOR_VIEWS
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^ {
                         self.childView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                     }];
    self.viewBeingCalledBySwipe = NO;
    [self performSelector:@selector(removePreviousView:) withObject:previousView afterDelay:0.35];
}

-(void) removePreviousView: (UIView *) previousView {
    [previousView removeFromSuperview];
}


- (UIView *) getPresentedMenu:(NSString *) menuIdentifer withMenuTag:(int) menuTag withAViewController:(UIViewController*) menuViewController andMenuDelegate:(id) menuDelegate {
    menuViewController = [[UIStoryboard   storyboardWithName:@"Main" bundle:Nil] instantiateViewControllerWithIdentifier:menuIdentifer];
    menuViewController.view.tag = menuTag;
    if (self.viewBeingCalledBySwipe == NO) {
        menuViewController.view.frame = CGRectMake(0, menuViewController.view.frame.size.height, menuViewController.view.frame.size.width, menuViewController.view.frame.size.height);
    } else if (self.isItRightSwipe == YES) {
        menuViewController.view.frame = CGRectMake(-menuViewController.view.frame.size.width, 0, menuViewController.view.frame.size.width, menuViewController.view.frame.size.height);
    } else if (self.isItRightSwipe == NO) {
        menuViewController.view.frame = CGRectMake(menuViewController.view.frame.size.width, 0, menuViewController.view.frame.size.width, menuViewController.view.frame.size.height);
    }
    menuDelegate = self;
    [self.view addSubview:menuViewController.view];
    [self addChildViewController:menuViewController];
    [menuViewController didMoveToParentViewController:self];
    
    // At this point the new View Controller is built; It needs to be assigned so it can be found and linked to.
    
    UIView *view = menuViewController.view;
    return view;
}
-(UIViewController*) getPresentedMenuViewController:(NSString *) menuIdentifer withMenuTag:(int) menuTag withAViewController:(UIViewController*) menuViewController andMenuDelegate:(id) menuDelegate {
    menuViewController = [[UIStoryboard   storyboardWithName:@"Main" bundle:Nil] instantiateViewControllerWithIdentifier:menuIdentifer];
    menuViewController.view.tag = menuTag;
    if (self.viewBeingCalledBySwipe == NO) {
        menuViewController.view.frame = CGRectMake(0, menuViewController.view.frame.size.height, menuViewController.view.frame.size.width, menuViewController.view.frame.size.height);
    } else if (self.isItRightSwipe == YES) {
        menuViewController.view.frame = CGRectMake(-menuViewController.view.frame.size.width, 0, menuViewController.view.frame.size.width, menuViewController.view.frame.size.height);
    } else if (self.isItRightSwipe == NO) {
        menuViewController.view.frame = CGRectMake(menuViewController.view.frame.size.width, 0, menuViewController.view.frame.size.width, menuViewController.view.frame.size.height);
    }
    menuDelegate = self;
    [self.view addSubview:menuViewController.view];
    [self addChildViewController:menuViewController];
    [menuViewController didMoveToParentViewController:self];
    
    return menuViewController;
}


-(void)showSlidingMainMenu {
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGFloat screenHeight = screenRect.size.height;
    
    [UIView animateWithDuration:SLIDE_TIMING
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^ {
                         _slidingMainMenuViewController.view.frame = CGRectMake(0, screenHeight - self.slidingMainMenuViewController.mainMenuView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         _slidingMainMenuViewController.menuButtonStatus.tag = 0;
                     }];
}

-(void)hideSlidingMainMenu {
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGFloat screenHeight = screenRect.size.height;
    
    [UIView animateWithDuration:SLIDE_TIMING
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^ {
                         _slidingMainMenuViewController.view.frame = CGRectMake(0, screenHeight-MENU_HEIGHT, self.slidingMainMenuViewController.view.frame.size.width, self.slidingMainMenuViewController.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         
                         if (finished) {
                             _slidingMainMenuViewController.menuButtonStatus.tag = 1;
                         }
                     }];
}


- (void) setupShadowsForView:(UIView *) selectedSideMenu {
    [[selectedSideMenu layer] setShadowOffset:CGSizeMake(-2, 2)];
    [[selectedSideMenu layer] setShadowColor:[[UIColor darkGrayColor] CGColor]];
    [[selectedSideMenu layer] setShadowRadius:3.0];
    [[selectedSideMenu layer] setShadowOpacity:0.8];
    selectedSideMenu.layer.shadowPath = [UIBezierPath bezierPathWithRect:selectedSideMenu.bounds].CGPath;
}

- (UIView *) getErieHubMenu {
//    NSLog(@"Getting Erie Hub");
    self.erieHubViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:Nil] instantiateViewControllerWithIdentifier:@"ErieHubViewController"];
    self.erieHubViewController.view.tag = ERIE_HUB_TAG;
    self.erieHubViewController.delegate = self;
    [self setupShadowsForView:self.erieHubViewController.mainView];
    [self.view addSubview:self.erieHubViewController.view];
    [self addChildViewController:_erieHubViewController];
    [_erieHubViewController didMoveToParentViewController:self];
    
    UIView *view = self.erieHubViewController.view;
    view.alpha = 0.0f;
    [UIView animateWithDuration:HIDING_TIMING
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^ {
                         view.alpha = 1.0f;
                     }
                     completion:^(BOOL finished) {
                     }];
    return view;
}

- (UIView *) getElite8HubMenu {
//    NSLog(@"Getting Elite 8 Hub");
    self.elite8HubViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:Nil] instantiateViewControllerWithIdentifier:@"Elite8HubViewController"];
    self.elite8HubViewController.view.tag = ELITE_8_HUB;
    self.elite8HubViewController.delegate = self;
    self.elite8HubViewController.view.frame = CGRectMake(0, 0, self.elite8HubViewController.view.frame.size.width, self.elite8HubViewController.view.frame.size.height);
    [self setupShadowsForView:self.elite8HubViewController.mainView];
    [self.view addSubview:self.elite8HubViewController.view];
    
    [self addChildViewController:_elite8HubViewController];
    [_elite8HubViewController didMoveToParentViewController:self];
    
    UIView *view = self.elite8HubViewController.view;
    
    view.alpha = 0.0f;
    [UIView animateWithDuration:HIDING_TIMING
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^ {
                         view.alpha = 1.0f;
                     }
                     completion:^(BOOL finished) {
                     }];
    return view;
}


- (void)hideSideMenu {
    [UIView animateWithDuration:HIDING_TIMING
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^ {
                         self.elite8HubViewController.view.alpha = 0.0f;
                         self.erieHubViewController.view.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                     }];
    UIView *previousView;
    if (self.showingElite8Menu) {
        previousView = self.elite8HubViewController.view;
    } else if (!self.showingElite8Menu) {
        previousView = self.erieHubViewController.view;
    }
    [self performSelector:@selector(removePreviousView:) withObject:previousView afterDelay:0.35];
    self.showingSideMenu = NO;
}


- (IBAction)showSideMenu:(id)sender {
//    NSLog(@"Menu Button Pressed");
    if (!self.slidingMainMenuViewController.menuButtonStatus.tag == 1) {
        [self hideSlidingMainMenu];
    }
    if (!self.showingSideMenu) {
        if (self.showingElite8Menu) {
//            NSLog(@"Going to show Elite 8 Menu");
            [self getElite8HubMenu];
            self.showingElite8Menu = YES;
        } else if (!self.showingElite8Menu) {
//            NSLog(@"Going to show Elite 8 Menu");
            [self getErieHubMenu];
            self.showingElite8Menu = NO;
        }
        self.showingSideMenu = YES;
    } else {
        [self hideSideMenu];
        self.showingSideMenu = NO;
    }
}

-(void) hideMenuButton {
    self.menuButton.hidden = YES;
    self.menuButton.userInteractionEnabled = NO;
}

-(void) showMenuButton {
    self.menuButton.hidden = NO;
    self.menuButton.userInteractionEnabled = YES;
}

-(BOOL) isItIPhone5 {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    if (screenHeight > 567) {
        return YES;
    }
    return NO;
}


-(void) setupBackgroundPicture {
    if ([self isItIPhone5]) {
        UIImage * backgroundImage = [UIImage imageNamed:@"LunchImage4-01.png"];
        [self.backgroundPicture setImage:backgroundImage];
    } else if (![self isItIPhone5]) {
        UIImage * backgroundImage = [UIImage imageNamed:@"Startup Image.png"];
        [self.backgroundPicture setImage:backgroundImage];
    }
}

-(void) showCountdown {
    NSLog(@"At Main, Calling Show Countdown");
    self.slidingMainMenuViewController.countdownView.hidden = NO;
}

-(void) hideCountdown {
        NSLog(@"At Main, Calling Hide Countdown");
    self.slidingMainMenuViewController.countdownView.hidden = YES;
}


#pragma mark Settings Management
-(void) initializeSettings {
    self.backgroundQueue = [[NSOperationQueue alloc] init];

    self.didEnterBackgroundObserver =
    [[NSNotificationCenter defaultCenter]
     addObserverForName:UIApplicationDidEnterBackgroundNotification
     object:[UIApplication sharedApplication]
     queue:[NSOperationQueue mainQueue]
     usingBlock:^(NSNotification *note) {
         [self saveSettings];
     }];
    
    self.mySettings = [[SettingsModel alloc] init];
    [self.mySettings loadSettingsFromFile]; // Slow
    if(![self.mySettings getCountdown]) {
        [self hideCountdown];
    }
}
- (void)saveSettings {
    [self.backgroundQueue
     addOperationWithBlock:^{
         [self.mySettings saveSettingsToFile];
     }];
}

- (void)loadSettings {
    [self.backgroundQueue
     addOperationWithBlock:^{
         if (self.mySettings) {
             [[NSOperationQueue mainQueue]
              addOperationWithBlock:^{
                  [self.mySettings loadSettingsFromFile ];
              }];
         }
     }];
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
@end
