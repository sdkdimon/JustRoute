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

NS_ASSUME_NONNULL_BEGIN

typedef id _Nonnull (^JRRouteDestinationFactoryBlock)(void);

@interface JRRoute : NSObject

@property (strong, nonatomic, readwrite) JRRouteDestinationFactoryBlock destinationFactoryBlock;

@property (weak, nonatomic, readwrite, nullable) id owner;

@property (strong, nonatomic, readwrite, nullable) id source;
@property (strong, nonatomic, readwrite, nullable) id destination;

@property (strong, nonatomic, readwrite, nullable) NSString *identifier;
@property (assign, nonatomic, readwrite) NSInteger tag;

- (JRRoute *)prepareForRouteBlock:(void (^)(id))prepareForRouteBlock;

- (void)passAnimated:(BOOL)animated;
- (void)passAnimated:(BOOL)animated completion:(void(^_Nullable)(void))completionBlock;

- (void)passAnimated:(BOOL)animated source:(id)source;
- (void)passAnimated:(BOOL)animated source:(id)source completion:(void(^_Nullable)(void))completionBlock;

- (void)prepareForRoute;
- (void)clear;
- (void)clearWithCompletion:(void (^_Nullable)(void))completion;

- (id)createDestination;

@end

NS_ASSUME_NONNULL_END
