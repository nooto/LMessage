//
//  EHSearchViewController.m
//  LMessage
//
//  Created by GaoAng on 16/5/27.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import "EHSearchViewController.h"
@interface EHSearchViewController() <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UISearchController *mSearchController;
@property (nonatomic, strong) UITableView*mTableView;
@property (nonatomic, strong) NSMutableArray *mSourceDatas;
@end
@implementation EHSearchViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.mTableView];
    self.mTableView.tableHeaderView = self.mSearchController.searchBar;
}


#pragma mark - 
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [self.mSearchController.searchBar text];
    [self.mSourceDatas addObject:searchString];
    [self.mTableView reloadData];
}


#pragma mark - UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mSourceDatas.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"showDropDownListViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (indexPath.row < self.mSourceDatas.count) {
        [cell.textLabel setText:self.mSourceDatas[indexPath.row]];
        [cell.textLabel setTextColor:[UIColor redColor]];
    }
    return cell;
}

-(UITableView*)mTableView{
    if (!_mTableView) {
        _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVBAR_H, SCREEN_W, SCREEN_H - NAVBAR_H) style:UITableViewStyleGrouped];
        _mTableView.delegate = self;
        _mTableView.dataSource = self;
        _mTableView.rowHeight = MarginH(45);
    }
    return _mTableView;
}

- (NSMutableArray*)mSourceDatas{
    if (!_mSourceDatas) {
        _mSourceDatas = [[NSMutableArray alloc] init];
    }
    return _mSourceDatas;
}
-(UISearchController*)mSearchController{
    if (!_mSearchController) {
        _mSearchController = [[UISearchController alloc] init];
        _mSearchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _mSearchController.searchResultsUpdater = self;
        _mSearchController.dimsBackgroundDuringPresentation = NO;
        _mSearchController.hidesNavigationBarDuringPresentation = NO;
        _mSearchController.searchBar.frame = CGRectMake(_mSearchController.searchBar.frame.origin.x, _mSearchController.searchBar.frame.origin.y, _mSearchController.searchBar.frame.size.width, 44.0);
//        self.mTableView.tableHeaderView = _mSearchController.searchBar;
    }
    return _mSearchController;
}
@end
