//
//  JRViewControllerPresentRoute.m
//  JustRoute
//
//  Created by dimon on 10/08/16.
//  Copyright © 2016 dimon. All rights reserved.
//

#import "JRViewControllerPresentRoute.h"

@implementation JRViewControllerPresentRoute

- (void)route:(UIViewController *)sender animated:(BOOL)animated completion:(void (^)())completionBlock{
    NSAssert(sender != nil, @"Source view controller can not be nil");
    [self setSourceViewController:sender];
    [self setDestinationViewController:_destinationViewControllerFactoryBlock()];
    [self prepareForRoute];
    [sender presentViewController:_destinationViewController animated:animated completion:completionBlock];
    [self setDestinationViewController:nil];
    [self setSourceViewController:nil];
}

@end
