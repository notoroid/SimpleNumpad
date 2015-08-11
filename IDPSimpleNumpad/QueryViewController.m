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
#import "UnitDisplayController.h"

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
    UnitDisplayController *unitDisplayController = [self.storyboard instantiateViewControllerWithIdentifier:@"unitDisplayController"];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    navigationController.navigationBarHidden = YES;
    
    IDPNumpadViewController *viewController = [IDPNumpadViewController numpadViewControllerWithStyle:IDPNumpadViewControllerStyleDefault searchViewController:navigationController/*searchViewController*/ unitDisplayController:unitDisplayController showNumberDisplay:YES];
    viewController.delegate = self;
    
//    NSLog(@"self.topLayoutGuide.length=%@",@(self.topLayoutGuide.length));
    
    _searchViewController = searchViewController;
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
