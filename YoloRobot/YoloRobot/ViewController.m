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

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

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

- (void)enableButtons:(BOOL)enable
{
    
    for ( UIButton *b in [self buttons] ) {
        
        [b setEnabled:enable];
        
    }
    
}

- (IBAction)selectBundleButtonTapped:(id)sender
{

    NSString *urlString = nil;
    
    switch ( [(UIControl *)sender tag] ) {
            
        case SelectBundleButtonTag_Blue:
            urlString = @"https://s3.amazonaws.com/fwkhackaton/blue.bundle.zip";
            break;
            
        case SelectBundleButtonTag_Red:
            urlString = @"https://s3.amazonaws.com/fwkhackaton/red.bundle.zip";
            break;
            
    }
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    __weak typeof(self)weakSelf = self;
    NSURLSessionDataTask *bundleTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        if ( !error ) {
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths firstObject];
            NSString *zippedTenantPath = [documentsDirectory stringByAppendingPathComponent:@"tenant.zip"];
            
            [data writeToFile:zippedTenantPath atomically:YES];
            
            BOOL success = [SSZipArchive unzipFileAtPath:zippedTenantPath toDestination:documentsDirectory overwrite:YES password:nil error:&error];
            
            if ( !success ) {
                
                NSLog(@"%@", error);
                
            } else {
                
                NSError *fme = nil;
                BOOL s = [[NSFileManager defaultManager] removeItemAtPath:zippedTenantPath error:&fme];
                if ( !s ) {
                    
                    NSLog(@"%@", fme);
                    
                }
                
                NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&fme];
                
                [files enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    
                    if ( [[(NSString *)obj pathExtension] isEqualToString:@"bundle"] ) {
                        
                        NSError *tbpe = nil;
                        NSString *tenantBundlePath = [documentsDirectory stringByAppendingPathComponent:kTenantBundleNameName];
                        NSString *tmpBundlePath = [documentsDirectory stringByAppendingPathComponent:(NSString *)obj];
                        
                        BOOL s = [[NSFileManager defaultManager] moveItemAtPath:tmpBundlePath toPath:tenantBundlePath error:&tbpe];
                        
                        if ( !s ) {
                            
                            NSLog(@"tbpe: %@", tbpe);
                            
                        }
                        
                        *stop = YES;
                        
                    }
                    
                }];
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    
                    [[strongSelf activityIndicator] stopAnimating];
                    [strongSelf enableButtons:YES];
                    
                    [strongSelf performSegueWithIdentifier:@"presentContentSegue" sender:nil];
                    
                }];
                
            }
            
        } else {
            
            NSLog(@"%@", error);
            
        }
        
    }];
    
    [self enableButtons:NO];
    
    [[self activityIndicator] startAnimating];
    
    [bundleTask resume];

}
@end
