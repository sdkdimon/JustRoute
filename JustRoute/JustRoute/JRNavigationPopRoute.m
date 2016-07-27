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

+ (instancetype)routeWithDestinationViewController:(UIViewController *)destinationViewController routeType:(JRNavigationPopRouteType)routeType{
    return [[self alloc] initWithDestinationViewController:destinationViewController routeType:routeType];
}

- (instancetype)initWithDestinationViewController:(UIViewController *)destinationViewController routeType:(JRNavigationPopRouteType)routeType{
    self = [super init];
    if (self != nil){
        _destinationViewController = destinationViewController;
        _routeType = routeType;
    }
    return self;
}

- (void)route:(UIViewController *)sender animated:(BOOL)animated completion:(void (^)())completionBlock{
    UINavigationController *navigationController = [self extractNavigationController:sender];
    [self setSourceViewController:sender];
    [self prepareForRoute];
    switch (_routeType) {
        case JRNavigationPopRouteTypeDefault:{
          
            if (_destinationViewController != nil){
                [navigationController popToViewController:_destinationViewController animated:animated];
            }else{
                [navigationController popViewControllerAnimated:animated];
            }
        }
            break;
        case JRNavigationPopRouteTypeToRoot:{
            [navigationController popToRootViewControllerAnimated:animated];
        }
            
        default:
            break;
    }
    
    [self setSourceViewController:nil];
    [self setDestinationViewController:nil];
    if (completionBlock != NULL){
        completionBlock();
    }
    
    
    
}

@end
