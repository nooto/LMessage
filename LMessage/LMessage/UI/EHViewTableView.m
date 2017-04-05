//
//  EHViewTableView.m
//  LMessage
//
//  Created by GaoAng on 16/5/31.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import "EHViewTableView.h"
#import "EHViewTableViewCell.h"
#import "EHPromptView.h"
#import "EHScSetDefendView.h"
#import "EHCustomAlertView.h"

#define CellIdentifier @"EHViewTableViewCell"
@interface EHViewTableView() <UITableViewDelegate, UITableViewDataSource, MGSwipeTableCellDelegate>
@property (nonatomic, strong) NSMutableArray *mDataSoure;
@property (nonatomic, assign) CLLocationCoordinate2D mLocationCoordinate;


@property (nonatomic, strong) EHPromptView *mPromptView;
@end

@implementation EHViewTableView
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame style:UITableViewStylePlain]) {

		self.separatorStyle = UITableViewCellSelectionStyleNone;
//		self.tableHeaderView = [UIView alloc];
        self.delegate = self;
        self.dataSource = self;
        [self addSubview:self.mPromptView];
    }
    return self;
}

- (EHPromptView*)mPromptView{
    if (!_mPromptView) {
        _mPromptView = [[EHPromptView alloc] initWithPromptString:NSLocalizedString(@"您还没添加任何地点...", @"您还没添加任何地点...") image:@"ic_empty" complete:^{
        }];
    }
    return _mPromptView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.mPromptView show:!self.mDataSoure.count];
}


- (void)updateViewWithCLLocationCoordinate:(CLLocationCoordinate2D)locationCoord{
    self.mLocationCoordinate = locationCoord;
    self.mDataSoure = nil;
    [self reloadData];
}
#pragma mark - 列表类。。。
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return 0.01f;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mDataSoure.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return MarginH(60);
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EHViewTableViewCell *cell = (EHViewTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[EHViewTableViewCell description]];
    if (!cell) {
        cell = [[EHViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[EHViewTableViewCell description] height:[self tableView:tableView heightForRowAtIndexPath:indexPath]];


        WS(weakSelf);
        [cell setDidLongPress:^(EHLocationData *locationData) {
                NSArray * arr  = [NSArray arrayWithObjects:@"删除地点",@"取消", nil];
                EHScSetDefendView *view = [[EHScSetDefendView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) arr:arr];
                if(arr.count > 0)[view setCellWithImage:[UIImage imageNamed:@"global_ic_close"] index:arr.count -1];
                view.didSelectIndexWithText = ^(NSInteger index, NSString *indexText){
                    if([indexText isEqualToString:@"删除地点"] ){
                        EHCustomAlertView *alertView = [[EHCustomAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"要删除该地点吗？", nil) leftButton:@"不删除" rightButton:@"删除" selectActin:^(NSInteger index, NSString *buttonText) {
                            if ([buttonText isEqualToString:@"删除"]) {
                                if ([weakSelf.mDataSoure containsObject:locationData]) {
                                    [LocationDataManager removeMLocationData:locationData];
                                    NSInteger  index = [weakSelf.mDataSoure indexOfObject:locationData];
                                    [weakSelf.mDataSoure removeObject:locationData];
                                    [weakSelf beginUpdates];
                                    [weakSelf deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
                                    [weakSelf endUpdates];
                                }
                            }

                        }];

                        alertView.rightButtonTitleColor = Color_Main;
                        [alertView show];
                    }
                };
                [view showModifyNamePageView];
        }];
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

//    屏蔽侧滑 防止不断定位页面刷新不停
//    swipeSettings.transition = MGSwipeTransitionBorder;
//    if (direction == MGSwipeDirectionRightToLeft){
//        MGSwipeButton * button1 = [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor redColor] callback:^BOOL(MGSwipeTableCell * sender){
//            DDLogInfo(@"Convenience callback received (right).");
//            return YES;
//        }];
//        [button1.titleLabel setFont:Font16];
//        [button1 setTitleColor:Color_white_100 forState:UIControlStateNormal];
//        [button1 setTitleColor:Color_white_50 forState:UIControlStateDisabled];
//        button1.backgroundColor = [UIColor grayColor];
//        return @[button1];
//    }

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
