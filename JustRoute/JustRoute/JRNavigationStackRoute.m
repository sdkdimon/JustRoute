//
//  JRViewControllerReplacementRoute.m
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

#import "JRNavigationStackRoute.h"


@interface JRNavigationStackRoute ()

@property (weak, nonatomic, readwrite) UIViewController <JRViewControllerRouting> *sourceViewController;
@property (strong, nonatomic, readwrite) NSArray <JRNavigationStackItemRoute *> *stackItemRoutes;

@end

@implementation JRNavigationStackRoute

+ (instancetype)routeWithSourceViewController:(UIViewController<JRViewControllerRouting> *)sourceViewController stackItemRoutes:(NSArray<JRNavigationStackItemRoute *> *)stackItemRoutes{
    return [[self alloc] initWithSourceViewController:sourceViewController stackItemRoutes:stackItemRoutes];
}

- (instancetype)initWithSourceViewController:(UIViewController<JRViewControllerRouting> *)sourceViewController stackItemRoutes:(NSArray<JRNavigationStackItemRoute *> *)stackItemRoutes{
    self = [super init];
    if (self != nil){
        _sourceViewController = sourceViewController;
        _stackItemRoutes = stackItemRoutes;
    }
    return self;
}

- (void)routeAnimated:(BOOL)animated completion:(void (^)())completionBlock{
    UINavigationController *navigationController = [_sourceViewController navigationController];
    NSAssert(navigationController != nil, @"Source view controller must have a navigation controller");
    
    NSMutableArray *destinationViewControllers = [[NSMutableArray alloc] init];
    for (JRNavigationStackItemRoute *stackItemRoute in _stackItemRoutes){
        [stackItemRoute loadDestinationViewController];
        [stackItemRoute setSourceViewController:_sourceViewController];
        UIViewController <JRViewControllerRouting> *destinationViewController = [stackItemRoute destinationViewController];
        [destinationViewControllers addObject:destinationViewController];
        [stackItemRoute notifyPrepareDestinationViewControllerForRoute];
    }
    [navigationController setViewControllers:destinationViewControllers animated:animated];
    for (JRNavigationStackItemRoute *stackItemRoute in _stackItemRoutes){
        [stackItemRoute unloadDestinationViewController];
    }
        
        if (completionBlock != NULL){
            completionBlock();
        }
    
}

@end
