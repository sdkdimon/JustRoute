//
//  JRWindowRoute.m
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

#import "JRWindowRoute.h"

@interface JRWindowRoute ()

@property (strong, nonatomic, readwrite) UIWindow *destinationWindow;


@end

@implementation JRWindowRoute

- (void)passAnimated:(BOOL)animated sourceViewController:(UIViewController *)sourceViewController completion:(void (^)(void))completionBlock{
    [super passAnimated:animated sourceViewController:sourceViewController completion:completionBlock];
    NSAssert(_windowFactoryBlock != nil, @"windowFactoryBlock can not be NULL");
    UIWindow *window = _windowFactoryBlock();
    [self setSourceViewController:sourceViewController];
    [self setDestinationViewController:[window rootViewController]];
    [self prepareForRoute];
    [self setDestinationWindow:window];
    [window makeKeyAndVisible];
    [self clear];
}

- (void)passReverseFromViewController:(UIViewController *)sender animated:(BOOL)animated completion:(void (^)(void))completionBlock{
    [self setSourceViewController:sender];
    [self setDestinationViewController:[_sourceWindow rootViewController]];
    [self prepareForRoute];
    [self setSourceWindow:nil];
    [self setDestinationWindow:nil];
    [self clear];
}



@end
