//
//  NewsCustomCell.h
//  NCAA App
//
//  Created by Hassan Al Rawi on 12/18/13.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView *newsCellDetails;
@property (weak, nonatomic) IBOutlet UIImageView *newsCellImage;
@property (weak, nonatomic) IBOutlet UILabel *newsCellTitle;
@property (weak, nonatomic) NSURL * contentURL;
@property (weak, nonatomic) IBOutlet UIButton *segueButton;

-(NewsCustomCell *) setupPicture: (UIImage *)pic;
@end
