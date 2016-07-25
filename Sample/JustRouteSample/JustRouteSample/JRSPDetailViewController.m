//
//  JRSPDetailViewController.m
//  JustRouteSample
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

#import "JRSPDetailViewController.h"
#import "JRSPEntity.h"
#import "JRSPRouter.h"

@interface JRSPDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic, readwrite) JRSPRouter *router;
@property (strong, nonatomic, readwrite) JRSPEntity *entity;

@end

@implementation JRSPDetailViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [_label setText:[_entity text]];
    HSBColor hsbColor = [_entity hsbColor];
    [[self view] setBackgroundColor:[UIColor colorWithHue:hsbColor.hue saturation:hsbColor.saturation brightness:hsbColor.brightness alpha:1.0f]];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [nextButton setTitle:@"Next >" forState:UIControlStateNormal];
    [nextButton sizeToFit];
    [nextButton addTarget:self action:@selector(nextButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
    self.navigationItem.hidesBackButton = YES;
    [[self navigationItem] setRightBarButtonItem:backBarButtonItem];
}

- (void)setEntity:(JRSPEntity *)entity{
    _entity = entity;
    if ([self isViewLoaded]){
        [_label setText:[entity text]];
        HSBColor hsbColor = [entity hsbColor];
        [[self view] setBackgroundColor:[UIColor colorWithHue:hsbColor.hue saturation:hsbColor.saturation brightness:hsbColor.brightness alpha:1.0f]];
    }
}

- (void)setRouter:(JRSPRouter *)router{
    _router = router;
    [self setEntity:[[router entityStack] lastObject]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"");
}

- (BOOL)useBackButton{
    return YES;
}
- (IBAction)toListButtonTap:(UIButton *)sender {
    [_router popToListOfEntitiesWithSender:self];
}

- (void)nextButtonTap:(UIButton *)sender{
    [_router pushEntity:nil withSender:self];
}


- (void)backButtonTap:(UIButton *)sender{
    [_router popEntityWithSender:self];
}

@end
