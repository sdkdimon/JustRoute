//
//  JRViewControllerDismissRoute.m
//  JustRoute
//
//  Created by dimon on 10/08/16.
//  Copyright © 2016 dimon. All rights reserved.
//

#import "JRViewControllerDismissRoute.h"

@implementation JRViewControllerDismissRoute

- (void)route:(UIViewController *)sender animated:(BOOL)animated completion:(void (^)())completionBlock{
    NSAssert(sender != nil, @"Source view controller can not be nil");
    [self setSourceViewController:sender];
    [self prepareForRoute];
    [sender dismissViewControllerAnimated:animated completion:completionBlock];
    [self setSourceViewController:nil];
}

@end
