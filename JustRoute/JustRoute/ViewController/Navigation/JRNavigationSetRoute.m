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

@implementation JRNavigationSetRoute

+ (instancetype)routeWithDestinationViewControllerFactoryBlocks:(NSArray<JRRouteDestinationFactoryBlock> *)destinationViewControllerFactoryBlocks
                                                      routeType:(JRNavigationSetRouteType)routeType
{
    return [[self alloc] initWithDestinationViewControllerFactoryBlocks:destinationViewControllerFactoryBlocks
                                                              routeType:routeType];
}

- (instancetype)initWithDestinationViewControllerFactoryBlocks:(NSArray<JRRouteDestinationFactoryBlock> *)destinationViewControllerFactoryBlocks
                                                     routeType:(JRNavigationSetRouteType)routeType
{
    self = [super init];
    if (self != nil)
    {
        _destinationViewControllerFactoryBlocks = destinationViewControllerFactoryBlocks;
        _routeType = routeType;
    }
    return self;
}

- (void)passAnimated:(BOOL)animated source:(UIViewController *)source completion:(void (^)(void))completionBlock
{
    [super passAnimated:animated source:source completion:completionBlock];
    UINavigationController *navigationController = [self extractNavigationController:source];
    [self setSource:source];
    NSMutableArray *destinationViewControllers = [[NSMutableArray alloc] init];
    for (JRRouteDestinationFactoryBlock destinationViewControllerFactoryBlock in _destinationViewControllerFactoryBlocks)
    {
        UIViewController *destination = destinationViewControllerFactoryBlock();
        [self setDestination:destination];
        [destinationViewControllers addObject:destination];
        [self prepareForRoute];
    }
    
    switch (_routeType)
    {
        case JRNavigationSetRouteTypeReplace:
        {
            [navigationController setViewControllers:destinationViewControllers animated:animated];
        }
            break;
            
        case JRNavigationSetRouteTypeAppend:
        {
            NSMutableArray *viewControllers = [[navigationController viewControllers] mutableCopy];
            [viewControllers addObjectsFromArray:destinationViewControllers];
            [navigationController setViewControllers:viewControllers];
        }
            break;
            
        case JRNavigationSetRouteTypeAppendAndPopCurrent:
        {
            NSMutableArray *viewControllers = [[navigationController viewControllers] mutableCopy];
            [viewControllers removeLastObject];
            [viewControllers addObjectsFromArray:destinationViewControllers];
            [navigationController setViewControllers:viewControllers];
        }
            break;
            
        case JRNavigationSetRouteTypeInsert:
        {
            NSMutableArray *viewControllers = [[navigationController viewControllers] mutableCopy];
            [viewControllers insertObjects:destinationViewControllers atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [destinationViewControllers count])]];
            [navigationController setViewControllers:viewControllers];
        }
            break;
            
        case JRNavigationSetRouteTypeCustom:
        {
            NSAssert(_customSetRouteBlock != NULL, @"customSetRouteBlock can not be NULL");
            [navigationController setViewControllers:_customSetRouteBlock([navigationController viewControllers], destinationViewControllers)];
        }
            break;
            
        default:
            break;
    }
    
    [self clearWithCompletion:completionBlock];
}

@end
