//
//  MapsViewViewController.h
//  NCAA App
//
//  Created by Hassan Al Rawi on 2/5/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface MapsViewViewController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapsViewer;
@property (nonatomic, strong) NSString * selectedLocation;
@property (nonatomic, strong) NSArray * selectedLocationsArrayList;
@end
