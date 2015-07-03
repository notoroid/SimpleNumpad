//
//  ViewController.m
//  SimpleNumpad
//
//  Created by 能登 要 on 2015/07/02.
//  Copyright (c) 2015年 Irimasu Densan Planning. All rights reserved.
//

#import "ViewController.h"
#import "IDPNumpadViewController.h"

@interface ViewController () <IDPNumpadViewControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak,nonatomic) IBOutlet UIPickerView *stylePickerView;
@property (strong,nonatomic) NSArray *styles;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (assign,nonatomic) CGFloat value;
@property (weak, nonatomic) IBOutlet UISwitch *showNumpadSwitch;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.styles = @[
                     @{@"title":@"Standard",@"style":@(IDPNumpadViewControllerStyleStandard)}
                    ,@{@"title":@"Retro",@"style":@(IDPNumpadViewControllerStyleRetro)}
                    ,@{@"title":@"CalcApp",@"style":@(IDPNumpadViewControllerStyleCalcApp)}
                    ,@{@"title":@"Magenta",@"style":@(IDPNumpadViewControllerStylePeach)}
                    ,@{@"title":@"Green",@"style":@(IDPNumpadViewControllerStyleGreen)}
                    ,@{@"title":@"Purple",@"style":@(IDPNumpadViewControllerStylePurple)}
                    ,@{@"title":@"Dark",@"style":@(IDPNumpadViewControllerStyleDefault)}
                    ];
    [self.stylePickerView reloadAllComponents];
    
    self.valueLabel.text = [@(self.value) description];
    self.showNumpadSwitch.on = YES;
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.styles.count;
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.styles[row][@"title"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onShowNumpad:(id)sender
{
    NSInteger selectedRow = [self.stylePickerView selectedRowInComponent:0];
    IDPNumpadViewControllerStyle style = [self.styles[selectedRow][@"style"] integerValue];
    
    IDPNumpadViewController *viewController = [IDPNumpadViewController numpadViewControllerWithStyle:style showNumberDisplay:self.showNumpadSwitch.on];
    viewController.value = self.value;
    viewController.delegate = self;
    
    [self presentViewController:viewController animated:YES completion:^{
        
        
    }];
}

- (void) numpadViewControllerDidUpdate:(IDPNumpadViewController *)numpadViewController
{
    if( self.showNumpadSwitch.on ){
        self.value = numpadViewController.value;
        self.valueLabel.text = [@(self.value) description];
    }else{
        self.valueLabel.text = numpadViewController.displayText;
    }
    
}

- (void) numpadViewControllerDidEnter:(IDPNumpadViewController *)numpadViewController
{
    self.value = numpadViewController.value;
    self.valueLabel.text = [@(self.value) description];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    
    }];
}

- (void) numpadViewControllerDidCancel:(IDPNumpadViewController *)numpadViewController
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
}

@end
