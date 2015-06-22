//
//  NewFeedViewController.m
//  NCAA App
//
//  Created by Hassan Al Rawi on 12/17/13.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import "NewFeedViewController.h"
#import "NewsCustomCell.h"
#import "WebViewViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface NewFeedViewController ()
@property (strong, nonatomic) NSMutableArray *newsList;
@property (nonatomic) CGFloat height;
@end

@implementation NewFeedViewController

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
    self.newsList = [[NSMutableArray alloc] init];
    [self setupNews];
    [super viewDidLoad];
    self.contentView.frame = CGRectMake(10, 40, 300, self.view.frame.size.height);
    self.newsTableView.frame = CGRectMake(0, 0, 300, self.view.frame.size.height - 60);
//    NSLog(@"News View DID Load");
    self.newsTableView.backgroundColor = [UIColor clearColor];
    self.newsTableView.dataSource = self;
    self.newsTableView.delegate = self;
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.newsList count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 330;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"newsCell";
    NewsCustomCell *newsCell = [self.newsTableView  dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!newsCell) {
        newsCell = [[NewsCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    newsCell.contentURL = [[self.newsList objectAtIndex:indexPath.section] objectForKey:@"newsURL"];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    UIFont * myFont = [UIFont boldSystemFontOfSize:newsCell.newsCellTitle.font.pointSize];
    NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
                                         NSForegroundColorAttributeName:[UIColor whiteColor],
                                         NSFontAttributeName: myFont};
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:[[self.newsList objectAtIndex:indexPath.section] objectForKey:@"title"] attributes:underlineAttribute];
    
    if (newsCell.contentURL != NULL) {
        newsCell.newsCellTitle.attributedText = attributedString;
    }   else {
        newsCell.newsCellTitle.text = [[self.newsList objectAtIndex:indexPath.section] objectForKey:@"title"];
    }
  
    
    newsCell.newsCellTitle.textAlignment = NSTextAlignmentCenter;
    newsCell.segueButton.tag = indexPath.section;
    if (newsCell.contentURL) { // Conditionally underline the title
        newsCell.newsCellTitle.backgroundColor = [UIColor orangeColor];
    }
    newsCell.newsCellTitle.clipsToBounds = NO;
    [newsCell setupPicture:[[self.newsList objectAtIndex:indexPath.section] objectForKey:@"newsPicture"]];
    newsCell.newsCellDetails.text = [[self.newsList objectAtIndex:indexPath.section] objectForKey:@"description"];
    
    [[newsCell layer] setShadowOffset:CGSizeMake(5, 5)];
    [[newsCell layer] setShadowColor:[[UIColor darkGrayColor] CGColor]];
    [[newsCell layer] setShadowRadius:3.0];
    [[newsCell layer] setShadowOpacity:0.8];
    newsCell.layer.shadowPath = [UIBezierPath bezierPathWithRect:newsCell.bounds].CGPath;
    
    CALayer *layer = newsCell.layer;
    layer.cornerRadius = 10.0f;
    return newsCell;
}

-(void) setupNews {
    NSMutableDictionary *newNewsItem1 = [[NSMutableDictionary alloc] init];
    UIImage *newsImage = [UIImage imageNamed:@"KnightFullColor.png"];
    [newNewsItem1 setObject:@"Elite Eight - Women's D2" forKey:@"title"];
    [newNewsItem1 setObject:@"ERIE, Pa. – The City of Erie and Gannon University will be in the national spotlight in March of 2014. The National Collegiate Athletic Association (NCAA) has awarded the 2014 Division II Women's Basketball Elite Eight to Erie, Pennsylvania with Gannon University serving as the host" forKey:@"description"];
    NSURL *newsURL = [NSURL URLWithString:@"http://gannonsports.com/news/2012/11/1/GEN_1101121659.aspx?path=general"];
    [newNewsItem1 setObject:newsURL forKey:@"newsURL"];
    [newNewsItem1 setObject:newsImage forKey:@"newsPicture"];

    
    NSMutableDictionary *newNewsItem2 = [[NSMutableDictionary alloc] init];
    [newNewsItem2 setObject: [NSURL URLWithString:@"http://www.ncaa.com/sports/basketball-women/d2"] forKey:@"newsURL"];
    [newNewsItem2 setObject:@"Elite Eight NCAA News" forKey:@"title"];
    [newNewsItem2 setObject:@"Home of the National Collegiate Atheletic Association (NCAA) web news on Women's Division II. Get the roundups and all the hot news. Always current." forKey:@"description"];
    [newNewsItem2 setObject:[UIImage imageNamed:@"basketball-w_dii.png"] forKey:@"newsPicture"];
    [self.newsList addObject:newNewsItem2];
    [self.newsList addObject:newNewsItem1];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIButton * segueButton = sender;
    WebViewViewController *wvvc = (WebViewViewController *)[segue destinationViewController];
    NSURL * selectedURL = [[self.newsList objectAtIndex:segueButton.tag] objectForKey:@"newsURL"];
    NSString *title = [[self.newsList objectAtIndex:segueButton.tag] objectForKey:@"title"];
    [wvvc setTitle:title];
    [wvvc setViewedURL:selectedURL];
}


@end
