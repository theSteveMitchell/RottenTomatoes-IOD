//
//  MovieDetailsViewController.m
//  RottenTomatoes
//
//  Created by Steve Mitchell on 10/21/15.
//  Copyright © 2015 Steve Mitchell. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "UIImageview+AFNetworking.h"
#import "JTProgressHUD.h"


@interface MovieDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieSynopsisLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *movieDetailsScrollView;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UIImageView *errorView;
@property (weak, nonatomic) IBOutlet UIImageView *errorIcon;

@end

@implementation MovieDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.errorView.hidden = YES;
    
    [JTProgressHUD show];
   
    NSString *originalUrlString = self.movie[@"posters"][@"original"];
    NSRange range = [originalUrlString rangeOfString:@".*cloudfront.net/"
                                             options:NSRegularExpressionSearch];
    NSString *newUrlString = [originalUrlString stringByReplacingCharactersInRange:range
                                                                        withString:@"https://content6.flixster.com/"];
    
    NSLog(@"%@", newUrlString);
    NSURL *url = [NSURL URLWithString:newUrlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    [self.posterImageView setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@""] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [JTProgressHUD hide];
         NSLog(@"%@", response);
        [self.posterImageView setImage:image];
    }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                             //self.errorLabel.text = @"Network Error";
                                             //self.errorView.hidden = NO;
                                         }];
    //[JTProgressHUD hide];
    
    self.movieTitleLabel.text = self.movie[@"title"];
    
    self.movieSynopsisLabel.text = self.movie[@"synopsis"];
    [self.movieSynopsisLabel sizeToFit];
    
    [self.movieDetailsScrollView addSubview:self.movieTitleLabel];
    [self.movieDetailsScrollView addSubview:self.movieSynopsisLabel];
    
    CGFloat contentHeight = 30;
    for (UIView *view in self.movieDetailsScrollView.subviews) {
        contentHeight += view.frame.size.height;
    }
    self.movieDetailsScrollView.contentSize = CGSizeMake(self.movieDetailsScrollView.bounds.size.width, contentHeight);
    NSLog(@"%f", contentHeight);
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
