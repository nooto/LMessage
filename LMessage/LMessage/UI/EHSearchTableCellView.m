//
//  EHSearchTableCellView.m
//  LMessage
//
//  Created by GaoAng on 16/6/16.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import "EHSearchTableCellView.h"
#import "EHLocationDataManager.h"

@interface EHSearchTableCellView ()
@property (nonatomic, strong) UIView *mLineView;
@end
@implementation EHSearchTableCellView
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		[self setupview];
    }
    return self;
}


-(void)setupview{
	[self.contentView addSubview:self.mNameLabel];
	[self.contentView addSubview:self.mAddButtton];
	[self.contentView addSubview:self.mDetailLabel];
	[self.contentView addSubview:self.mLineView];
}

-(UILabel*)mNameLabel{
    if (!_mNameLabel) {
        _mNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W/2, MarginH(25))];
        _mNameLabel.font = Font15;
        [_mNameLabel setTextColor:Color_black_50];
        _mNameLabel.center = CGPointMake(MarginH(20) + CGRectGetWidth(_mNameLabel.frame)/2, CellTopHeight/2 - CGRectGetHeight(_mNameLabel.frame)/2);
    }
    return _mNameLabel;
}

-(UILabel*)mDetailLabel{
    if (!_mDetailLabel) {
        _mDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W/2, MarginH(20))];
        _mDetailLabel.font = Font13;
        [_mDetailLabel setTextColor:Color_black_30];
        _mDetailLabel.center = CGPointMake(MarginH(20) + CGRectGetWidth(_mDetailLabel.frame)/2, CellTopHeight/2 + CGRectGetHeight(_mDetailLabel.frame)/2);
    }
    return _mDetailLabel;
}

- (UIButton*)mAddButtton{
    if (!_mAddButtton) {
        _mAddButtton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W - 55, 0, MarginH(35), MarginH(35))];
        [_mAddButtton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_mAddButtton setImage:[UIImage imageNamed:@"ic_add_selected"] forState:UIControlStateDisabled];
        [_mAddButtton setImage:[UIImage imageNamed:@"ic_add"] forState:UIControlStateNormal];
        [_mAddButtton setImage:[UIImage imageNamed:@"ic_add"] forState:UIControlStateHighlighted];
        _mAddButtton.center = CGPointMake(SCREEN_W - CGRectGetWidth(_mAddButtton.frame), CellTopHeight/2);
    }
    
    return _mAddButtton;
}
-(UIView*)mLineView{
	if (!_mLineView) {
		_mLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 0.5f)];
		_mLineView.backgroundColor = Color_Line;
	}
	return _mLineView;
}

-(void)layoutSubviews{
	[super layoutSubviews];
	[self.mLineView setFrame:CGRectMake(0, CGRectGetHeight(self.bounds) -0.5f, SCREEN_W, 0.5f)];
}

-(void)addButtonAction:(UIButton*)sender{
    if (self.didSelectAddPOI) {
        self.didSelectAddPOI(self.mapPOI);
    }
}

-(void)setMapPOI:(AMapPOI *)mapPOI{
    _mapPOI = mapPOI;
    [self.mNameLabel setText:mapPOI.name];
    [self.mDetailLabel setText:mapPOI.address];

        //
    if ([LocationDataManager containMLocationData:mapPOI]) {
        self.mAddButtton.enabled = NO;
        self.isContained = YES;
    }
    else{
        self.mAddButtton.enabled = YES;
        self.isContained = NO;
    }
}

@end
