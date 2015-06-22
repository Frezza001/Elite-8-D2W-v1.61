//
//  WebViewViewController.h
//  NCAA App
//
//  Created by Hassan Al Rawi on 1/13/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>

@interface WebViewViewController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSURL *viewedURL;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *acttivityIndicator;
@property (weak, nonatomic) IBOutlet UIView *loadingView;

@end
