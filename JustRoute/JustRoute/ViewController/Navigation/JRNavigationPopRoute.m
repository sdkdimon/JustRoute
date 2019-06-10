//
//  JRNavigationPopRoute.m
//  Copyright (c) 2016 Dmitry Lizin (sdkdimon@gmail.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "JRNavigationPopRoute.h"

@implementation JRNavigationPopRoute

- (void)passAnimated:(BOOL)animated source:(UIViewController *)source completion:(void (^)(void))completionBlock
{
    [super passAnimated:animated source:source completion:completionBlock];
    
    UINavigationController *navigationController = [self extractNavigationController:source];
    [self setSource:source];
    
    switch (_routeType)
    {
        case JRNavigationPopRouteTypeDefault:
        {
            [self handlePopToViewControllerPassAnimated:animated
                                                 source:navigationController.topViewController
                                   navigationController:navigationController];
        }
            break;
            
        case JRNavigationPopRouteTypeFromSource:
        {
            [self handlePopToViewControllerPassAnimated:animated
                                                 source:source
                                   navigationController:navigationController];
        }
            break;
            
        case JRNavigationPopRouteTypeToRoot:
        {
            NSArray <UIViewController *> *viewControllers = navigationController.viewControllers;
            self.destination = viewControllers.firstObject;
            [self prepareForRoute];
            [navigationController popToRootViewControllerAnimated:animated];
        }
            
        default:
            break;
    }
    
    [self clearWithCompletion:completionBlock];
}


- (void)handlePopToViewControllerPassAnimated:(BOOL)animated
                                       source:(UIViewController *)source
                         navigationController:(UINavigationController *)navigationController
{
    if (self.destination == nil)
    {
        NSArray <UIViewController *> *viewControllers = navigationController.viewControllers;
        __block NSUInteger indexOfSource = [viewControllers indexOfObject:source];

        if (![viewControllers containsObject:source]){
            [viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.childViewControllers containsObject:source]) {
                    indexOfSource = idx;
                    *stop = YES;
                }
            }];
        }

        if (indexOfSource > 0)
        {
            self.destination = [viewControllers objectAtIndex:indexOfSource - 1];
        }
    }
    [self prepareForRoute];
    [navigationController popToViewController:self.destination animated:animated];
}

@end
