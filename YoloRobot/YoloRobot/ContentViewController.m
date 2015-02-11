//
//  ContentViewController.m
//  YoloRobot
//
//  Created by Ariel Rodriguez on 2/10/15.
//  Copyright (c) 2015 Ariel Rodriguez. All rights reserved.
//

#import "ContentViewController.h"
#import "NSBundle+Convenience.h"

@interface ContentViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSBundle *b = [NSBundle tenantBundle];

    NSString *title = NSLocalizedStringFromTableInBundle(@"title", @"Localizable", b, nil);

    [[self label] setText:title];
    
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
