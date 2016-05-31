//
//  EHViewTableView.m
//  LMessage
//
//  Created by GaoAng on 16/5/31.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import "EHViewTableView.h"
#import "EHViewTableViewCell.h"
#define CellIdentifier @"EHViewTableViewCell"
@interface EHViewTableView() <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *mDataSoure;
//@property (nonatomic, strong) UIView
@end

@implementation EHViewTableView
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
#pragma mark - 列表类。。。
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
    return self.mDataSoure.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return MarginH(50);
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EHViewTableViewCell *cell = (EHViewTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[EHViewTableViewCell description]];
    if (!cell) {
        cell = [[EHViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[EHViewTableViewCell description] cellHeight:[self tableView:tableView heightForRowAtIndexPath:indexPath]];
    }
    [cell setMLocationData:nil];
    return cell;
}

-(NSMutableArray*)mDataSoure{
    if (!_mDataSoure) {
        _mDataSoure = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _mDataSoure;
}

@end
