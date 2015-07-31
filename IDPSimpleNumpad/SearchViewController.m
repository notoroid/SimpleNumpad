//
//  SearchViewController.m
//  IDPSimpleNumpad
//
//  Created by 能登 要 on 2015/07/30.
//  Copyright (c) 2015年 Irimasu Densan Planning. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
{
    NSArray *_data;
    NSArray *_results;
    CGFloat _topLayoutGuideLength;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    

//    self.toolbarItems = @[ [[UIBarButtonItem alloc] initWithTitle:@"Test" style:UIBarButtonItemStylePlain target:self action:@selector(onSelect:)]
//                          
//                          ];
    
    
    _data = @[
               @{@"serial":@"01",@"name":@"apple"}
              ,@{@"serial":@"11",@"name":@"berry"}
              ,@{@"serial":@"12",@"name":@"cherry"}
              ,@{@"serial":@"31",@"name":@"date"}
              ,@{@"serial":@"41",@"name":@"grape"}
              ,@{@"serial":@"42",@"name":@"orange"}
              ,@{@"serial":@"51",@"name":@"kiwi"}
              ,@{@"serial":@"61",@"name":@"banana"}
              ,@{@"serial":@"71",@"name":@"plum"}
              ,@{@"serial":@"72",@"name":@"peach"}
              ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) findWithString:(NSString *)string
{
    _results = [_data filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"serial contains[cd] %@",string]];
    
    [self.tableView reloadData];
}

- (void) applyTopLayoutGuideLength:(CGFloat)length
{
    UIEdgeInsets contentInset = self.tableView.contentInset;
    self.tableView.contentInset = UIEdgeInsetsMake(length, contentInset.left, contentInset.bottom, contentInset.right);
}

- (CGFloat) topLayoutGuideLength
{
    return _topLayoutGuideLength;
}

- (void) setTopLayoutGuideLength:(CGFloat)topLayoutGuideLength
{
    UIEdgeInsets contentInset = self.tableView.contentInset;
    self.tableView.contentInset = UIEdgeInsetsMake(topLayoutGuideLength, contentInset.left, contentInset.bottom, contentInset.right);
}


- (BOOL) prefersStatusBarHidden
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _results.count > 0 ? _results.count : _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResultCell" forIndexPath:indexPath];
    
    NSArray *array = nil;
    array = _results.count > 0 ? _results : _data;
    
    NSDictionary *dict = array[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",dict[@"serial"],dict[@"name"]];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = nil;
    array = _results.count > 0 ? _results : _data;

    _selectedObject = array[indexPath.row];
    
    [_delegate searchViewControllerDidSelected:self];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
