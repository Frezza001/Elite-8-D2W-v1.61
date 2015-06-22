//
//  ViewController.m
//  NCAA App
//
//  Created by Hassan Al Rawi on 12/11/13.
//  Copyright (c) 2013 Hassan Al Rawi. All rights reserved.
//

#import "MainVewController.h"
#import "SlidingMainMenuViewController.h"
@interface MainVewController () <SlidingMainMenuViewControllerProtocol>
@property (nonatomic, strong) SlidingMainMenuViewController *slidingMainMenuViewController;

@end

@implementation MainVewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setupView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupView {
    self.slidingMainMenuViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SlidingMainMenu"];
    self.slidingMainMenuViewController.delegate = self;
    
    [self.view addSubview:self.slidingMainMenuViewController.mainMenuView];
    [self addChildViewController:_slidingMainMenuViewController];
    
    [_slidingMainMenuViewController didMoveToParentViewController:self];
}

-(void)showSlidingMainMenu {
    
}

-(void)hideSlidingMainMenu {
    
}
@end
