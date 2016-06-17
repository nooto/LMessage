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
@interface EHViewTableView() <UITableViewDelegate, UITableViewDataSource, MGSwipeTableCellDelegate>
@property (nonatomic, strong) NSMutableArray *mDataSoure;
@property (nonatomic, assign) CLLocationCoordinate2D mLocationCoordinate;
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
- (void)updateViewWithCLLocationCoordinate:(CLLocationCoordinate2D)locationCoord{
    self.mLocationCoordinate = locationCoord;
    self.mDataSoure = nil;
    [self reloadData];
}
#pragma mark - 列表类。。。
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mDataSoure.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return MarginH(50);
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EHViewTableViewCell *cell = (EHViewTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[EHViewTableViewCell description]];
    if (!cell) {
        cell = [[EHViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[EHViewTableViewCell description] height:[self tableView:tableView heightForRowAtIndexPath:indexPath]];
    }
    cell.delegate = self;
    cell.rightSwipeSettings.transition = MGSwipeTransitionBorder;
    cell.swipeBackgroundColor = [UIColor clearColor];
    
    [cell loardTableCellWithLocationData:self.mDataSoure[indexPath.row] curPostion:self.mLocationCoordinate];
    return cell;
}

-(NSArray*)swipeTableCell:(MGSwipeTableCell*) cell swipeButtonsForDirection:(MGSwipeDirection)direction
            swipeSettings:(MGSwipeSettings*) swipeSettings expansionSettings:(MGSwipeExpansionSettings*) expansionSettings;
{
    swipeSettings.transition = MGSwipeTransitionBorder;
    if (direction == MGSwipeDirectionRightToLeft){
        MGSwipeButton * button = [MGSwipeButton buttonWithTitle:@"编辑" backgroundColor:[UIColor redColor] callback:^BOOL(MGSwipeTableCell * sender){
            DDLogInfo(@"Convenience callback received (right).");
            return YES;
        }];
        [button.titleLabel setFont:Font16];
        [button setTitleColor:Color_white_100 forState:UIControlStateNormal];
        [button setTitleColor:Color_white_50 forState:UIControlStateDisabled];
        
        MGSwipeButton * button1 = [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor redColor] callback:^BOOL(MGSwipeTableCell * sender){
            DDLogInfo(@"Convenience callback received (right).");
            return YES;
        }];
        [button1.titleLabel setFont:Font16];
        [button1 setTitleColor:Color_white_100 forState:UIControlStateNormal];
        [button1 setTitleColor:Color_white_50 forState:UIControlStateDisabled];
        button1.backgroundColor = [UIColor grayColor];
        return @[button, button1];
    }
    
    return nil;
}

-(BOOL)swipeTableRemoveInputOverlayCell:(MGSwipeTableCell *)cell{
    NSIndexPath * path = [self indexPathForCell:cell];
    if (path) {
        [self reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
    }
    return YES;
}

-(BOOL)swipeTableCell:(MGSwipeTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion
{
    if (direction == MGSwipeDirectionRightToLeft) {
        //删除
        if (index == 0) {
            NSIndexPath *index = [self indexPathForCell:cell];
            if (index) {
                [LocationDataManager removeMLocationData:[self.mDataSoure objectAtIndex:index.row]];
                [self.mDataSoure removeObjectAtIndex:index.row];
                [self beginUpdates];
                [self deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationTop];
                [self endUpdates];
            }
        }
        //编辑。。
        else if (index == 1){
            
        }
    }
    return YES;
}

-(NSMutableArray*)mDataSoure{
    if (!_mDataSoure) {
        _mDataSoure = [[NSMutableArray alloc] initWithArray:LocationDataManager.mLocationDatas];
    }
    return _mDataSoure;
}

@end
