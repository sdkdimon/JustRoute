//
//  JRRoute.h
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

#import <UIKit/UIKit.h>
#import "JRRouting.h"

@protocol JRRouteDelegate;

@interface JRRoute : NSObject <JRRouting>{
@protected
    __strong UIViewController *_sourceViewController;
    __strong UIViewController *_destinationViewController;
}

@property (strong, nonatomic, readwrite) NSString *identifier;
@property (assign, nonatomic, readwrite) NSInteger tag;
@property (strong, nonatomic, readwrite) id params;

- (void)passAnimated:(BOOL)animated sender:(id)sender;
- (void)passAnimated:(BOOL)animated sender:(id)sender completion:(void(^)(void))completionBlock;


- (void)passAnimated:(BOOL)animated;
- (void)passAnimated:(BOOL)animated completion:(void(^)(void))completionBlock;

- (void)passAnimated:(BOOL)animated sourceViewController:(UIViewController *)sourceViewController;
- (void)passAnimated:(BOOL)animated sourceViewController:(UIViewController *)sourceViewController completion:(void(^)(void))completionBlock;

@property (weak, nonatomic, readwrite) id <JRRouteDelegate> delegate;


@property (weak, nonatomic, readwrite) id owner;
@property (strong, nonatomic, readwrite) id sender;

@property (strong, nonatomic, readwrite) UIViewController *sourceViewController;
@property (strong, nonatomic, readwrite) UIViewController *destinationViewController;

- (UIViewController *)findSourceViewController;

- (void)prepareForRoute;
- (void)clear;

@end

@interface JRRoute (Deprecated)

- (void)passFromViewController:(UIViewController *)sender animated:(BOOL)animated completion:(void(^)(void))completionBlock;

@end
