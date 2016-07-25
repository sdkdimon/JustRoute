//
//  JRNavigationSetRoute.m
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

#import "JRNavigationSetRoute.h"


@interface JRNavigationSetRoute ()

@property (weak, nonatomic, readwrite) UIViewController <JRViewControllerRouting> *sourceViewController;
@property (strong, nonatomic, readwrite) NSArray <JRNavigationItemRoute *> *stackItemRoutes;

@end

@implementation JRNavigationSetRoute

+ (instancetype)routeWithSourceViewController:(UIViewController *)sourceViewController stackItemRoutes:(NSArray<JRNavigationItemRoute *> *)stackItemRoutes routeType:(JRNavigationSetRouteType)routeType{
    return [[self alloc] initWithSourceViewController:sourceViewController stackItemRoutes:stackItemRoutes routeType:routeType];
}

- (instancetype)initWithSourceViewController:(UIViewController *)sourceViewController stackItemRoutes:(NSArray<JRNavigationItemRoute *> *)stackItemRoutes routeType:(JRNavigationSetRouteType)routeType{
    self = [super init];
    if (self != nil){
        _sourceViewController = sourceViewController;
        _stackItemRoutes = stackItemRoutes;
        _routeType = routeType;
    }
    return self;
}

- (void)routeAnimated:(BOOL)animated completion:(void (^)())completionBlock{
    UINavigationController *navigationController = [_sourceViewController navigationController];
    NSAssert(navigationController != nil, @"Source view controller must have a navigation controller");
    
    NSMutableArray *destinationViewControllers = [[NSMutableArray alloc] init];
    for (JRNavigationItemRoute *stackItemRoute in _stackItemRoutes){
        [stackItemRoute loadDestinationViewController];
        [stackItemRoute setSourceViewController:_sourceViewController];
        UIViewController *destinationViewController = [stackItemRoute destinationViewController];
        [destinationViewControllers addObject:destinationViewController];
        [stackItemRoute prepareForRoute];
    }
    
    switch (_routeType) {
        case JRNavigationSetRouteTypeReplace:{
            [navigationController setViewControllers:destinationViewControllers animated:animated];
        }
            break;
            
        case JRNavigationSetRouteTypeAppend:{
            NSMutableArray *viewControllers = [[navigationController viewControllers] mutableCopy];
            [viewControllers addObjectsFromArray:destinationViewControllers];
            [navigationController setViewControllers:viewControllers];
        }
            break;
            
        case JRNavigationSetRouteTypeInsert:{
            NSMutableArray *viewControllers = [[navigationController viewControllers] mutableCopy];
            [viewControllers insertObjects:destinationViewControllers atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [destinationViewControllers count])]];
            [navigationController setViewControllers:viewControllers];
        }
            break;
            
        case JRNavigationSetRouteTypeCustom:{
             NSAssert(_customSetRouteBlock != NULL, @"customSetRouteBlock can not be NULL");
            [navigationController setViewControllers:_customSetRouteBlock([navigationController viewControllers], destinationViewControllers)];
        }
            break;
            
        default:
            break;
    }
    
    
    for (JRNavigationItemRoute *stackItemRoute in _stackItemRoutes){
        [stackItemRoute unloadDestinationViewController];
    }
        
        if (completionBlock != NULL){
            completionBlock();
        }
    
}

@end
