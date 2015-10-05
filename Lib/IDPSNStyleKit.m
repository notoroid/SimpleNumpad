//
//  IDPSNStyleKit.m
//  SimpleNumpad
//
//  Created by 能登 要 on 2015/10/05.
//  Copyright (c) 2015 Irimasu Densan Planning. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//

#import "IDPSNStyleKit.h"


@implementation IDPSNStyleKit

#pragma mark Cache

static UIImage* _imageOfBackspace = nil;
static UIImage* _imageOfBackspaceWhite = nil;
static UIImage* _imageOfBackspaceCream = nil;
static UIImage* _imageOfBackspaceBlack = nil;

#pragma mark Initialization

+ (void)initialize
{
}

#pragma mark Drawing Methods

+ (void)drawBackspace
{
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 1 green: 0 blue: 0 alpha: 1];

    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(10.5, 2)];
    [bezierPath addLineToPoint: CGPointMake(27, 2)];
    [bezierPath addLineToPoint: CGPointMake(27, 19)];
    [bezierPath addLineToPoint: CGPointMake(10.5, 19)];
    [bezierPath addLineToPoint: CGPointMake(2, 10.5)];
    [bezierPath addLineToPoint: CGPointMake(10.5, 2)];
    [bezierPath closePath];
    [color setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];


    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(13, 6)];
    [bezier2Path addLineToPoint: CGPointMake(22, 15)];
    bezier2Path.lineCapStyle = kCGLineCapSquare;

    [color setStroke];
    bezier2Path.lineWidth = 1;
    [bezier2Path stroke];


    //// Bezier 3 Drawing
    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint: CGPointMake(22, 6)];
    [bezier3Path addLineToPoint: CGPointMake(13, 15)];
    bezier3Path.lineCapStyle = kCGLineCapSquare;

    [color setStroke];
    bezier3Path.lineWidth = 1;
    [bezier3Path stroke];
}

+ (void)drawBackspaceWhite
{
    //// Color Declarations
    UIColor* color2 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];

    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(10.5, 2)];
    [bezierPath addLineToPoint: CGPointMake(27, 2)];
    [bezierPath addLineToPoint: CGPointMake(27, 19)];
    [bezierPath addLineToPoint: CGPointMake(10.5, 19)];
    [bezierPath addLineToPoint: CGPointMake(2, 10.5)];
    [bezierPath addLineToPoint: CGPointMake(10.5, 2)];
    [bezierPath closePath];
    [color2 setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];


    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(13, 6)];
    [bezier2Path addLineToPoint: CGPointMake(22, 15)];
    bezier2Path.lineCapStyle = kCGLineCapSquare;

    [color2 setStroke];
    bezier2Path.lineWidth = 1;
    [bezier2Path stroke];


    //// Bezier 3 Drawing
    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint: CGPointMake(22, 6)];
    [bezier3Path addLineToPoint: CGPointMake(13, 15)];
    bezier3Path.lineCapStyle = kCGLineCapSquare;

    [color2 setStroke];
    bezier3Path.lineWidth = 1;
    [bezier3Path stroke];
}

+ (void)drawBackspaceCream
{
    //// Color Declarations
    UIColor* color3 = [UIColor colorWithRed: 0.996 green: 0.98 blue: 0.851 alpha: 1];

    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(10.5, 2)];
    [bezierPath addLineToPoint: CGPointMake(27, 2)];
    [bezierPath addLineToPoint: CGPointMake(27, 19)];
    [bezierPath addLineToPoint: CGPointMake(10.5, 19)];
    [bezierPath addLineToPoint: CGPointMake(2, 10.5)];
    [bezierPath addLineToPoint: CGPointMake(10.5, 2)];
    [bezierPath closePath];
    [color3 setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];


    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(13, 6)];
    [bezier2Path addLineToPoint: CGPointMake(22, 15)];
    bezier2Path.lineCapStyle = kCGLineCapSquare;

    [color3 setStroke];
    bezier2Path.lineWidth = 1;
    [bezier2Path stroke];


    //// Bezier 3 Drawing
    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint: CGPointMake(22, 6)];
    [bezier3Path addLineToPoint: CGPointMake(13, 15)];
    bezier3Path.lineCapStyle = kCGLineCapSquare;

    [color3 setStroke];
    bezier3Path.lineWidth = 1;
    [bezier3Path stroke];
}

+ (void)drawBackspaceBlack
{

    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(10.5, 2)];
    [bezierPath addLineToPoint: CGPointMake(27, 2)];
    [bezierPath addLineToPoint: CGPointMake(27, 19)];
    [bezierPath addLineToPoint: CGPointMake(10.5, 19)];
    [bezierPath addLineToPoint: CGPointMake(2, 10.5)];
    [bezierPath addLineToPoint: CGPointMake(10.5, 2)];
    [bezierPath closePath];
    [UIColor.blackColor setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];


    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(13, 6)];
    [bezier2Path addLineToPoint: CGPointMake(22, 15)];
    bezier2Path.lineCapStyle = kCGLineCapSquare;

    [UIColor.blackColor setStroke];
    bezier2Path.lineWidth = 1;
    [bezier2Path stroke];


    //// Bezier 3 Drawing
    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint: CGPointMake(22, 6)];
    [bezier3Path addLineToPoint: CGPointMake(13, 15)];
    bezier3Path.lineCapStyle = kCGLineCapSquare;

    [UIColor.blackColor setStroke];
    bezier3Path.lineWidth = 1;
    [bezier3Path stroke];
}

#pragma mark Generated Images

+ (UIImage*)imageOfBackspace
{
    if (_imageOfBackspace)
        return _imageOfBackspace;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(29, 21), NO, 0.0f);
    [IDPSNStyleKit drawBackspace];

    _imageOfBackspace = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return _imageOfBackspace;
}

+ (UIImage*)imageOfBackspaceWhite
{
    if (_imageOfBackspaceWhite)
        return _imageOfBackspaceWhite;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(29, 21), NO, 0.0f);
    [IDPSNStyleKit drawBackspaceWhite];

    _imageOfBackspaceWhite = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return _imageOfBackspaceWhite;
}

+ (UIImage*)imageOfBackspaceCream
{
    if (_imageOfBackspaceCream)
        return _imageOfBackspaceCream;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(29, 21), NO, 0.0f);
    [IDPSNStyleKit drawBackspaceCream];

    _imageOfBackspaceCream = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return _imageOfBackspaceCream;
}

+ (UIImage*)imageOfBackspaceBlack
{
    if (_imageOfBackspaceBlack)
        return _imageOfBackspaceBlack;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(29, 21), NO, 0.0f);
    [IDPSNStyleKit drawBackspaceBlack];

    _imageOfBackspaceBlack = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return _imageOfBackspaceBlack;
}

#pragma mark Customization Infrastructure

- (void)setBackspaceTargets: (NSArray*)backspaceTargets
{
    _backspaceTargets = backspaceTargets;

    for (id target in self.backspaceTargets)
        [target performSelector: @selector(setImage:) withObject: IDPSNStyleKit.imageOfBackspace];
}

- (void)setBackspaceWhiteTargets: (NSArray*)backspaceWhiteTargets
{
    _backspaceWhiteTargets = backspaceWhiteTargets;

    for (id target in self.backspaceWhiteTargets)
        [target performSelector: @selector(setImage:) withObject: IDPSNStyleKit.imageOfBackspaceWhite];
}

- (void)setBackspaceCreamTargets: (NSArray*)backspaceCreamTargets
{
    _backspaceCreamTargets = backspaceCreamTargets;

    for (id target in self.backspaceCreamTargets)
        [target performSelector: @selector(setImage:) withObject: IDPSNStyleKit.imageOfBackspaceCream];
}

- (void)setBackspaceBlackTargets: (NSArray*)backspaceBlackTargets
{
    _backspaceBlackTargets = backspaceBlackTargets;

    for (id target in self.backspaceBlackTargets)
        [target performSelector: @selector(setImage:) withObject: IDPSNStyleKit.imageOfBackspaceBlack];
}


@end
