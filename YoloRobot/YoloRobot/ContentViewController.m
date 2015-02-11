//
//  ContentViewController.m
//  YoloRobot
//
//  Created by Ariel Rodriguez on 2/10/15.
//  Copyright (c) 2015 Ariel Rodriguez. All rights reserved.
//

#import "ContentViewController.h"
#import "NSBundle+Convenience.h"
#import "UIColor+Helpers.h"

@interface ContentViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSBundle *b = [NSBundle tenantBundle];

    NSString *title = NSLocalizedStringFromTableInBundle(@"title", @"Localizable", b, nil);
    
    NSURL *colorsDictURL = [b URLForResource:@"Colors" withExtension:@"plist"];
    NSDictionary *colors = [[NSDictionary alloc] initWithContentsOfURL:colorsDictURL];

    UIColor *background = [UIColor colorWithHexString:[colors objectForKey:@"background"]];
    UIColor *foreground = [UIColor colorWithHexString:[colors objectForKey:@"foreground"]];
    
    UIImage *image = [UIImage imageNamed:@"Images/pic" inBundle:b compatibleWithTraitCollection:nil];
    
    [[self imageView] setImage:image];
    
    [[self label] setTextColor:foreground];
    [[self label] setText:title];
    
    [[self view] setBackgroundColor:background];
    
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
