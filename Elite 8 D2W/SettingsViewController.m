//
//  SettingsViewController.m
//  NCAA App
//
//  Created by Hassan Al Rawi on 2/6/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (strong, nonatomic) NSArray *pickerDataSource;

@end

@implementation SettingsViewController
@synthesize myRegionCode = _myRegionCode;
@synthesize pickerDataSource = _pickerDataSource;



-(regionCode) myRegionCode {
    if(!_myRegionCode) {
        return All;
    }
    else {
        return _myRegionCode;
    }
}
-(void) setMyRegionCode:(regionCode)myRegionCode {
    _myRegionCode = myRegionCode;
    self.RegionSettingsLabel.text = self.pickerDataSource[(int)self.myRegionCode];
    [self.settingsMasterDelegate.mySettings saveRegion:myRegionCode];
    [self.settingsMasterDelegate saveSettings];

}

-(NSArray *)pickerDataSource {
    if(!_pickerDataSource){
        return [[NSArray alloc] initWithArray: [RegionDefinitions regionStrings]];
    }
    else {
        return _pickerDataSource;
    }
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
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [[self.mainView layer] setShadowOffset:CGSizeMake(5, 0)];
    [[self.mainView layer] setShadowColor:[[UIColor darkGrayColor] CGColor]];
    [[self.mainView layer] setShadowRadius:3.0];
    [[self.mainView layer] setShadowOpacity:0.8];
    self.mainView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.mainView.bounds].CGPath;
    CALayer *layer = self.mainView.layer;
    layer.cornerRadius = 10.0f;
    
    //self.RegionSettingsLabel.text = self.pickerDataSource[(int)self.myRegionCode];
}

/*
- (void)viewDidAppear:(BOOL)animated{
    NSInteger pickerSize = self.pickerDataSource.count;
    int initComponentNo = (int)self.myRegionCode;
    //self.RegionSettingsLabel.text = [RegionDefinitions convertToString:self.myRegionCode];
    int i = self.regionStatusPicker.numberOfComponents;
    
    if (self.regionStatusPicker. numberOfComponents > 1) {
        [self.regionStatusPicker selectRow:pickerSize inComponent:0 animated:YES];
        [self.regionStatusPicker reloadComponent:0];
        [self.regionStatusPicker selectRow:pickerSize inComponent:1 animated:YES];
        [self.regionStatusPicker reloadComponent:1];
        [self.regionStatusPicker selectRow:0 inComponent:0 animated:YES];
        [self.regionStatusPicker reloadComponent:0];
        [self.regionStatusPicker selectRow:0 inComponent:1 animated:YES];
    }

    [self.regionStatusPicker reloadComponent:initComponentNo];
}
 */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)countdownAction:(id)sender {
        NSLog(@"At Settings, Calling Countdown Action");
    if (self.countdownStatus.on) {
        [_countdownDelegate showCountdown];
        [self.settingsMasterDelegate.mySettings saveCountdownState:YES];
    } else if (!self.countdownStatus.on) {
        [_countdownDelegate hideCountdown];
        [self.settingsMasterDelegate.mySettings saveCountdownState:NO];
    }
    [self.settingsMasterDelegate saveSettings];
}


#pragma mark PickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerDataSource.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return self.pickerDataSource[row];
}

#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    [self setMyRegionCode: (regionCode)row];      // Sleazy
    NSLog(@"At Settings, Calling Regions Delegate Action");
    [self.regionSettingDelegate resetRegionSetting: self.myRegionCode];
    [self.settingsMasterDelegate saveSettings];
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row
{
    return [self.pickerDataSource objectAtIndex:row];
}


- (void)populateFromSettings
{
	// Do any additional setup after loading the view.
    if (!self.settingsMasterDelegate.mySettings) {
        self.settingsMasterDelegate.mySettings = [[SettingsModel alloc] init];
        [self.settingsMasterDelegate.mySettings loadSettingsFromFile];
        [self.settingsMasterDelegate loadSettings];
    }
    
    [self setMyRegionCode: self.settingsMasterDelegate.mySettings.getRegion];
    [self.countdownStatus setSelected: self.settingsMasterDelegate.mySettings.getCountdown];
    [self.countdownStatus setOn:self.settingsMasterDelegate.mySettings.getCountdown];
}

@end
