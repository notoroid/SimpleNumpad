//
//  IDPNumpadView.h
//  SimpleNumpad
//
//  Created by 能登 要 on 2015/07/02.
//  Copyright (c) 2015年 Irimasu Densan Planning. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, IDPNumpadViewInputStyle)
{
     IDPNumpadViewInputStyleNumber
    ,IDPNumpadViewInputStyleSerialNumber
};

@protocol IDPNumpadViewDelegate;

@interface IDPNumpadView : UIView

@property (strong,nonatomic) NSString *text;
@property (readonly,nonatomic) NSString *displayText;
@property (readonly,nonatomic) CGFloat value;
@property (readonly,nonatomic) NSString *serialnNumber;
@property (weak,nonatomic) IBOutlet id<IDPNumpadViewDelegate>delegate;
@property (assign,nonatomic) IDPNumpadViewInputStyle inputStyle;
@property (strong,nonatomic) NSArray *separatorIntervals;

- (void) hiddenNumberSupportButton:(BOOL)hidden;

@end

@protocol IDPNumpadViewDelegate <NSObject>

- (void) numpadViewDidUpdate:(IDPNumpadView *)numpadView;
- (void) numpadViewDidEnter:(IDPNumpadView *)numpadView;

@end