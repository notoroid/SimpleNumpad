//
//  IDPNumpadViewController.m
//  IDPSimpleNumpad
//
//  Created by 能登 要 on 2015/07/02.
//  Copyright (c) 2015年 Irimasu Densan Planning. All rights reserved.
//

#import "IDPNumpadViewController.h"


@interface IDPNumpadViewController () <UIGestureRecognizerDelegate>
{
    __weak IBOutlet IDPNumberDisplay *_numberDisplay;
    __weak IBOutlet IDPNumpadView *_numpadView;
}
@end

@implementation IDPNumpadViewController

+ (IDPNumpadViewController *)numpadViewControllerWithStyle:(IDPNumpadViewControllerStyle )style
{
    id viewController = nil;
    @autoreleasepool {
        NSDictionary *styles = @{
              @(IDPNumpadViewControllerStyleDefault):@"darkNinja"
             ,@(IDPNumpadViewControllerStyleStandard):@"standardCB"
             ,@(IDPNumpadViewControllerStylePro):@"proCB"
             ,@(IDPNumpadViewControllerStyleRetro):@"retroCB"
             ,@(IDPNumpadViewControllerStyleMelancholy):@"melancholyCB"
             ,@(IDPNumpadViewControllerStyleMemories):@"memoriesCB"
             ,@(IDPNumpadViewControllerStyleFusion):@"fusion"
             ,@(IDPNumpadViewControllerStylePeach):@"freshPeachLL"
             ,@(IDPNumpadViewControllerStyleGreen):@"freshGreenLL"
             ,@(IDPNumpadViewControllerStylePurple):@"freshPurpleLL"
             ,@(IDPNumpadViewControllerStyleCalcApp):@"calcapp"
        };

        
        NSString *identifier = styles[@(style)];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"IDPNumpadViewController" bundle:nil];
       viewController = [storyboard  instantiateViewControllerWithIdentifier:identifier != nil ? identifier : styles[@(IDPNumpadViewControllerStyleDefault)]];
    }
    return viewController;
}

+ (IDPNumpadViewController *)numpadViewControllerWithStyle:(IDPNumpadViewControllerStyle )style showNumberDisplay:(BOOL)showNumberDisplay
{
    IDPNumpadViewController *numpadViewController = [IDPNumpadViewController numpadViewControllerWithStyle:style];
    if( showNumberDisplay != YES ){
        numpadViewController.hideNumberDisplay = YES;
    }
    return numpadViewController;
}

- (IDPNumberDisplay *)numberDisplay
{
    return _numberDisplay;
}

- (IDPNumpadView *)numpadView
{
    return _numpadView;
}

- (NSString *)displayText
{
    return _numpadView.displayText;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _numpadView.text = [@(_value) description];
    _numberDisplay.displayLabel.text = _numpadView.displayText;
    
    if( _hideNumberDisplay ){
        [_numberDisplay removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) numpadViewDidUpdate:(IDPNumpadView *)numpadView
{
    _numberDisplay.displayLabel.text = _numpadView.displayText;

    _value = numpadView.value;
    if( [_delegate respondsToSelector:@selector(numpadViewControllerDidUpdate:)] ){
        [_delegate numpadViewControllerDidUpdate:self];
    }
    
}

- (void) numpadViewDidEnter:(IDPNumpadView *)numpadView
{
    if( [_delegate respondsToSelector:@selector(numpadViewControllerDidEnter:)] ){
        [_delegate numpadViewControllerDidEnter:self];
    }
}

- (UIModalPresentationStyle)modalPresentationStyle
{
    return UIModalPresentationOverCurrentContext;
}

- (BOOL) gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    BOOL shouldBegin = YES;
    
    if( _numberDisplay != nil ){
        CGPoint location = [gestureRecognizer locationInView:_numberDisplay.superview];
        if( CGRectContainsPoint(_numberDisplay.frame, location)){
                shouldBegin = NO;
        }
    }
    if( _numpadView != nil ){
        CGPoint location = [gestureRecognizer locationInView:_numpadView.superview];
        if( CGRectContainsPoint(_numpadView.frame, location)){
            shouldBegin = NO;
        }
    }
    
    return shouldBegin;
}

- (IBAction)onCancel:(id)sender
{
    if( [_delegate respondsToSelector:@selector(numpadViewControllerDidCancel:)] ){
        [_delegate numpadViewControllerDidCancel:self];
    }
}

@end
