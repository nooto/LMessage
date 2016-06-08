//
//  EHSearchViewController.m
//  LMessage
//
//  Created by GaoAng on 16/5/27.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import "EHSearchViewController.h"
@interface EHSearchViewController() <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView*mTableView;
@end
@implementation EHSearchViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.mTableView];
}

#pragma mark - UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

-(UITableView*)mTableView{
    if (!_mTableView) {
        _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVBAR_H, SCREEN_W, SCREEN_H - NAVBAR_H) style:UITableViewStyleGrouped];
        _mTableView.delegate = self;
        _mTableView.dataSource = self;
        _mTableView.rowHeight = MarginH(55);
    }
    return _mTableView;
}
@end
