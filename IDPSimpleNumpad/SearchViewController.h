//
//  SearchViewController.h
//  IDPSimpleNumpad
//
//  Created by 能登 要 on 2015/07/30.
//  Copyright (c) 2015年 Irimasu Densan Planning. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchViewControllerDelegate;

@interface SearchViewController : UITableViewController

- (void) findWithString:(NSString *)string;
@property (weak,nonatomic) id<SearchViewControllerDelegate> delegate;
@property (assign,nonatomic) CGFloat topLayoutGuideLength;
@property (strong,nonatomic) NSDictionary *selectedObject;

@end


@protocol SearchViewControllerDelegate <NSObject>

- (void) searchViewControllerDidSelected:(SearchViewController *)searchViewController;

@end
