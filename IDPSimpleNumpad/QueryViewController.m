//
//  QueryViewController.m
//  IDPSimpleNumpad
//
//  Created by 能登 要 on 2015/07/30.
//  Copyright (c) 2015年 Irimasu Densan Planning. All rights reserved.
//

#import "QueryViewController.h"
#import "SimpleNumpad.h"
#import "SearchViewController.h"

@interface QueryViewController () <IDPNumpadViewControllerDelegate,SearchViewControllerDelegate>
{
    __weak SearchViewController *_searchViewController;
}
@end

@implementation QueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onQuery:(id)sender
{
    SearchViewController *searchViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"searchViewController"];
    
    IDPNumpadViewController *viewController = [IDPNumpadViewController numpadViewControllerWithStyle:IDPNumpadViewControllerStyleDefault searchViewController:searchViewController showNumberDisplay:YES];
    viewController.delegate = self;
    
    _searchViewController = searchViewController;
    _searchViewController.topLayoutGuideLength = self.topLayoutGuide.length;
    _searchViewController.delegate = self;

    
    [self presentViewController:viewController animated:YES completion:^{
        
    }];
}

- (void) numpadViewControllerDidUpdate:(IDPNumpadViewController *)numpadViewController
{
    [_searchViewController findWithString:numpadViewController.serialNumber];
}

- (void) numpadViewControllerDidEnter:(IDPNumpadViewController *)numpadViewController
{
    
}

- (void)searchViewControllerDidSelected:(SearchViewController *)searchViewController
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
