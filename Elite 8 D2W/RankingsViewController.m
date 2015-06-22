//
//  RankingsViewController.m
//  NCAA App
//
//  Created by Hassan Al Rawi on 1/9/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import "RankingsViewController.h"
#import "TFHpple.h"
#import "RankingsCell.h"
#import "RegionDefinitions.h"
#import "WebViewViewController.h"
@interface RankingsViewController () {
    dispatch_queue_t myQueue;
}
@property (nonatomic, strong) NSMutableArray * column;
@property (nonatomic, strong) NSMutableArray * updatedRankingData;
@property (nonatomic, strong) NSMutableArray * sectionTitle;
@property (nonatomic, strong) UIButton * filterButton;
@property (nonatomic, strong) NSMutableDictionary * teamLinksDictionary;
@end

@implementation RankingsViewController
@synthesize usersRegionCode = _usersRegionCode;

-(regionCode) usersRegionCode {
    if (!_usersRegionCode) {
        return All;
    }
    else {
        return _usersRegionCode;
    }
}

-(void) setUsersRegionCode:(regionCode)code {
    _usersRegionCode = code;
}

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
    self.rankingsTableView.delegate = self;
    self.rankingsTableView.dataSource = self;
    [self setupTeamsDictionary];
    if (!myQueue) {
        myQueue = dispatch_queue_create("rankingsLoading", NULL);
    }
    //dispatch_async(myQueue, ^{[self loadUSATodayRankings];});
    dispatch_async(myQueue, ^{[self loadRankings];});
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [[self.mainView layer] setShadowOffset:CGSizeMake(5, 0)];
    [[self.mainView layer] setShadowColor:[[UIColor darkGrayColor] CGColor]];
    [[self.mainView layer] setShadowRadius:3.0];
    [[self.mainView layer] setShadowOpacity:0.8];
    self.mainView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.mainView.bounds].CGPath;
    CALayer *layer = self.mainView.layer;
    CALayer *layer2 = self.loadingView.layer;
    layer2.cornerRadius = 10.0f;
    layer.cornerRadius = 10.0f;
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadUSATodayRankings {
    NSURL *tutorialsUrl = [NSURL URLWithString:@"http://www.ncaa.com/rankings/basketball-women/d2/usa-today-coaches"];
    NSData *tutorialsHtmlData = [NSData dataWithContentsOfURL:tutorialsUrl];
    
    TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:tutorialsHtmlData];
    if (tutorialsHtmlData != nil) {
        NSString *tutorialsXpathQueryString3 = @"//tbody";
        NSArray *tutorialsNodes = [tutorialsParser searchWithXPathQuery:tutorialsXpathQueryString3];
        TFHppleElement *content = [tutorialsNodes objectAtIndex:0];
        NSArray * dataArray = content.children;
        
        self.column = [[NSMutableArray alloc] init];
        
        for (TFHppleElement *element in dataArray) {
            NSMutableArray * row = [[NSMutableArray alloc] init];
            for (TFHppleElement *childNode in element.children) {
                if ([[childNode firstChild] content] == NULL) {
                    continue;
                }
                [row addObject:[[childNode firstChild] content]];
            }
            if ([row count] != 0) {  //Load everything
                [self.column addObject:row];
            }
            
        }
        
        NSLog(@"Coulmns: %lu" , (unsigned long)[self.column count]);
    }
    
	dispatch_async(dispatch_get_main_queue(), ^{[self.rankingsTableView reloadData];});
    
}

-(void)loadRankings {
    NSURL *rankingsUrl = [NSURL URLWithString:@"http://www.ncaa.com/rankings/basketball-women/d2/regional-ranking"];
    NSData *rankingsHtmlData = [NSData dataWithContentsOfURL:rankingsUrl];
    self.sectionTitle = [[NSMutableArray alloc] init];
    TFHpple *rankingsParser = [TFHpple hppleWithHTMLData:rankingsHtmlData];
    if (rankingsHtmlData != nil) {
        NSString *tutorialsXpathQueryString3 = @"//tbody";
        NSArray *tutorialsNodes = [rankingsParser searchWithXPathQuery:tutorialsXpathQueryString3];
        TFHppleElement *content = [tutorialsNodes objectAtIndex:0];
        NSArray * dataArray = content.children;
        
        self.column = [[NSMutableArray alloc] init];
        regionCode readingRegion = All;
        
        for (TFHppleElement *element in dataArray) {
            NSMutableArray * row = [[NSMutableArray alloc] init];
            for (TFHppleElement *childNode in element.children) {
                if ([[childNode firstChild] content] == NULL) {
                    continue;
                }
                [row addObject:[[childNode firstChild] content]];
            }
            if ([row count] == 1) { // Region Label
                NSString *regionStringFromWeb = [row objectAtIndex:0];
                readingRegion = [RegionDefinitions convertFromString:regionStringFromWeb];
                if ((self.usersRegionCode == All) || (self.usersRegionCode == readingRegion)) {
                    [self.column addObject:row];
                    [self.sectionTitle addObject:row];
               }
            } else if ([row count] > 0) { // Normal line of data
                if ((self.usersRegionCode  == All) || (self.usersRegionCode == readingRegion))
                {
                    [self.column addObject:row];
                }
            }
/*            if ([row count] != 0) {
                [self.column addObject:row];
            }
 */
        }
//        NSLog(@"Columns: %lu" , (unsigned long)[self.column count]);
//        NSLog(@"name of regions: %@", [self.sectionTitle objectAtIndex:5]);
        
    }
    [self rankingsnewdata];
	dispatch_async(dispatch_get_main_queue(), ^{[self.rankingsTableView reloadData];});
}

-(void)rankingsnewdata {
    self.updatedRankingData = [[NSMutableArray alloc] init];
    int counter = 0;
    NSMutableArray * tempSectionSettings = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.column count]; i++) {

        
        if (i == 6) {
            continue;
        }
        if (i == 0 || i == 12 || i == 23 || i == 34 || i == 45 || i == 56 || i == 67 || i == 78 || i == 89) {
            continue;
        } else {
            
            if (counter <= 9) {
                [tempSectionSettings addObject:[self.column objectAtIndex:i]];
            }
                
            if (counter >= 10) {
                [self.updatedRankingData addObject:tempSectionSettings];
                tempSectionSettings = [[NSMutableArray alloc] init];
                [tempSectionSettings addObject:[self.column objectAtIndex:i]];
                counter = 0;
            }
            counter++;
            
        }
        
    }
    [self.updatedRankingData addObject:tempSectionSettings];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"rankingsCell";
    RankingsCell *rankingsCell = [self.rankingsTableView  dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!rankingsCell) {
        rankingsCell = [[RankingsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    if ([self.column count] == 0) {
        self.loadingView.alpha = 0.0f;
        self.activityIndicator.alpha = 0.0f;
        [UILabel animateWithDuration:0.2f
                          animations:^{
                              [self.activityIndicator startAnimating];
                              self.loadingView.alpha = 1.0f;
                              self.activityIndicator.alpha = 1.0f;
                          }
                          completion:^(BOOL finished){
                              self.loadingView.hidden = NO;
                              self.activityIndicator.hidden = NO;
                          }];
    } else {
        [UILabel animateWithDuration:0.5f
                          animations:^{
                              self.loadingView.alpha = 0.0f;
                              self.activityIndicator.alpha = 0.0f;
                          }
                          completion:^(BOOL finished){
                              self.loadingView.hidden = YES;
                              self.activityIndicator.hidden = YES;
                          }];
//        if ([[self.column objectAtIndex:indexPath.row] count] > 3)
//        {
            rankingsCell.rank.text = [[[self.updatedRankingData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:0];
            rankingsCell.school.text = [[[self.updatedRankingData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:1];
            rankingsCell.record.text = [[[self.updatedRankingData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:2];
            rankingsCell.schoolURL = [self.teamLinksDictionary objectForKey:[[[self.updatedRankingData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:1]];
//        } else { // Region Label
//            rankingsCell.rank.text = @"****";
//            rankingsCell.school.text = [self.sectionTitle objectAtIndex:indexPath.row];
//            rankingsCell.record.text = @"****";
//        }
    }
//    NSLog(@"%@ School Url: %@", rankingsCell.school.text ,rankingsCell.schoolURL);
//    NSLog(@"%@", rankingsCell.rank.text);
//    NSLog(@"%@", rankingsCell.school.text);
//    NSLog(@"%@", rankingsCell.record.text);
    return rankingsCell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,0,300,244)];
    tempView.backgroundColor = [UIColor colorWithRed:0.0 green:120.0/255.0 blue:239.0/255.0 alpha:1];
    self.filterButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.filterButton.frame = tempView.frame;
    self.filterButton.tag = section;
    [self.filterButton addTarget:self action:@selector(userTappedOnASection) forControlEvents:UIControlEventTouchDown];
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,0,300,37)];
    tempLabel.textColor = [UIColor whiteColor]; //here you can change the text color of header.
    tempLabel.text = [[self.sectionTitle objectAtIndex:section] objectAtIndex:0];

    [tempView addSubview:tempLabel];
    [tempView addSubview:self.filterButton];
    return tempView;
}

-(void) userTappedOnASection {


    // use te reigon enum to make sure it matches the title section.
    NSString * selectedRegion = [self.sectionTitle objectAtIndex:self.filterButton.tag];
    NSLog(@"User Tapped The Region %@", selectedRegion);
    //    if ([selectedRegion isEqualToString:[RegionDefinitions convertToString:_usersRegionCode]]) {
//        [self setUsersRegionCode:[RegionDefinitions convertFromString:selectedRegion]];
//    }
//    NSLog(@"Selected Region %@", self.usersRegionCode);
//    NSLog(@"Section Tag %@", selectedRegion);
    //    [self resetRegionSetting:selectedRegion];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.updatedRankingData count] == 0) {
        return 1;
    } else {
        return [[self.updatedRankingData objectAtIndex:section] count];
    }
}

-(void) resetRegionSetting:(regionCode)newSetting
{
    NSLog(@"At Rankings View Controller, reset region setting");

    [self setUsersRegionCode: newSetting];
   	dispatch_async(dispatch_get_main_queue(), ^{[self.rankingsTableView reloadData];});
}
-(regionCode) currentRegionSetting
{
    return _usersRegionCode;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.updatedRankingData count] == 0) {
        return 1;
    } else {
        return [self.updatedRankingData count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([self.sectionTitle isEqual:nil]) {
        return @"Not Empty";
    } else {
        return [[self.sectionTitle objectAtIndex:section] objectAtIndex:0];
    }
}

-(void) setupTeamsDictionary {
    self.teamLinksDictionary = [[NSMutableDictionary alloc] init];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/drury" forKey:@"Drury"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/lewis" forKey:@"Lewis "];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/indianapolis" forKey:@"Indianapolis"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/quincy" forKey:@"Quincy"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/wayne-st-mi" forKey:@"Wayne State (Mich.)"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/northern-mich" forKey:@"Northern Michigan"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/mo-st-louis" forKey:@"Missouri-St. Louis "];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/interactive-bracket/basketball-women/" forKey:@"Michigan Tech"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/interactive-bracket/basketball-women/" forKey:@"Southern Indiana"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/interactive-bracket/basketball-women/" forKey:@"Ashland "];
    
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/tampa" forKey:@"Tampa"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/rollins" forKey:@"Rollins"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/nova-southeastern" forKey:@"Nova Southeastern"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/delta-st" forKey:@"Delta State"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/albany-st-ga" forKey:@"Albany State"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/interactive-bracket/basketball-women/" forKey:@"Saint Leo"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/interactive-bracket/basketball-women/" forKey:@"Barry"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/west-fla" forKey:@"West Florida"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/interactive-bracket/basketball-women/" forKey:@"Alabama-Huntsville"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/interactive-bracket/basketball-women/" forKey:@"Florida Tech"];
    
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/bentley" forKey:@"Bentley"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/liu-post" forKey:@"LIU Post"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/adelphi" forKey:@"Adelphi"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/interactive-bracket/basketball-women/" forKey:@"Stonehill"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/assumption" forKey:@"Assumption"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/new-haven" forKey:@"New Haven "];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/dist-columbia" forKey:@"District of Columbia"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/interactive-bracket/basketball-women/" forKey:@"American International"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/interactive-bracket/basketball-women/" forKey:@"Queens (N.Y.)"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/interactive-bracket/basketball-women/" forKey:@"Philadelphia"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/harding" forKey:@"Harding"];
    
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/emporia-st" forKey:@"Emporia State"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/central-mo" forKey:@"Central Missouri"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/wayne-st-ne" forKey:@"Wayne State (Neb.)"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/pittsburg-st" forKey:@"Pittsburg State "];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/interactive-bracket/basketball-women/" forKey:@"Minnesota State-Mankato"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/northern-st" forKey:@"Northern State"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/concordia-st-paul" forKey:@"Concordia-St. Paul"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/interactive-bracket/basketball-women/" forKey:@"Fort Hays State"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/interactive-bracket/basketball-women/" forKey:@"Missouri Southern State"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/west-tex-am" forKey:@"West Texas A&M"];    // missing team
    
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/colorado-mesa" forKey:@"Colorado Mesa"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/interactive-bracket/basketball-women/" forKey:@"Tarleton State"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/colorado-st-pueblo" forKey:@"Colorado State-Pueblo"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/tex-am-intl" forKey:@"Texas A&M International"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/st-marys-tx" forKey:@"St. Mary's (Texas)"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/interactive-bracket/basketball-women/" forKey:@"Fort Lewis"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/interactive-bracket/basketball-women/" forKey:@"Texas Woman's"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/midwestern-st" forKey:@"Midwestern State"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/interactive-bracket/basketball-women/" forKey:@"Colorado Christian"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/lenoir-rhyne" forKey:@"Lenoir-Rhyne"];
    
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/clayton-st" forKey:@"Clayton State"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/wingate" forKey:@"Wingate"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/north-ga" forKey:@"North Georgia"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/columbus-st" forKey:@"Columbus State"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/belmont-abbey" forKey:@"Belmont Abbey"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/armstrong" forKey:@"Armstrong"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/limestone" forKey:@"Limestone"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/interactive-bracket/basketball-women/" forKey:@"Lincoln Memorial "];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/interactive-bracket/basketball-women/" forKey:@"Georgia College"];
    
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/mont-st-billings" forKey:@"Montana State-Billings"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/cal-poly-pomona" forKey:@"Cal Poly Pomona "];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/simon-fraser" forKey:@"Simon Fraser"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/cal-st-chico" forKey:@"Chico State"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/alas-anchorage" forKey:@"Alaska-Anchorage"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/interactive-bracket/basketball-women/" forKey:@"Seattle Pacific "];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/cal-st-dom-hills" forKey:@"Cal State Dominquez Hills"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/interactive-bracket/basketball-women/" forKey:@"UC San Diego"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/western-wash" forKey:@"Western Washington "];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/academy-of-art" forKey:@"Academy of Art "];
    
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/gannon" forKey:@"Gannon"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/glenville-st" forKey:@"Glenville"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/edinboro" forKey:@"Edinboro"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/bloomsburg" forKey:@"Bloomsburg "];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/virginia-st" forKey:@"Virginia State"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/shaw" forKey:@"Shaw"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/west-liberty" forKey:@"West Liberty "];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/interactive-bracket/basketball-women/" forKey:@"Fairmont State"];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/interactive-bracket/basketball-women/" forKey:@"Fayetteville State "];
    [self.teamLinksDictionary setValue:@"http://www.ncaa.com/schools/charleston-wv" forKey:@"Charleston (W.Va.)"];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WebViewViewController * wvvc = [segue destinationViewController];
    NSIndexPath *indexPath = [self.rankingsTableView indexPathForSelectedRow];
    NSURL * selectedURL = [NSURL URLWithString:[self.teamLinksDictionary objectForKey:[[[self.updatedRankingData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:1]]];
    NSLog(@"Selected URL: %@", selectedURL);
    [wvvc setTitle:[[[self.updatedRankingData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:1]];
    [wvvc setViewedURL:selectedURL];
}


@end
