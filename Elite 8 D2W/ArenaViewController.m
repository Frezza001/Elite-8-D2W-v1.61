//
//  ArenaViewController.m
//  NCAA App
//
//  Created by Hassan Al Rawi on 1/9/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//
#import "WebViewViewController.h"
#import "ArenaViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ArenaViewController ()

@end

@implementation ArenaViewController

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
    self.mainView.frame = CGRectMake(10, 75, 300, 574);
    [[self.mainView layer] setShadowOffset:CGSizeMake(5, 0)];
    [[self.mainView layer] setShadowColor:[[UIColor darkGrayColor] CGColor]];
    [[self.mainView layer] setShadowRadius:3.0];
    [[self.mainView layer] setShadowOpacity:0.8];
    self.mainView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.mainView.bounds].CGPath;
    CALayer *layer = self.mainView.layer;
    layer.cornerRadius = 10.0f;
    [self setupLogo];
//    [self setupMoreButtonColors];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupLogo {
    UIImage * logo = [UIImage imageNamed:@"EIAlogo-color copy.jpg"];
    [self.arenaLogo setImage:logo];
}


-(void) setupScrollView {
    [self.mainScrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.mainView.frame.size.height + 150)];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WebViewViewController *wbvc = [segue destinationViewController];
    NSURL *viewUrl = [NSURL URLWithString:@"http://www.erieevents.com/about/tullio_arena.htm"];
    [wbvc setTitle:@"Arena"];
    [wbvc setViewedURL:viewUrl];
        NSLog(@"%@", viewUrl);
}

@end
