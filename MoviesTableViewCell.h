//
//  MoviesTableViewCell.h
//  RottenTomatoes
//
//  Created by Steve Mitchell on 10/21/15.
//  Copyright © 2015 Steve Mitchell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;

@end
