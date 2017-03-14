/*### WS@H Project:EHouse ###*/
//
//  EHScSetDefendView.m
//  EHouse
//
//  Created by admin on 15/8/4.
//  Copyright (c) 2015年 wondershare. All rights reserved.
//

#import "EHScSetDefendView.h"

@interface EHScSetDefendView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *mArrData;
@property (nonatomic, strong) UITableView *mTableView;
//@property (nonatomic, strong) UIDynamicAnimator *dyanmi;
@end

@implementation EHScSetDefendView

-(id)initWithFrame:(CGRect)frame arr:(NSArray*)arrData
{
    if (self = [super initWithFrame:frame]) {
        _mArrData = [NSMutableArray arrayWithArray:arrData];
        [self addSubview:self.backView];
        [self addSubview:self.mTableView];
        
//        _dyanmi = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    }
    return self;
}

-(UIView*)backView
{
    if (!_backView) {
//        if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0f) {
//            UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//            _backView = [[UIVisualEffectView alloc] initWithEffect:blur];
//            [_backView setFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
//            [_backView setAlpha:0];
//        }else{
            _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_H, SCREEN_H)];
            [_backView setBackgroundColor:Color_black_50];
            [_backView setAlpha:0];
//        }
        UITapGestureRecognizer *tapGestur = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backViewAction:)];
        [_backView addGestureRecognizer:tapGestur];

    }
    return _backView;
}

-(void)backViewAction:(UITapGestureRecognizer*)sender
{
    if (_didSelectIndex) {
        _didSelectIndex(-1);
    }
    
    if (_didSelectIndexWithText) {
        _didSelectIndexWithText(-1, nil);
    }
    [self removeMySelf];
}

-(UITableView*)mTableView
{
    if (!_mTableView) {
        CGFloat cellHeigh = MarginH(65);
        
        _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_H, SCREEN_W, (cellHeigh*_mArrData.count)) style:UITableViewStylePlain];
        _mTableView.delegate = self;
        _mTableView.dataSource = self;
        _mTableView.scrollEnabled = NO;
        _mTableView.rowHeight = cellHeigh;
        _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [_mTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIndentifier"];
    }
    return _mTableView;
}

-(void)showModifyNamePageView
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    _mTableView.frame = CGRectMake(0, SCREEN_H, SCREEN_W, self.frame.size.height);
    
    __weak typeof(EHScSetDefendView*) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        [_backView setAlpha:0.5f];
        weakSelf.mTableView.frame = CGRectMake(0, SCREEN_H-(self.mTableView.rowHeight * _mArrData.count), SCREEN_W, self.frame.size.height);
//    }completion:^(BOOL finish){
//        CAKeyframeAnimation *anime = [CAKeyframeAnimation animation];
//        anime.keyPath = @"position.y";
//        anime.values = @[@0, @8, @-3, @1, @0];
//        anime.keyTimes = @[@0, @(1/6.0), @(3/6.0), @(5/6.0f), @1];
//        anime.duration = 0.3f;
//        anime.additive = YES;
//        [weakSelf.mTableView.layer addAnimation:anime forKey:@"shake"];
    }];
}

-(void)removeMySelf
{
    [self.mTableView.layer removeAllAnimations];
    
    __weak typeof(EHScSetDefendView*) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        _backView.alpha = 0;
        weakSelf.mTableView.frame = CGRectMake(0, SCREEN_H, SCREEN_W, self.frame.size.height);
    } completion:^(BOOL finish){
        [weakSelf removeFromSuperview];
//        [self removeFromSuperview];
    }];
}

#pragma mark -tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mArrData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"cellIndentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        
        UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, tableView.rowHeight)];
        selectView.backgroundColor = Color_black_5;
        cell.selectedBackgroundView = selectView;
    }
    if (indexPath.row != (self.mArrData.count-1)) {
        CALayer *line = [CALayer layer];
        line.frame = CGRectMake(MarginW(20), tableView.rowHeight-0.5, SCREEN_W-MarginW(40), 0.5f);
        line.backgroundColor = Color_Line.CGColor;
        [cell.layer addSublayer:line];
    }
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    id obj = [self.mArrData objectAtIndex:indexPath.row];
    
    if ([obj isKindOfClass:[UIImage class]]) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:obj];
        imageView.center = CGPointMake(SCREEN_W/2, tableView.rowHeight/2);
        [cell.contentView addSubview:imageView];
    }
    else if([obj isKindOfClass:[NSString class]]){
     
        [cell.imageView setImage:nil];
        
        if (indexPath.row == _mArrData.count - 1 && _lastColor) {
            [cell.textLabel setTextColor:_lastColor];
        }
        else{
            [cell.textLabel setTextColor:Color_5a5a5a];
        }
        
        [cell.textLabel setText:obj];
    }
    cell.textLabel.font = Font15;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_didSelectIndex) {
        _didSelectIndex(indexPath.row);
    }
    if (_didSelectIndexWithText) {
        id obj = [self.mArrData objectAtIndex:indexPath.row];
        if ([obj isKindOfClass:[NSString class]]) {
            _didSelectIndexWithText(indexPath.row, obj);
        }
    }
    [self removeMySelf];
}

-(void)setCellWithImage:(UIImage *)image index:(NSInteger)index
{
    if (index >= _mArrData.count) {
        return;
    }
    [self.mArrData insertObject:image atIndex:index];
    [self.mArrData removeObjectAtIndex:index+1];
    
    [self.mTableView reloadData];
}

@end
