//
//  Elite8MenuViewController.m
//  NCAA App
//
//  Created by Hassan Al Rawi on 1/7/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import "Elite8MenuViewController.h"

@interface Elite8MenuViewController ()

@end

@implementation Elite8MenuViewController
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
    self.elite8TableView.delegate = self;
    self.elite8TableView.dataSource = self;
    self.view.backgroundColor = [UIColor clearColor];
//    self.elite8MenusArray = @[@"News", @"Schedule", @"Bracket", @"Rankings", @"Coaches' Poll", @"Twitter", @"Tickets"];
    self.elite8MenusArray = @[@"News", @"Schedule", @"Rankings", @"Bracket", @"Tickets"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.elite8MenusArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Elite8Menu";
    UITableViewCell *elite8MenuCell = [self.elite8TableView  dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!elite8MenuCell) {
        elite8MenuCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    elite8MenuCell.textLabel.text = [self.elite8MenusArray objectAtIndex:indexPath.row];
    elite8MenuCell.textLabel.textColor = [UIColor whiteColor];
    return elite8MenuCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_delegate viewSelectedMenu:[self.elite8MenusArray objectAtIndex:indexPath.row]];
}

- (IBAction)hideMenu:(id)sender {
    [_delegate hideSideMenu];
}
@end
