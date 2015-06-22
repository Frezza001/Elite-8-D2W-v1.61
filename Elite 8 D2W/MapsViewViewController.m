//
//  MapsViewViewController.m
//  NCAA App
//
//  Created by Hassan Al Rawi on 2/5/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import "MapsViewViewController.h"

#define METERS_PER_MILE 1609.344

@interface MapsViewViewController ()
@property (nonatomic, strong) MKPointAnnotation * point;
@property (nonatomic) CLLocationCoordinate2D pinlocation;
@end

@implementation MapsViewViewController

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
    self.mapsViewer.delegate = self;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
	// Do any additional setup after loading the view.
    self.title = self.selectedLocation;
    [self setupLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupLocation {
    for (NSArray * locations in self.selectedLocationsArrayList) {
        CLLocationCoordinate2D pinlocation = self.mapsViewer.userLocation.coordinate;
        pinlocation.latitude = [[locations objectAtIndex:1] doubleValue];
        pinlocation.longitude = [[locations objectAtIndex:2] doubleValue];
        MKPlacemark * location = [[MKPlacemark alloc] initWithCoordinate:pinlocation addressDictionary:nil];
        MKMapItem *pinItem = [[MKMapItem alloc] initWithPlacemark:location];
        pinItem.name = [locations objectAtIndex:0];
        self.point = [[MKPointAnnotation alloc] init];
        self.point.coordinate = pinlocation;
        self.point.title = pinItem.name;
        [self.mapsViewer addAnnotation:self.point];
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(pinlocation, METERS_PER_MILE, METERS_PER_MILE);
        [self.mapsViewer setRegion:viewRegion animated:YES];
    }
    
    
    
}


@end
