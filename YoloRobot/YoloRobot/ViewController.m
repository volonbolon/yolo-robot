//
//  ViewController.m
//  YoloRobot
//
//  Created by Ariel Rodriguez on 2/10/15.
//  Copyright (c) 2015 Ariel Rodriguez. All rights reserved.
//

#import "ViewController.h"
#import "Constants.h"
#import "SSZipArchive.h"

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

    NSString *zipPath = [[NSBundle mainBundle] pathForResource:@"blue.bundle" ofType:@"zip"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    
    NSError *error = nil;
    BOOL success = [SSZipArchive unzipFileAtPath:zipPath toDestination:documentsDirectory overwrite:YES password:nil error:&error];
    if ( !success ) {
        
        NSLog(@"%@", error);
        
    }
    
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
