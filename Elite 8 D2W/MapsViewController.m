//
//  MapsViewController.m
//  NCAA App
//
//  Created by Hassan Al Rawi on 1/9/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import "MapsViewController.h"
#import "MapsViewViewController.h"
@interface MapsViewController ()
@property (nonatomic, strong) NSMutableArray * resturantsList;
@property (nonatomic, strong) NSArray * parkingList;
@property (nonatomic, strong) NSArray * hotelsLocations;
@property (nonatomic, strong) NSArray * hotelsList;
@property (nonatomic, strong) NSArray * arenaLocation;
@property (nonatomic, strong) NSArray * arenaList;
@property (nonatomic, strong) NSArray * sectionsList;
@property (nonatomic, strong) NSArray * sectionNamesList;
@property (nonatomic, strong) NSArray * subsectionNamesList; // Headings for each subsection
@end

@implementation MapsViewController
@synthesize resturantsList;

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
    [self setupLocationData];
    self.view.backgroundColor = [UIColor clearColor];
    self.mainView.backgroundColor = [UIColor clearColor];
    CALayer *layer = self.mainView.layer;
    layer.cornerRadius = 10.0f;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"Number of sections %lu", (unsigned long)[self.sectionsList count]);
    return [self.sectionsList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger noRows = [[self.sectionsList objectAtIndex:section] count];
    NSLog(@"Number of rows in section %ld: %ld", (long)section, (long)noRows);
    return noRows;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.sectionNamesList objectAtIndex:section];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,200,300,244)];
    tempView.backgroundColor=[UIColor clearColor];
    
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,0,300,37)];
    tempLabel.backgroundColor=[UIColor clearColor];
    tempLabel.textColor = [UIColor whiteColor]; //here you can change the text color of header.
    tempLabel.text = [self.sectionNamesList objectAtIndex:section];
    
    [tempView addSubview:tempLabel];
    
    return tempView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"locationCell";
    UITableViewCell *locationCell = [self.tableView  dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!locationCell) {
        locationCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSLog(@"Location Name : %@", [self.sectionNamesList objectAtIndex:indexPath.section]);
    
    //locationCell.textLabel.text = [self.locationsListNames objectAtIndex:indexPath.section];
    locationCell.textLabel.text = [[self.subsectionNamesList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSLog(@"%@", locationCell.textLabel.text);
    
    return locationCell;
}


- (NSArray *)setupParkingLocationsList {
    NSArray * parkingLocation1 = [NSArray arrayWithObjects:@"LOT 14", @"42.122539", @"-80.081547",nil];
    NSArray * parkingLocation2 = [NSArray arrayWithObjects:@"LOT 2: Erie Playhouse parking", @"42.124417", @"-80.084809",nil];
    NSArray * parkingLocation3 = [NSArray arrayWithObjects:@"LOT 7: Jerry Uht Park", @"42.126215", @"-80.080281",nil];
    NSArray * parkingLocation4 = [NSArray arrayWithObjects:@"LOT 1: Erie County Court House Parking", @"42.129382", @"-80.088306",nil];
    NSArray * parkingLocation5 = [NSArray arrayWithObjects:@"LOT 3: UPMC Hamot Parking", @"42.132533", @"-80.082920",nil];
    NSArray * parkingLocation6 = [NSArray arrayWithObjects:@"LOT 11: UPMC Hamot Parking", @"42.133806", @"-80.085822",nil];
    NSArray * parkingLocation7 = [NSArray arrayWithObjects:@"LOT 15", @"42.113992", @"-80.063592",nil];
    NSArray * parkingLocation8 = [NSArray arrayWithObjects:@"Garage K-2", @"42.110617", @"-80.079707",nil];
    NSArray * parkingLocation9 = [NSArray arrayWithObjects:@"Garage E", @"42.125754", @"-80.081424",nil];
    NSArray * parkingLocation10 = [NSArray arrayWithObjects:@"Garage D-1", @"42.125420", @"-80.085952",nil];
    NSArray * parkingLocation11 = [NSArray arrayWithObjects:@"Garage D", @"42.125615", @"-80.085480",nil];
    NSArray * parkingLocation12 = [NSArray arrayWithObjects:@"Garage Q", @"42.127525", @"-80.085888",nil];
    NSArray * parkingLocation13 = [NSArray arrayWithObjects:@"Garage B", @"42.128543", @"-80.083184",nil];
    NSArray * parkingLocation14 = [NSArray arrayWithObjects:@"Garage M-1", @"42.132521", @"-80.086617",nil];
    NSArray * parkingLocation15 = [NSArray arrayWithObjects:@"Garage M-2", @"42.132887", @"-80.085394",nil];
    
    return [NSArray arrayWithObjects:parkingLocation1, parkingLocation2, parkingLocation3, parkingLocation4, parkingLocation5, parkingLocation6, parkingLocation7, parkingLocation8, parkingLocation9, parkingLocation10, parkingLocation11, parkingLocation12, parkingLocation13, parkingLocation14, parkingLocation15, nil];
}
- (NSArray *)setupRestaurantLocationList1 {
    NSArray * resturantLocation1 = [NSArray arrayWithObjects:@"Applebees", @"42.099565", @"-80.14601590000001",nil];
    NSArray * resturantLocation2 = [NSArray arrayWithObjects:@"Applebees", @"42.099217", @"-80.145714",nil];
    NSArray * resturantLocation3 = [NSArray arrayWithObjects:@"Applebees", @"42.050697", @"-80.08386000000002",nil];
    NSArray * resturantLocation4 = [NSArray arrayWithObjects:@"Boston's Restaurant Gourmet Pizza", @"42.0472793", @"-80.0786827",nil];
    NSArray * resturantLocation5 = [NSArray arrayWithObjects:@"Steak n' Shake", @"42.051739", @"-80.0837601",nil];
    NSArray * resturantLocation6 = [NSArray arrayWithObjects:@"Qdoba", @"42.054723", @"-80.08616",nil];
    NSArray * resturantLocation7 = [NSArray arrayWithObjects:@"Famous Dave's", @"42.054723", @"-80.08616",nil];
    NSArray * resturantLocation8 = [NSArray arrayWithObjects:@"Dunkin Donuts", @"42.054723", @"-80.086160",nil];
    NSArray * resturantLocation9 = [NSArray arrayWithObjects:@"Dunkin Donuts", @"42.0690952", @"-80.09830729999999",nil];
    NSArray * resturantLocation10 = [NSArray arrayWithObjects:@"Safari Grille", @"42.04900809999999", @"-80.08964950000001",nil];
    return [NSArray arrayWithObjects:self.arenaLocation, resturantLocation1, resturantLocation2, resturantLocation3, resturantLocation4, resturantLocation5, resturantLocation6, resturantLocation7, resturantLocation8, resturantLocation9, resturantLocation10, nil];
}
- (NSArray *)setupRestaurantLocationList2 {
    NSArray * resturantLocation1 = [NSArray arrayWithObjects:@"Alto Cucina", @"42.098433", @"-80.16477399999997", nil];
    NSArray * resturantLocation2 = [NSArray arrayWithObjects:@"Aoyama", @"42.0690952", @"-80.09830729999999", nil];
    NSArray * resturantLocation3 = [NSArray arrayWithObjects:@"Arby's", @"42.1227952", @"-80.08275800000001",nil];
    NSArray * resturantLocation4 = [NSArray arrayWithObjects:@"Arby's", @"42.0919839", @"-80.08400999999998",nil];
    NSArray * resturantLocation5 = [NSArray arrayWithObjects:@"Arby's", @"42.089274", @"-80.13564500000001",nil];
    NSArray * resturantLocation6a = [NSArray arrayWithObjects:@"Barbato's Italian Restaurant & Pizzeria", @"42.1184862",  @"-80.07793270000002",nil];
    NSArray * resturantLocation6b = [NSArray arrayWithObjects:@"Barbato's Italian Restaurant & Pizzeria", @"42.1184862",  @"-80.07793270000002",nil];
    NSArray * resturantLocation7a = [NSArray arrayWithObjects:@"Bob Evans Restaurant", @"42.104541", @"-80.134233",nil];
    NSArray * resturantLocation7b = [NSArray arrayWithObjects:@"Bob Evans Restaurant", @"42.0491207",  @"-80.07974560000002",nil];
    NSArray * resturantLocation8 = [NSArray arrayWithObjects:@"Buffalo Wild Wings", @"42.066343", @"-80.11107149999998",nil];
    NSArray * resturantLocation9a = [NSArray arrayWithObjects:@"Burger King", @"42.090963", @"-80.08443699999998",nil];
    
    return [NSArray arrayWithObjects:resturantLocation1, resturantLocation2, resturantLocation3, resturantLocation4, resturantLocation5, resturantLocation6a, resturantLocation6b,resturantLocation7a, resturantLocation7b, resturantLocation8, resturantLocation9a,
            [NSArray arrayWithObjects:@"Burger King", @"42.088134", @"-80.13784290000001",nil],
            [NSArray arrayWithObjects:@"Calamari's Squid Row", @"42.1221092", @"-80.0803229",nil],
            [NSArray arrayWithObjects:@"Cheddar’s Casual Café", @"42.066197", @"-80.1115714",nil],
            [NSArray arrayWithObjects:@"Chick-Fil-A", @"42.054117", @"-80.087536",nil],
            [NSArray arrayWithObjects:@"Cracker Barrel Old Country Store", @"42.0488829", @"-80.085462",nil],
            [NSArray arrayWithObjects:@"Eat’n Park Restaurant", @"42.0488829", @"-80.085462",nil],
            [NSArray arrayWithObjects:@"Eat’n Park Restaurant", @"42.0539119", @"-80.08544319999999",nil],
            [NSArray arrayWithObjects:@"El Canelo", @"42.1009529", @"-80.14134200000001",nil],
            [NSArray arrayWithObjects:@"El Canelo", @"42.090314", @"-80.085736",nil],
            [NSArray arrayWithObjects:@"Fox & Hound English Pub & Grille", @"42.0657055", @"-80.16015520000002",nil],
            [NSArray arrayWithObjects:@"Golden Corral", @"42.051448", @"-80.08664599999997",nil],
            [NSArray arrayWithObjects:@"Hibachi Japanese Steak House", @"42.099029", @"-80.14893699999999",nil],
            [NSArray arrayWithObjects:@"Hoss’s Steak and Sea House", @"42.0844892", @"-80.1474622",nil],
            [NSArray arrayWithObjects:@"Joe Root's Grill", @"42.1044709", @"-80.14801899999998",nil],
            [NSArray arrayWithObjects:@"Kentucky Fried Chicken", @"42.102198", @"-80.140804",nil],
            [NSArray arrayWithObjects:@"Long John Silver", @"42.07725", @"-80.09196299999996",nil],
            [NSArray arrayWithObjects:@"Long John Silver", @"42.088738", @"-80.13685199999998",nil],
            [NSArray arrayWithObjects:@"Longhorn", @"42.102198", @"-80.140804",nil],
            [NSArray arrayWithObjects:@"Matthew’s Trattoria", @"42.1235449", @"-80.07802620000001",nil],
            [NSArray arrayWithObjects:@"Max & Erma’s", @"42.0663476", @"-80.1113767",nil],
            [NSArray arrayWithObjects:@"McDonald's ", @"42.130364", @"-80.08693499999998",nil],
            [NSArray arrayWithObjects:@"McDonald's ", @"42.122748", @"-80.08509200000003",nil],
            [NSArray arrayWithObjects:@"McDonald's ", @"42.089276", @"-80.08533190000003",nil],
            [NSArray arrayWithObjects:@"Moe's Southwest Grill", @"42.0637555", @"-80.09896579999997",nil],
            [NSArray arrayWithObjects:@"Molly Brannigan’s Irish Pub & Restaurant", @"42.130121", @"-80.08612299999999",nil],
            [NSArray arrayWithObjects:@"O'Charleys", @"42.0663081", @"-80.11119689999998",nil],
            [NSArray arrayWithObjects:@"Old Country Buffet", @"42.0509318", @"-80.09340759999998",nil],
            [NSArray arrayWithObjects:@"Olive Garden", @"42.064069", @"-80.092419",nil],
            [NSArray arrayWithObjects:@"Outback Steakhouse", @"42.065777", @"-80.102802",nil],
            [NSArray arrayWithObjects:@"Perkins Family Restaurants", @"42.0887459", @"-80.08614449999999",nil],
            [NSArray arrayWithObjects:@"Pizza Hut", @"42.0799665", @"-80.0913251",nil],
            [NSArray arrayWithObjects:@"Plymouth Tavern & Restaurant", @"42.1242195", @"-80.0817088",nil],
            [NSArray arrayWithObjects:@"Quaker Steak & Lube ", @"42.05086", @"-80.08180199999998",nil],
            [NSArray arrayWithObjects:@"Red Lobster", @"42.064922", @"-80.09848799999997",nil],
            [NSArray arrayWithObjects:@"Ruby Tuesday ", @"42.072631", @"-80.09844299999997",nil],
            [NSArray arrayWithObjects:@"Skippereno's Restaurant & Pizzeria", @"42.0833362", @"-80.09638310000003",nil],
            [NSArray arrayWithObjects:@"Smokey Bones Barbeque & Grill", @"42.065665", @"-80.102081",nil],
            [NSArray arrayWithObjects:@"Subway", @"42.124842", @"-80.08260789999997",nil],
            [NSArray arrayWithObjects:@"Subway", @"42.09511699999999", @"-80.06230649999998",nil],
            [NSArray arrayWithObjects:@"TGI Fridays", @"42.055705", @"-80.08752199999998",nil],
            [NSArray arrayWithObjects:@"Texas Roadhouse", @"42.0531947", @"-80.08467200000001",nil],
            [NSArray arrayWithObjects:@"Torero's Mexican Restaurant", @"42.14795609999999", @"-80.0460751",nil],
            [NSArray arrayWithObjects:@"Two Friends Italian Market", @"42.1268923", @"-80.08352379999997",nil],
            [NSArray arrayWithObjects:@"Valerios Italian Restaurant & Pizzeria", @"42.088611", @"-80.11941100000001", nil],
            [NSArray arrayWithObjects:@"Wendy's", @"42.123651", @"-80.0792869",nil],
            [NSArray arrayWithObjects:@"Wendy's", @"42.0659459", @"-80.0926299999999",nil],
            [NSArray arrayWithObjects:@"Smugglers' Wharf", @"42.1160708", @"-80.07633679999998",nil],
            self.arenaLocation,
            nil];
}
- (NSArray *)setupEntertainmentLocationList {
    NSArray * resturantLocation1 = [NSArray arrayWithObjects:@"Erie Playhouse", @"42.125217", @"-80.083098",nil];
    NSArray * resturantLocation2 = [NSArray arrayWithObjects:@"Erie Maritime Museum", @"42.136373", @"-80.086360",nil];
    NSArray * resturantLocation3 = [NSArray arrayWithObjects:@"Erie Art Museum", @"42.131073", @"-80.085265",nil];
    NSArray * resturantLocation4 = [NSArray arrayWithObjects:@"Jerry Uht Park", @"42.126761", @"-80.080287",nil];
    NSArray * resturantLocation5 = [NSArray arrayWithObjects:@"Gannon University", @"42.128400", @"-80.086016",nil];
    NSArray * resturantLocation6 = [NSArray arrayWithObjects:@"Bayfront Convention Center", @"42.136914", @"-80.093462",nil];
    NSArray * resturantLocation7 = [NSArray arrayWithObjects:@"UPMC Hamot", @"42.133732", @"-80.086360",nil];
    NSArray * resturantLocation8 = [NSArray arrayWithObjects:@"Erie City Hall", @"42.128469", @"-80.085430",nil];
    NSArray * resturantLocation9 = [NSArray arrayWithObjects:@"Erie County Courthouse", @"42.129054", @"-80.087980",nil];
    return [NSArray arrayWithObjects:resturantLocation1, resturantLocation2, resturantLocation3, resturantLocation4, resturantLocation5, resturantLocation6, resturantLocation7, resturantLocation8, resturantLocation9, self.arenaLocation, nil];
}

-(NSArray *)setupHotelsLocationList {
    return [NSArray arrayWithObjects:
            [NSArray arrayWithObjects:@"Hilton Garden Inn", @"42.049875", @"-80.085322",nil],
            [NSArray arrayWithObjects:@"Courtyard Marriott", @"42.049934", @"-80.084126",nil],
            [NSArray arrayWithObjects:@"Residence Inn", @"42.049357", @"-80.078143",nil],
            [NSArray arrayWithObjects:@"Holiday Inn Express", @"42.047579", @"-80.077804",nil],
            [NSArray arrayWithObjects:@"Comfort Inn and Suites", @"42.049763", @"-80.078497",nil],
            [NSArray arrayWithObjects:@"Econo Lodge", @"42.047777", @"-80.081090",nil],
            [NSArray arrayWithObjects:@"Days Inn", @"42.073224", @"-80.040549",nil],
            [NSArray arrayWithObjects:@"Peek n Peak Resort and Spa", @"42.062414", @"-79.735398",nil],
            [NSArray arrayWithObjects:@"Sheraton Erie Bayfront Hotel", @"42.137159", @"-80.091290",nil],
            [NSArray arrayWithObjects:@"Avalon Hotel", @"42.125605", @"-80.082897",nil],
            [NSArray arrayWithObjects:@"Clarion Hotel and Conference Center", @"42.104855", @"-80.145607",nil],
            [NSArray arrayWithObjects:@"Country Inn & Suites", @"42.048437", @"-80.081391",nil],
            [NSArray arrayWithObjects:@"Fairfield Inn Erie", @"42.070798", @"-80.103644",nil],
            [NSArray arrayWithObjects:@"George Carroll House", @"42.130864", @"-80.087464",nil],
            [NSArray arrayWithObjects:@"Hampton Inn Erie South", @"42.048521", @"-80.081620",nil],
            [NSArray arrayWithObjects:@"Hilton Homewood Suites", @"42.070721", @"-80.104864",nil],
            [NSArray arrayWithObjects:@"Quality Inn & Suites", @"42.067535", @"-80.042249",nil],
            [NSArray arrayWithObjects:@"Red Roof Inn", @"42.071664", @"-80.038411",nil],
            [NSArray arrayWithObjects:@"SpringHill Suites by Marriott", @"42.064995", @"-80.103855",nil],
            [NSArray arrayWithObjects:@"William Sands House", @"42.126686", @"-80.091611",nil],
            self.arenaLocation,nil];
}

- (NSArray *)setupArenaLocations {
    self.arenaLocation = [NSArray arrayWithObjects:@"Erie Insurance Arena", @"42.128116", @"-80.081066", nil];
    return [NSArray arrayWithObject:self.arenaLocation];
}

-(void)setupLocationData {
    self.arenaList = [NSArray arrayWithObject: [self setupArenaLocations]]; // Do first
    NSMutableArray *rListOfLists = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:[self setupRestaurantLocationList1], [self setupRestaurantLocationList2], [self setupEntertainmentLocationList], nil]];
    self.resturantsList = rListOfLists;
    self.hotelsLocations = [self setupHotelsLocationList];
    self.hotelsList = [NSMutableArray arrayWithObject:self.hotelsLocations];
//    self.resturantsList = [[NSMutableArray alloc] initWithArray:[self setupEntertainmentLocationList]];
    self.parkingList = [NSArray arrayWithObject:[self setupParkingLocationsList]];
    self.sectionNamesList = [NSArray arrayWithObjects:@"Arena", @"Parking", @"Food, Entertainment & Other",@"Hotels",nil];
    self.subsectionNamesList = [NSArray arrayWithObjects:
                                [NSArray arrayWithObjects:@"Erie Insurance Arena",nil],
                                [NSArray arrayWithObjects:@"Nearby Lots", nil],
                                [NSArray arrayWithObjects:@"Partner Restaurants", @"Other Local Restaurants", @"Locations of Interest", nil], [NSArray arrayWithObjects:@"Nearby Hotels", nil],
                                                         nil];
    self.sectionsList = [NSArray arrayWithObjects:self.arenaList, self.parkingList, self.resturantsList, self.hotelsList,nil];
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MapsViewViewController * mvvc = [segue destinationViewController];
    NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
//    NSArray * selectedItem = [[self.sectionsList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSArray * selectedList = [[self.sectionsList objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    [mvvc setSelectedLocationsArrayList:selectedList];
    [mvvc setSelectedLocation: [[self.subsectionNamesList objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]];
}

@end
