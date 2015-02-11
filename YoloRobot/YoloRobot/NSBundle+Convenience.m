//
//  NSBundle+Convenience.m
//  YoloRobot
//
//  Created by Ariel Rodriguez on 2/10/15.
//  Copyright (c) 2015 Ariel Rodriguez. All rights reserved.
//

#import "NSBundle+Convenience.h"
#import "Constants.h"

@implementation NSBundle (Convenience)
+ (NSBundle *)tenantBundle
{
    
    static NSBundle *tenantBundle = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths firstObject];
        
        NSString *tenantBundlePath = [documentsDirectory stringByAppendingPathComponent:@"blue.bundle"];

        tenantBundle = [NSBundle bundleWithPath:tenantBundlePath];
        
    });
    
    return tenantBundle;
    
}
@end
