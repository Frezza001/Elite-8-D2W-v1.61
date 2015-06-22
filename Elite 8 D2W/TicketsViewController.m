//
//  TicketsViewController.m
//  NCAA App
//
//  Created by Hassan Al Rawi on 1/9/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import "TicketsViewController.h"
#import "WebViewViewController.h"

#import <QuartzCore/QuartzCore.h>
@interface TicketsViewController ()

@end

@implementation TicketsViewController

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
//    [self setupBuyButtonColors];
    self.mainView.frame = CGRectMake(10, 75, 300, 222);
    self.view.backgroundColor = [UIColor clearColor];
    [[self.mainView layer] setShadowOffset:CGSizeMake(5, 0)];
    [[self.mainView layer] setShadowColor:[[UIColor darkGrayColor] CGColor]];
    [[self.mainView layer] setShadowRadius:3.0];
    [[self.mainView layer] setShadowOpacity:0.8];
    self.mainView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.mainView.bounds].CGPath;
    CALayer *layer = self.mainView.layer;
    layer.cornerRadius = 10.0f;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WebViewViewController *wbvc = [segue destinationViewController];
    NSURL *viewUrl = [NSURL URLWithString:@"http://purchase.tickets.com/buy/TicketPurchase?&pid=7556229"];
    [wbvc setTitle:@"Buy Tickets"];
    
    [wbvc setViewedURL:viewUrl];
    NSLog(@"%@", viewUrl);
}

@end
