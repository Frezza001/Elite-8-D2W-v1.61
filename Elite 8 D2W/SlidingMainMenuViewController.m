//
//  SlidingMainMenuViewController.m
//  NCAA App
//
//  Created by Hassan Al Rawi on 12/11/13.
//  Copyright (c) 2013 Gannon University. All rights reserved.
//

#import "SlidingMainMenuViewController.h"

@interface SlidingMainMenuViewController ()
@property (nonatomic, assign) BOOL pageIndicatorIsBeingUsed;
@end

@implementation SlidingMainMenuViewController

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
    self.pageIndicatorIsBeingUsed = NO;
    self.scrollingMenu.delegate = self;
    [self.scrollingMenu setContentSize:CGSizeMake(640, 144)];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self countdown];

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuButton:(id)sender {
//    NSLog(@"Pressing Menu!");
    UIButton *button = sender;
    switch (button.tag) {
        case 0: {
//            NSLog(@"Button Tag: %ld", (long)button.tag);
            [_delegate hideSlidingMainMenu];
            break;
        }
        case 1: {
            [_delegate showSlidingMainMenu];
//            NSLog(@"Button Tag: %ld", (long)button.tag);
            break;
        }
        default:
            break;
    }
}

-(void)changePage {
    CGRect frame;
    frame.origin.x = self.scrollingMenu.frame.size.width * self.pageIndicator.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollingMenu.frame.size;
    [self.scrollingMenu scrollRectToVisible:frame animated:YES];
    
    self.pageIndicatorIsBeingUsed = YES;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.pageIndicatorIsBeingUsed) {
        CGFloat pagewidth = self.scrollingMenu.frame.size.width;
        //    NSLog(@"PageWidth %f", pagewidth);
        int page = floor((self.scrollingMenu.contentOffset.x - pagewidth/2) / pagewidth) + 1;
        //    NSLog(@"PAGE NO: %i", page);
        self.pageIndicator.currentPage = page;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageIndicatorIsBeingUsed = NO;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.pageIndicatorIsBeingUsed = NO;
}

- (IBAction)viewHubs:(id)sender {
    UIButton * selectedButton = sender;
    [selectedButton.currentTitle description];
    if (selectedButton.tag == 1) {
        [_delegate viewSelectedMenu:@"Elite8HubNews"];
    } else if (selectedButton.tag == 2) {
        [_delegate viewSelectedMenu:@"Erie Hub"];
    } else if (selectedButton.tag == 3) {
        [_delegate viewSelectedMenu:@"Settings"];
    } else if (selectedButton.tag == 4) {
        [_delegate viewSelectedMenu:@"About"];
    }
    
}



-(void)countdownTimer {
    [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"EDT"]];
    NSDate *today = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    NSString *gamesDateString = @"03/25/2014 12:00:00";
    NSDate *gamesDate = [dateFormatter dateFromString:gamesDateString];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    int unitFlags = NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *components = [gregorian components:unitFlags fromDate:today toDate:gamesDate options:0];
    self.daysLabel.text = [NSString stringWithFormat:@"%02ld", (long)components.day];
    self.hoursLabel.text = [NSString stringWithFormat:@"%02ld", (long)components.hour];
    self.minutesLabel.text = [NSString stringWithFormat:@"%02ld", (long)components.minute];
    self.secondsLabel.text = [NSString stringWithFormat:@"%02ld", (long)components.second];
}

-(void) countdown {
    self.slidingMenuTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(countdownTimer) userInfo:nil repeats:YES];
}



@end
