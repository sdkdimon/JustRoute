//
//  JRSPEntityService.m
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

#import "JRSPRouter.h"
#import <JustRoute/JRViewControllerRouting.h>
#import <JustRoute/JRNavigationPushRoute.h>
#import <JustRoute/JRNavigationPopRoute.h>
#import "JRSPDetailViewControllerInput.h"
#import "JRSPEntity.h"
#import "JRSPHSBColorRandGenerator.h"

typedef enum {
    JRSPRouteTypeUnknown = 0,
    JRSPRouteTypePush,
    JRSPRouteTypePop,
    JRSPRouteTypePopToRoot
}JRSPRouteType;

static NSString * const PUSH_ROUTE_IDENTIFIER = @"pushRoute";

@interface JRSPRouter () <JRViewControllerRouting>

@property (strong, nonatomic, readwrite) NSMutableArray *entityStack;
@property (strong, nonatomic, readwrite) UIStoryboard *mainStoryboard;
@end

@implementation JRSPRouter

- (instancetype)init{
    self = [super init];
    if (self != nil){
        JRSPHSBColorRandGenerator *colorGenerator = [[JRSPHSBColorRandGenerator alloc] init];

        NSMutableArray *entities = [[NSMutableArray alloc] init];
        for (int idx = 0; idx < 20; idx++){
            JRSPEntity *entity = [[JRSPEntity alloc] init];
            [entity setText:[NSString stringWithFormat:@"Entity %@",@(idx)]];
            [entity setHsbColor:[colorGenerator hsbColorRandMake]];
            [entities addObject:entity];
        }
        [self setEntities:[entities copy]];
        
        _mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _entityStack = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)pushEntity:(JRSPEntity *)entity withSender:(UIViewController *)sender{
    if (entity == nil){
        
        NSUInteger nextEntityIdx = [_entities indexOfObject:[_entityStack lastObject]] + 1;
        if (nextEntityIdx < [_entities count]){
            entity = [_entities objectAtIndex:nextEntityIdx];
            [_entityStack addObject:entity];
        } else{
            return;
        }
        
    } else {
       [_entityStack addObject:entity];
    }
    JRViewControllerRoute *route = [JRNavigationPushRoute routeWithSourceViewController:sender destinationViewControllerFactoryBlock:^UIViewController<JRViewControllerRouting> *{
        return [[self mainStoryboard] instantiateViewControllerWithIdentifier:@"JRSPDetailViewController"];
    }];
    [route setTag:JRSPRouteTypePush];
    [route setDelegate:self];
    
    [route routeAnimated:YES completion:nil];
}
- (void)popEntityWithSender:(UIViewController *)sender{
    if ([_entityStack count] > 0){
        JRViewControllerRoute *route = [JRNavigationPopRoute routeWithSourceViewController:sender destinationViewController:nil routeType:JRNavigationPopRouteTypeDefault];
        [route setTag:JRSPRouteTypePop];
        [route setDelegate:self];
        
        NSUInteger lastEntityIdx = [_entityStack count] - 1;
        [_entityStack removeObjectAtIndex:lastEntityIdx];
        
        [route routeAnimated:YES completion:nil];
    }
    
}

- (void)popToListOfEntitiesWithSender:(UIViewController *)sender{
    if ([_entityStack count] > 0){
        JRViewControllerRoute *route = [JRNavigationPopRoute routeWithSourceViewController:sender destinationViewController:nil routeType:JRNavigationPopRouteTypeToRoot];
        [route setTag:JRSPRouteTypePopToRoot];
        [route setDelegate:self];
        [_entityStack removeAllObjects];
        [route routeAnimated:YES completion:nil];
    }
}

- (void)prepareForRoute:(JRViewControllerRoute *)route{
    id destinationViewController = [route destinationViewController];
    
    switch ([route tag]) {
        case JRSPRouteTypePush:{
            if (destinationViewController != nil && [destinationViewController conformsToProtocol:@protocol(JRSPDetailViewControllerInput)]){
                UIViewController <JRSPDetailViewControllerInput> *detailInputViewController = destinationViewController;
                [detailInputViewController setRouter:self];
            }
        }
            break;
        case JRSPRouteTypePop:{
            
        }
            break;
            
        case JRSPRouteTypePopToRoot:{
            
        }
            break;
            
        default:
            break;
    }
    
    
    
}

@end
