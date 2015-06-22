//
//  RankingsCell.h
//  Elite 8 D2W
//
//  Created by Hassan Al Rawi on 2/24/14.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankingsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel* rank;
@property (weak, nonatomic) IBOutlet UILabel* school;
@property (weak, nonatomic) NSURL* schoolURL;
//@property (weak, nonatomic) IBOutlet UILabel* previous;
@property (weak, nonatomic) IBOutlet UILabel* record;
//@property (weak, nonatomic) IBOutlet UILabel* points;
@end
