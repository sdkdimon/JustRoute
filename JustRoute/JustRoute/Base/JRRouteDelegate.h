//
//  JRRouteDelegate.h
//  JustRoute
//
//  Created by dimon on 12/08/16.
//  Copyright © 2016 dimon. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JRRoute;

@protocol JRRouteDelegate <NSObject>

- (void)prepareForRoute:(JRRoute *)route;

@end
