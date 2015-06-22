//
//  ErieHubViewController.m
//  NCAA App
//
//  Created by Hassan Al Rawi on 1/7/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import "ErieHubViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ErieHubViewController ()

@end

@implementation ErieHubViewController

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
    //self.erieMenusArray = @[@"Arena", @"Maps", @"Weather", @"Contributors", @"Tickets"];
    self.erieMenusArray = @[@"Arena", @"Maps", @"Tickets"];
    self.view.backgroundColor = [UIColor clearColor];
    self.erieHubTableView.delegate = self;
    self.erieHubTableView.dataSource = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.erieMenusArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ErieHubMenuCell";
    UITableViewCell *erieHubMenuCell = [self.erieHubTableView  dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!erieHubMenuCell) {
        erieHubMenuCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    erieHubMenuCell.textLabel.text = [self.erieMenusArray objectAtIndex:indexPath.row];
    erieHubMenuCell.textLabel.textColor = [UIColor whiteColor];
    return erieHubMenuCell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView = self.erieHubTableView;
    NSLog(@"user selected row:%@", [self.erieMenusArray objectAtIndex:indexPath.row]);
    [_delegate viewSelectedMenu:[self.erieMenusArray objectAtIndex:indexPath.row]];
}


- (IBAction)hideMenu:(id)sender {
    [_delegate hideSideMenu];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

@end
