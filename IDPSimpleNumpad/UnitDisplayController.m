//
//  UnitDisplayController.m
//  IDPSimpleNumpad
//
//  Created by 能登 要 on 2015/08/11.
//  Copyright (c) 2015年 Irimasu Densan Planning. All rights reserved.
//

#import "UnitDisplayController.h"

@interface UnitDisplayController ()

@end

@implementation UnitDisplayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat) unitViewControllerWidth:(IDPNumpadViewController *)numpadViewController
{
    return 50;
}

- (UIEdgeInsets) unitViewController:(IDPNumpadViewController *)numpadViewController contentInsets:(UIEdgeInsets)contentInsets
{
    contentInsets.left = contentInsets.left * 0.5;
    
    return contentInsets;
}

@end
