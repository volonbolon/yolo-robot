//
//  ViewController.m
//  YoloRobot
//
//  Created by Ariel Rodriguez on 2/10/15.
//  Copyright (c) 2015 Ariel Rodriguez. All rights reserved.
//

#import "ViewController.h"
#import "Constants.h"

typedef NS_ENUM(NSUInteger, SelectBundleButtonTag) {
    SelectBundleButtonTag_Blue=1001,
    SelectBundleButtonTag_Red,
};

@interface ViewController ()
- (IBAction)selectBundleButtonTapped:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{

    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{

    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (IBAction)selectBundleButtonTapped:(id)sender
{
    
    NSString *selectedBundleName = nil;
    
    switch ( [(UIControl *)sender tag] ) {
        
        case SelectBundleButtonTag_Blue:
            selectedBundleName = @"blue";
            break;
            
        case SelectBundleButtonTag_Red:
            selectedBundleName = @"red";
            break;
            
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:selectedBundleName forKey:kSelectedBundleNameKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self performSegueWithIdentifier:@"presentContentSegue" sender:nil];
    
}
@end
