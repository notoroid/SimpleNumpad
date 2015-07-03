//
//  IDPNumpadViewController.h
//  IDPSimpleNumpad
//
//  Created by 能登 要 on 2015/07/02.
//  Copyright (c) 2015年 Irimasu Densan Planning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDPNumpadView.h"
#import "IDPNumberDisplay.h"

typedef NS_ENUM(NSInteger, IDPNumpadViewControllerStyle)
{
     IDPNumpadViewControllerStyleDefault
    ,IDPNumpadViewControllerStyleStandard
    ,IDPNumpadViewControllerStylePro
    ,IDPNumpadViewControllerStyleRetro
    ,IDPNumpadViewControllerStyleMelancholy
    ,IDPNumpadViewControllerStyleMemories
    ,IDPNumpadViewControllerStyleFusion
    ,IDPNumpadViewControllerStylePeach
    ,IDPNumpadViewControllerStyleGreen
    ,IDPNumpadViewControllerStylePurple
    ,IDPNumpadViewControllerStyleCalcApp
};

@protocol IDPNumpadViewControllerDelegate;

@interface IDPNumpadViewController : UIViewController<IDPNumpadViewDelegate>

+ (IDPNumpadViewController *)numpadViewControllerWithStyle:(IDPNumpadViewControllerStyle )style;
+ (IDPNumpadViewController *)numpadViewControllerWithStyle:(IDPNumpadViewControllerStyle )style showNumberDisplay:(BOOL)showNumberDisplay;

@property(readonly,nonatomic) IDPNumberDisplay *numberDisplay;
@property(readonly,nonatomic) IDPNumpadView *numpadView;

@property (assign,nonatomic) CGFloat value;
@property (readonly,nonatomic) NSString *displayText;
@property (weak,nonatomic) id<IDPNumpadViewControllerDelegate> delegate;
@property (assign,nonatomic) BOOL hideNumberDisplay;
@end

@protocol IDPNumpadViewControllerDelegate <NSObject>

@optional
- (void) numpadViewControllerDidUpdate:(IDPNumpadViewController *)numpadViewController;
- (void) numpadViewControllerDidEnter:(IDPNumpadViewController *)numpadViewController;
- (void) numpadViewControllerDidCancel:(IDPNumpadViewController *)numpadViewController;

@end