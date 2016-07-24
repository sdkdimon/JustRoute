//
//  ViewController.m
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

#import "JRSPMainViewController.h"
#import "JRSPEntity.h"
#import "JRSPDetailViewControllerInput.h"
#import "JRSPHSBColorRandGenerator.h"
#import <JustRoute/JRNavigationPushRoute.h>


@interface JRSPMainViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign, nonatomic, readwrite) NSUInteger selectedEntityIdx;

@property (strong, nonatomic, readwrite) UIStoryboard *mainStoryboard;

@end

@implementation JRSPMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    __weak typeof (self) welf = self;
    
    _detailsRoute = [JRNavigationPushRoute routeWithSourceViewController:self  destinationViewControllerFactoryBlock:^UIViewController<JRViewControllerRouting> *{
        return [[welf mainStoryboard] instantiateViewControllerWithIdentifier:@"JRSPDetailViewController"];
    }];
    
    
    JRSPHSBColorRandGenerator *colorGenerator = [[JRSPHSBColorRandGenerator alloc] init];
    
    NSMutableArray *entities = [[NSMutableArray alloc] init];
    for (int idx = 0; idx < 20; idx++){
        JRSPEntity *entity = [[JRSPEntity alloc] init];
        [entity setText:[NSString stringWithFormat:@"Entity %@",@(idx)]];
        [entity setHsbColor:[colorGenerator hsbColorRandMake]];
        [entities addObject:entity];
    }
    [self setEntities:[entities copy]];
    
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_entities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    NSUInteger entityIdx = [indexPath row];
    JRSPEntity *entity = [_entities objectAtIndex:entityIdx];
    
    UILabel *textLabel = [cell textLabel];
    [textLabel setText:[entity text]];
    
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     _selectedEntityIdx = [indexPath row];
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_detailsRoute routeAnimated:YES completion:nil];
}

- (void)prepareForRoute:(JRViewControllerRoute *)route{
    id destinationViewController = [route destinationViewController];
    if ([destinationViewController conformsToProtocol:@protocol(JRSPDetailViewControllerInput)]){
        UIViewController <JRSPDetailViewControllerInput> *detailInputViewController = destinationViewController;
        [detailInputViewController setEntity:[_entities objectAtIndex:_selectedEntityIdx]];
    }
}


@end
