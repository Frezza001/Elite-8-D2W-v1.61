//
//  WebViewViewController.m
//  NCAA App
//
//  Created by Hassan Al Rawi on 1/13/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import "WebViewViewController.h"

@interface WebViewViewController ()

@end

@implementation WebViewViewController
@synthesize viewedURL;

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
//    NSLog(@"The URL in webview is: %@", viewedURL);
    
    //    self.loadingLabel.hidden = YES;
    [super viewDidLoad];
    //    NSLog(@"The URL in webview is: %@", viewedURL);
    self.webView.delegate = self;
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:viewedURL];
    self.webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.webView.scalesPageToFit = YES;
    //    NSLog(@"%@", [requestObj description]);
    //    NSLog(@"%@", [viewedURL description]);
    [self.webView loadRequest:requestObj];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    CALayer *layer = self.loadingView.layer;
    layer.cornerRadius = 10.0f;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    self.loadingView.alpha = 0.0f;
    self.acttivityIndicator.alpha = 0.0f;
    [UILabel animateWithDuration:0.2f
                      animations:^{
                          [self.acttivityIndicator startAnimating];
                          self.loadingView.alpha = 1.0f;
                          self.acttivityIndicator.alpha = 1.0f;
                      }
                      completion:^(BOOL finished){
                          self.loadingView.hidden = NO;
                          self.acttivityIndicator.hidden = NO;
                      }];
    
    
}


-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [UILabel animateWithDuration:0.2f
                      animations:^{
                          self.loadingView.alpha = 0.0f;
                          self.acttivityIndicator.alpha = 0.0f;
                      }
                      completion:^(BOOL finished){
                          self.loadingView.hidden = YES;
                          self.acttivityIndicator.hidden = YES;
                      }];
}


@end
