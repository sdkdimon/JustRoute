//
//  JRViewControllerPresentRoute.h
//  JustRoute
//
//  Created by dimon on 10/08/16.
//  Copyright © 2016 dimon. All rights reserved.
//

#import "JRViewControllerRoute.h"

@interface JRViewControllerPresentRoute : JRViewControllerRoute

@property (strong, nonatomic, readwrite) JRViewControllerFactoryBlock destinationViewControllerFactoryBlock;

@end
