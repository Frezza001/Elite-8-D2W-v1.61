//
//  ErieWeatherViewController.m
//  NCAA App
//
//  Created by Hassan Al Rawi on 1/8/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import "ErieWeatherViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ErieWeatherViewController ()

@end

@implementation ErieWeatherViewController

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
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    CALayer *layer = self.mainView.layer;
    layer.cornerRadius = 10.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
