//
//  AboutHubViewController.m
//  NCAA App
//
//  Created by Hassan Al Rawi on 1/9/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import "AboutHubViewController.h"
#import "WebViewViewController.h"

@interface AboutHubViewController ()

@end

@implementation AboutHubViewController

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
    [self setViewStyle];
    [self setupScrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setViewStyle
{
    self.view.backgroundColor = [UIColor clearColor];
    [[self.mainView layer] setShadowOffset:CGSizeMake(5, 0)];
    [[self.mainView layer] setShadowColor:[[UIColor darkGrayColor] CGColor]];
    [[self.mainView layer] setShadowRadius:3.0];
    [[self.mainView layer] setShadowOpacity:0.8];
    self.mainView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.mainView.bounds].CGPath;
    CALayer *layer = self.mainView.layer;
    layer.cornerRadius = 10.0f;
}
-(void) setupScrollView {
    [self.scrollArea setContentSize:CGSizeMake(self.view.frame.size.width, self.mainView.frame.size.height + 250)];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WebViewViewController * wvvc = [segue destinationViewController];
    NSURL * selectedURL = [[NSURL alloc] initWithString:@"http://www.gannon.edu/Academic-Offerings/Engineering-and-Business/Undergraduate/Software-Engineering/"];
    NSString *title = @"About Us";
    [wvvc setTitle:title];
    [wvvc setViewedURL:selectedURL];
}
@end
