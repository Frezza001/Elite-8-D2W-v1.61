//
//  ScheduleViewController.m
//  NCAA App
//
//  Created by Hassan Al Rawi on 1/9/14.
//  Copyright (c) 2014 Hassan Al Rawi. All rights reserved.
//

#import "ScheduleViewController.h"

@interface ScheduleViewController ()

@end

@implementation ScheduleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupScrollView];
    self.view.backgroundColor = [UIColor clearColor];
    self.mainView.frame = CGRectMake(10, 75, 300, 760);
    [[self.mainView layer] setShadowOffset:CGSizeMake(5, 0)];
    [[self.mainView layer] setShadowColor:[[UIColor darkGrayColor] CGColor]];
    [[self.mainView layer] setShadowRadius:3.0];
    [[self.mainView layer] setShadowOpacity:0.8];
    self.mainView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.mainView.bounds].CGPath;
    CALayer *layer = self.mainView.layer;
    layer.cornerRadius = 10.0f;
	// Do any additional setup after loading the view.
}

-(void) setupScrollView {
    [self.mainScrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.mainView.frame.size.height + 150)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
