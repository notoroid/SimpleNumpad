//
//  IDPNumpadView.h
//  SimpleNumpad
//
//  Created by 能登 要 on 2015/07/02.
//  Copyright (c) 2015年 Irimasu Densan Planning. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IDPNumpadViewDelegate;

@interface IDPNumpadView : UIView

@property (strong,nonatomic) NSString *text;
@property (readonly,nonatomic) NSString *displayText;
@property (readonly,nonatomic) CGFloat value;
@property (weak,nonatomic) IBOutlet id<IDPNumpadViewDelegate>delegate;

@end

@protocol IDPNumpadViewDelegate <NSObject>

- (void) numpadViewDidUpdate:(IDPNumpadView *)numpadView;
- (void) numpadViewDidEnter:(IDPNumpadView *)numpadView;

@end