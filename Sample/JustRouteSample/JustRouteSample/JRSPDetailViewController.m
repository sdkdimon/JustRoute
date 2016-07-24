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

@interface JRSPDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation JRSPDetailViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [_label setText:[_entity text]];
    HSBColor hsbColor = [_entity hsbColor];
    [[self view] setBackgroundColor:[UIColor colorWithHue:hsbColor.hue saturation:hsbColor.saturation brightness:hsbColor.brightness alpha:1.0f]];
    
}

- (void)setEntity:(JRSPEntity *)entity{
    _entity = entity;
    if ([self isViewLoaded]){
        [_label setText:[entity text]];
        HSBColor hsbColor = [entity hsbColor];
        [[self view] setBackgroundColor:[UIColor colorWithHue:hsbColor.hue saturation:hsbColor.saturation brightness:hsbColor.brightness alpha:1.0f]];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"");
}

- (BOOL)useBackButton{
    return YES;
}

- (void)backButtonTap:(UIButton *)sender{
  //  [[self navigationController] popViewControllerAnimated:YES];
}

@end
