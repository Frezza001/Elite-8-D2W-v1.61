//
//  NewsCustomCell.m
//  NCAA App
//
//  Created by Hassan Al Rawi on 12/18/13.
//  Copyright (c) 2014 Gannon University. All rights reserved.
//

#import "NewsCustomCell.h"

@implementation NewsCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(NewsCustomCell *) setupPicture: (UIImage *)pic {
    // Make this image smaller...
    CGFloat properScale = 0.75f;
    CGFloat idealImageWidth = properScale * self.bounds.size.width;

    if (pic.size.width > idealImageWidth) { // make the image smaller
        CGSize maxPicSize = CGSizeMake(properScale * self.bounds.size.width, properScale * self.bounds.size.height);
        [self.newsCellImage setBounds:CGRectMake(0,0, maxPicSize.width, maxPicSize.height)];
    }
    else { //only use the space that the image needs
        [self.newsCellImage setBounds:CGRectMake(0,0, pic.size.width,pic.size.height)];
    }
    [self.newsCellImage setImage: pic];
//    NSLog(@"Image Width: = %f", self.newsCellImage.bounds.size.width);
//    NSLog(@"Image Width: = %f", self.newsCellImage.bounds.size.height);
    return self;
}

@end
