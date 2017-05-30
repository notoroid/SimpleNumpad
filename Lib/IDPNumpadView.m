//
//  IDPNumpadView.m
//  SimpleNumpad
//
//  Created by 能登 要 on 2015/07/02.
//  Copyright (c) 2015年 Irimasu Densan Planning. All rights reserved.
//

#import "IDPNumpadView.h"
#import <QuartzCore/QuartzCore.h>
#import "EasyEaseAnimation.h"
#import <objc/runtime.h>

static const NSString * CSSimpleNumpadPressedKey  = @"CSSimpleNumpadPressedKey";
static const NSString * CSSimpleNumpadLabelViewKey  = @"CSSimpleNumpadLabelViewKey";
static const NSString * CSSimpleNumpadAnimationViewKey  = @"CSSimpleNumpadAnimationViewKey";

@interface IDPNumpadView () <UIGestureRecognizerDelegate>
{
    UILongPressGestureRecognizer *_longPressGestureRecognizer;
    
    __weak IBOutlet UIView *_button0View;
    __weak IBOutlet UIView *_button00View;
    __weak IBOutlet UIView *_button1View;
    __weak IBOutlet UIView *_button2View;
    __weak IBOutlet UIView *_button3View;
    __weak IBOutlet UIView *_button4View;
    __weak IBOutlet UIView *_button5View;
    __weak IBOutlet UIView *_button6View;
    __weak IBOutlet UIView *_button7View;
    __weak IBOutlet UIView *_button8View;
    __weak IBOutlet UIView *_button9View;
    __weak IBOutlet UIView *_buttonEnterView;
    __weak IBOutlet UIView *_buttonBackspaceView;
    __weak IBOutlet UIView *_buttonDotView;
    
    IBOutletCollection(UIView) NSArray *_buttonViews;
    
    NSString *_text;
    
    NSMutableDictionary *_replacedNumber;
}
@end

@implementation IDPNumpadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) awakeFromNib
{
    _longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPress:)];
    [self addGestureRecognizer:_longPressGestureRecognizer];
    _longPressGestureRecognizer.delegate = self;
    _separatorUnit = @"-";
    
    [super awakeFromNib];
}

- (void) hiddenNumberSupportButton:(BOOL)hidden
{
    _button00View.hidden = hidden;
    _buttonDotView.hidden= hidden;
}

- (void) replacedNumber:(NSString *)numberName newNumber:(NSString *)newNumber
{
    NSArray *buttons = @[
     _button0View
    ,_button00View
    ,_button1View
    ,_button2View
    ,_button3View
    ,_button4View
    ,_button5View
    ,_button6View
    ,_button7View
    ,_button8View
    ,_button9View
    ,_buttonDotView
    ];
    
    if (_replacedNumber == nil ) {
        _replacedNumber = [NSMutableDictionary dictionary];
    }
    
    [buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *view = obj;
        
        [view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if( [obj isKindOfClass:[UILabel class]] ){
                UILabel *label = obj;
                if( [label.text isEqualToString:numberName] ){
                    _replacedNumber[numberName] = newNumber;
                    label.text = newNumber;
                    *stop  = YES;
                }
            }
        }];
    }];
    
}

- (CGFloat) value
{
    double value = [_text doubleValue];
    return value;
}

- (NSString *)displayText
{
    NSString *text = nil;
    if( _inputStyle == IDPNumpadViewInputStyleNumber ){
        double value = [_text doubleValue];
        
        static NSNumberFormatter *s_formatter = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            s_formatter = [[NSNumberFormatter alloc] init];
            [s_formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            [s_formatter setGroupingSeparator:@","];
            [s_formatter setGroupingSize:3];
        });
        
        text = [s_formatter stringFromNumber:@(value)];
        
        
        if( [_text hasSuffix:@"."] ){
            text = [text stringByAppendingString:@"."];
        }else{
            NSRange rangePeriodOriginal = [_text rangeOfString:@"."];
            if( rangePeriodOriginal.location != NSNotFound){
                NSArray *components = [text componentsSeparatedByString:@"."];
                NSArray *originalComponents = [_text componentsSeparatedByString:@"."];
                text = components.firstObject;
                text = [text stringByAppendingString:@"."];
                text = [text stringByAppendingString:originalComponents.lastObject];
            }
        }
    }else{
        if( self.separatorIntervals == nil ){
            self.separatorIntervals = @[@2,@2,@2];
        }
        
        NSMutableArray *separaterIntervals = [NSMutableArray arrayWithArray:self.separatorIntervals];
        __block NSUInteger totalLength = 0;
        [separaterIntervals enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            totalLength += [obj unsignedIntegerValue];
        }];
        
        
        NSString *serialText = _text;
        
        NSUInteger length = [separaterIntervals.firstObject unsignedIntegerValue];
        if( separaterIntervals.count > 1 ){
            [separaterIntervals removeObjectAtIndex:0];
        }
     
        unichar characters[3];
        unichar *iterator = characters;
        unichar *end = characters + length;
        
        NSMutableArray *components = [NSMutableArray array];
        
        for (NSInteger i = 0; i< serialText.length ; i++ ) {
            unichar character = [serialText characterAtIndex:i];
            *iterator = character;
            iterator++;
            
            if( iterator == end ){
                *iterator = 0;
                NSString *string = [NSString stringWithCharacters:characters length:length];
                [components addObject:string];
                
                length = [separaterIntervals.firstObject unsignedIntegerValue];
                if( separaterIntervals.count > 1 ){
                    [separaterIntervals removeObjectAtIndex:0];
                }
                
                iterator = characters;
            }
        }
        if( iterator != characters ){
            *iterator = 0;
            NSString *string = [NSString stringWithCharacters:characters length:iterator-characters];
            [components addObject:string];
        }
        
        text = [components componentsJoinedByString:self.separatorUnit];
    }
    
    return text;
}

- (NSString *)serialnNumber
{
    return self.displayText;
}

- (void) applyAnimationWithView:(UIView *)view press:(BOOL)press
{
    static easeblock_t easeoutBlock = ^CGFloat (CGFloat t,CGFloat b,CGFloat c,CGFloat d,NSDictionary* params){
        return (t==d) ? b+c : c * 1.001 * (-pow(2, -10 * t/d) + 1) + b;
    };
    
    CGRect frame = view.frame;
#define EDGE_SIZE 10.0
    CGFloat horizontalScale = 1.0 - EDGE_SIZE / CGRectGetWidth(frame);
    CGFloat verticalScale = 1.0 - EDGE_SIZE / CGRectGetHeight(frame);

    NSNumber *pressed = objc_getAssociatedObject(view, &CSSimpleNumpadPressedKey);
    if( press ){
        if( [pressed boolValue] != YES ){
            objc_setAssociatedObject (view, &CSSimpleNumpadPressedKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
            UIView *animationView = (UIView *)objc_getAssociatedObject(view, &CSSimpleNumpadAnimationViewKey);
            if( animationView == nil ){
                UIView *labelView = [view.subviews firstObject];
                objc_setAssociatedObject (view, &CSSimpleNumpadLabelViewKey, labelView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                    // labelViewをプロパティに格納

                animationView = [[UIView alloc] initWithFrame:(CGRect){CGPointZero,frame.size}];
                objc_setAssociatedObject (view, &CSSimpleNumpadAnimationViewKey, animationView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                animationView.backgroundColor = view.backgroundColor;
                view.backgroundColor = self.backgroundColor;
                [view addSubview:animationView];
                [view sendSubviewToBack:animationView];
            }
            
            animationView.layer.transform = CATransform3DMakeScale(horizontalScale,verticalScale, 1.0);
            animationView.layer.opacity = 0.8;
            EasyEaseAnimation* easyingAnimation = [[EasyEaseAnimation alloc]
                                                   initWithKeyPath:@"transform.scale.x"
                                                   startValue:1
                                                   endValue:horizontalScale
                                                   block:easeoutBlock
                                                   params:nil
                                                   interstitialSteps:24.0f
                                                   beginSteps:0.0f];
            
            EasyEaseAnimation* easyingAnimation2 = [[EasyEaseAnimation alloc]
                                                    initWithKeyPath:@"transform.scale.y"
                                                    startValue:1
                                                    endValue:verticalScale
                                                    block:easeoutBlock
                                                    params:nil
                                                    interstitialSteps:24.0f
                                                    beginSteps:0.0f];
            
            EasyEaseAnimation* easyingAnimation3 = [[EasyEaseAnimation alloc]
                                                    initWithKeyPath:@"opacity"
                                                    startValue:1
                                                    endValue:0.8
                                                    block:easeoutBlock
                                                    params:nil
                                                    interstitialSteps:24.0f
                                                    beginSteps:0.0f];
            
            [animationView.layer removeAllAnimations];
            [animationView.layer addAnimation:easyingAnimation forKey:@"touchDown"];
            [animationView.layer addAnimation:easyingAnimation2 forKey:@"touchDown2"];
            [animationView.layer addAnimation:easyingAnimation3 forKey:@"touchDown3"];
            
            
            UIView *labelView = (UIView *)objc_getAssociatedObject(view, &CSSimpleNumpadLabelViewKey);
            labelView.layer.transform = CATransform3DMakeScale(horizontalScale,horizontalScale, 1.0);
            EasyEaseAnimation* easyingAnimation4 = [[EasyEaseAnimation alloc]
                                                    initWithKeyPath:@"transform.scale"
                                                    startValue:1
                                                    endValue:horizontalScale
                                                    block:easeoutBlock
                                                    params:nil
                                                    interstitialSteps:24.0f
                                                    beginSteps:0.0f];
            [labelView.layer removeAllAnimations];
            [labelView.layer addAnimation:easyingAnimation4 forKey:@"touchDown4"];
        }
    }else{
        if( [pressed boolValue] != NO ){
            objc_setAssociatedObject (view, &CSSimpleNumpadPressedKey, @(NO), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
            UIView *animationView = (UIView *)objc_getAssociatedObject(view, &CSSimpleNumpadAnimationViewKey);
            
            animationView.layer.opacity = 1.0;
            animationView.layer.transform = CATransform3DMakeScale(1.0,1.0, 1.0);
            EasyEaseAnimation* easyingAnimation = [[EasyEaseAnimation alloc]
                                                   initWithKeyPath:@"transform.scale.x"
                                                   startValue:horizontalScale
                                                   endValue:1
                                                   block:easeoutBlock
                                                   params:nil
                                                   interstitialSteps:24.0f
                                                   beginSteps:0.0f];
            
            EasyEaseAnimation* easyingAnimation2 = [[EasyEaseAnimation alloc]
                                                    initWithKeyPath:@"transform.scale.y"
                                                    startValue:verticalScale
                                                    endValue:1
                                                    block:easeoutBlock
                                                    params:nil
                                                    interstitialSteps:24.0f
                                                    beginSteps:0.0f];
            
            EasyEaseAnimation* easyingAnimation3 = [[EasyEaseAnimation alloc]
                                                    initWithKeyPath:@"opacity"
                                                    startValue:0.8
                                                    endValue:1.0
                                                    block:easeoutBlock
                                                    params:nil
                                                    interstitialSteps:24.0f
                                                    beginSteps:0.0f];

            
            [animationView.layer removeAllAnimations];
            [animationView.layer addAnimation:easyingAnimation forKey:@"touchUp"];
            [animationView.layer addAnimation:easyingAnimation2 forKey:@"touchUp2"];
            [animationView.layer addAnimation:easyingAnimation3 forKey:@"touchUp3"];
            
            UIView *labelView = (UIView *)objc_getAssociatedObject(view, &CSSimpleNumpadLabelViewKey);
            labelView.layer.transform = CATransform3DMakeScale(1.0,1.0, 1.0);
            EasyEaseAnimation* easyingAnimation4 = [[EasyEaseAnimation alloc]
                                                    initWithKeyPath:@"transform.scale"
                                                    startValue:horizontalScale
                                                    endValue:1
                                                    block:easeoutBlock
                                                    params:nil
                                                    interstitialSteps:24.0f
                                                    beginSteps:0.0f];
            [labelView.layer removeAllAnimations];
            [labelView.layer addAnimation:easyingAnimation4 forKey:@"touchUp4"];

        }
    }
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [CATransaction begin];
    
    [_buttonViews enumerateObjectsUsingBlock:^(id obj,NSUInteger idx, BOOL *stop) {
        UIView *view = obj;
        CGRect frame = view.frame;
        
        CGPoint location = [[touches anyObject] locationInView:view.superview];
        if(CGRectContainsPoint(frame, location)){
            [self applyAnimationWithView:view press:YES];
        }else{
            [self applyAnimationWithView:view press:NO];
        }
        
    }];
    
    [CATransaction commit];
    
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [CATransaction begin];
 
    [_buttonViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx,BOOL *stop) {
        UIView *view = obj;
        [self applyAnimationWithView:view press:NO];
    }];
    
    [CATransaction commit];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [CATransaction begin];
    
    [_buttonViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx,BOOL *stop) {
        UIView *view = obj;
        CGRect frame = view.frame;

        CGPoint location = [[touches anyObject] locationInView:view.superview];
        if(CGRectContainsPoint(frame, location)){
            [self applyAnimationWithView:view press:YES];
        }else{
            [self applyAnimationWithView:view press:NO];
        }
        
    }];
    
    [CATransaction commit];
}

- (BOOL) canInsertZeroWithText:(NSString *)text
{
    BOOL canInsert = NO;
 
    if( _inputStyle == IDPNumpadViewInputStyleNumber ){
        double value = [_text doubleValue];
        if( value != 0.0 ){
            canInsert = YES;
        }else{
            NSRange range = [_text rangeOfString:@"."];
            if( range.location != NSNotFound ){
                canInsert = YES;
            }
        }
    }else{
        canInsert = YES;
    }
 
    return canInsert;
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    BOOL shouldReceive = YES;

    if( gestureRecognizer == _longPressGestureRecognizer ){
        CGPoint location = [touch locationInView:_buttonBackspaceView.superview];
        if( CGRectContainsPoint(_buttonBackspaceView.frame, location) != YES ){
            shouldReceive = NO;
        }
    }
    
    return shouldReceive;
}

- (void)onLongPress:(UILongPressGestureRecognizer *)longPressGestureRecognizer
{
    CGPoint location = [longPressGestureRecognizer locationInView:_buttonBackspaceView.superview];
    if(CGRectContainsPoint(_buttonBackspaceView.frame, location)){
        [self applyAnimationWithView:_buttonBackspaceView press:NO];
        _text = @"0";
        [_delegate numpadViewDidUpdate:self];
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [CATransaction begin];
    
    [_buttonViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx,BOOL *stop) {
        UIView *view = obj;
        CGRect frame = view.frame;
        
        CGPoint location = [[touches anyObject] locationInView:view.superview];
        if(CGRectContainsPoint(frame, location)){
            if(_button0View == view){
                if( [self canInsertZeroWithText:_text]){
                    _text = [_text stringByAppendingString:@"0"];
                    [_delegate numpadViewDidUpdate:self];
                }
            }else if(_button00View == view && _button00View.hidden != YES){
                if( [self canInsertZeroWithText:_text]){
                    _text = [_text stringByAppendingString:@"00"];
                    [_delegate numpadViewDidUpdate:self];
                }
            }else if(_button1View == view){
                _text = [_text stringByAppendingString:@"1"];
                [_delegate numpadViewDidUpdate:self];
            }else if(_button2View == view){
                _text = [_text stringByAppendingString:@"2"];
                [_delegate numpadViewDidUpdate:self];
            }else if(_button3View == view){
                _text = [_text stringByAppendingString:@"3"];
                [_delegate numpadViewDidUpdate:self];
            }else if(_button4View == view){
                _text = [_text stringByAppendingString:@"4"];
                [_delegate numpadViewDidUpdate:self];
            }else if(_button5View == view){
                _text = [_text stringByAppendingString:@"5"];
                [_delegate numpadViewDidUpdate:self];
            }else if(_button6View == view){
                _text = [_text stringByAppendingString:@"6"];
                [_delegate numpadViewDidUpdate:self];
            }else if(_button7View == view){
                _text = [_text stringByAppendingString:@"7"];
                [_delegate numpadViewDidUpdate:self];
            }else if(_button8View == view){
                _text = [_text stringByAppendingString:@"8"];
                [_delegate numpadViewDidUpdate:self];
            }else if(_button9View == view){
                _text = [_text stringByAppendingString:@"9"];
                [_delegate numpadViewDidUpdate:self];
            }else if(_buttonEnterView == view){
                [_delegate numpadViewDidEnter:self];
            }else if(_buttonBackspaceView == view){
                if( _text.length > 0 ){
                    _text = [_text substringToIndex:_text.length-1];
                    [_delegate numpadViewDidUpdate:self];
                }
            }else if(_buttonDotView == view && _buttonDotView.hidden != YES){
                NSRange range = [_text rangeOfString:@"."];
                if( range.location == NSNotFound ){
                    _text = [_text stringByAppendingString:@"."];
                    [_delegate numpadViewDidUpdate:self];
                }
            }
            
            *stop = YES;
        }
    }];
    
    [_buttonViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx,BOOL *stop) {
        UIView *view = obj;
        [self applyAnimationWithView:view press:NO];
    }];

    
    [CATransaction commit];
}

@end
