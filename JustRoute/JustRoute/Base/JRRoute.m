//
//  JRRoute.m
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

#import "JRRoute.h"

#import "JRRouteDelegate.h"

@interface JRRoute ()

@property (strong, nonatomic, readwrite) void (^prepareForRouteBlock)(id);

@end

@implementation JRRoute
@synthesize sourceViewController = _sourceViewController;
@synthesize destinationViewController = _destinationViewController;

- (JRRoute *)prepareForRouteBlock:(void (^)(id))prepareForRouteBlock
{
    _prepareForRouteBlock = [prepareForRouteBlock copy];
    return self;
}

- (void)passAnimated:(BOOL)animated
{
    [self passAnimated:animated completion:NULL];
}

- (void)passAnimated:(BOOL)animated completion:(void(^)(void))completionBlock
{
    [self passAnimated:animated sourceViewController:[self findSourceViewController] completion:completionBlock];
}

- (void)passAnimated:(BOOL)animated sourceViewController:(UIViewController *)sourceViewController
{
    [self passAnimated:animated sourceViewController:sourceViewController completion:NULL];
}

- (void)passAnimated:(BOOL)animated sourceViewController:(UIViewController *)sourceViewController completion:(void (^)(void))completionBlock
{
    NSAssert(sourceViewController != nil, @"Source view controller can't be nil");
}

- (void)prepareForRoute
{
    if (_prepareForRouteBlock != NULL)
    {
        _prepareForRouteBlock(self);
    }
    
    if (_delegate != nil && [_delegate respondsToSelector:@selector(prepareForRoute:)])
    {
        [_delegate prepareForRoute:self];
    }
}

- (void)clear
{
    [self setSourceViewController:nil];
    [self setDestinationViewController:nil];
    [self setParams:nil];
    self.prepareForRouteBlock = NULL;
}

- (UIViewController *)findSourceViewController
{
    if (_owner != nil && [_owner isKindOfClass:[UIViewController class]]) return _owner;
    [[NSException exceptionWithName:@"SourceViewControllerNotFoundException" reason:@"Can't find source view controller" userInfo:nil] raise];
    return nil;
}

@end

@implementation JRRoute (Deprecated)

- (void)passFromViewController:(UIViewController *)sender animated:(BOOL)animated completion:(void(^)(void))completionBlock
{
    [self passAnimated:animated sourceViewController:sender completion:completionBlock];
}

@end
