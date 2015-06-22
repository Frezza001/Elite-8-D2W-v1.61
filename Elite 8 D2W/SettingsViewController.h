//
//  SettingsViewController.h
//  NCAA App
//
//  Created by Hassan Al Rawi on 2/6/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegionDefinitions.h"
#import "SettingsModel.h"

@protocol CountdownSettingsDelegate <NSObject>
@required
-(void) hideCountdown;
-(void) showCountdown;
@end

@protocol RegionSettingsDelegate <NSObject>
@required
-(void) resetRegionSetting:(regionCode)newSetting;
-(regionCode) currentRegionSetting;
@end

@protocol SettingsDelegate <NSObject>
- (void)saveSettings;
- (void)loadSettings;
@property (strong, nonatomic) SettingsModel *mySettings;
@end

@interface SettingsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *RegionSettingsLabel;
@property (nonatomic, assign) id <CountdownSettingsDelegate> countdownDelegate;
@property (nonatomic, assign) id <RegionSettingsDelegate> regionSettingDelegate;
@property (nonatomic, assign) id <SettingsDelegate> settingsMasterDelegate;

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UISwitch *countdownStatus;
@property (strong, nonatomic) IBOutlet UIPickerView *regionStatusPicker;
@property regionCode myRegionCode;
//@property (strong, nonatomic) SettingsModel *mySettings;

- (IBAction)countdownAction:(id)sender;
-(void)populateFromSettings;


@end
