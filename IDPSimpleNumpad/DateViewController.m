//
//  DateViewController.m
//  IDPSimpleNumpad
//
//  Created by 能登 要 on 2015/12/25.
//  Copyright © 2015年 Irimasu Densan Planning. All rights reserved.
//

#import "DateViewController.h"
#import "SimpleNumpad.h"

static NSDateFormatter *s_dateFormatter = nil;


@interface DateViewController () <IDPNumpadViewControllerDelegate>
{
    __weak IBOutlet UILabel *_labelDate;
    NSDate *_date;
}
@end

@implementation DateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _date = [NSDate date];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_dateFormatter = [[NSDateFormatter alloc] init];
        [s_dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    });
    _labelDate.text = [s_dateFormatter stringFromDate:_date];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onShowDate:(id)sender
{
    IDPNumpadViewController *viewController = [IDPNumpadViewController numpadViewControllerWithStyle:IDPNumpadViewControllerStyleDefault baseDate:[NSDate date]];
    viewController.delegate = self;
    
    [self presentViewController:viewController animated:YES completion:^{
        
        
    }];
}

- (void) numpadViewControllerDidUpdate:(IDPNumpadViewController *)numpadViewController
{
    if( numpadViewController.date != nil ){
        _date = numpadViewController.date;
        _labelDate.text = [s_dateFormatter stringFromDate:numpadViewController.date];
    }
    
    
}

- (void) numpadViewControllerDidEnter:(IDPNumpadViewController *)numpadViewController
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    
}

- (void) numpadViewControllerDidCancel:(IDPNumpadViewController *)numpadViewController
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    
}


@end
