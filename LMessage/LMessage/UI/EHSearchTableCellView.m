//
//  EHSearchTableCellView.m
//  LMessage
//
//  Created by GaoAng on 16/6/16.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import "EHSearchTableCellView.h"
@interface EHSearchTableCellView()
@property (nonatomic, strong) MAMapView *mMapView;
@property (nonatomic, strong) UILabel *mNameLabel;
@property (nonatomic, strong) UILabel *mDetailLabel;
@property (nonatomic, assign) CGFloat HeightTop;
@property (nonatomic, assign) CGFloat HeightMap;
@property (nonatomic, strong) UIButton *mAddButtton;
@end
@implementation EHSearchTableCellView
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.HeightTop = MarginH(60);
        self.HeightMap = MarginH(60);
        [self.contentView addSubview:self.mNameLabel];
        [self.contentView addSubview:self.mAddButtton];
        [self.contentView addSubview:self.mDetailLabel];
//        [self.contentView addSubview:self.mMapView];
    }
    return self;
}

-(UILabel*)mNameLabel{
    if (!_mNameLabel) {
        _mNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W/2, MarginH(25))];
        _mNameLabel.font = Font15;
        [_mNameLabel setTextColor:Color_black_50];
        _mNameLabel.center = CGPointMake(MarginH(20) + CGRectGetWidth(_mNameLabel.frame)/2, self.HeightTop/2 - CGRectGetHeight(_mNameLabel.frame)/2);
    }
    return _mNameLabel;
}

-(UILabel*)mDetailLabel{
    if (!_mDetailLabel) {
        _mDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W/2, MarginH(20))];
        _mDetailLabel.font = Font13;
        [_mDetailLabel setTextColor:Color_black_30];
        _mDetailLabel.center = CGPointMake(MarginH(20) + CGRectGetWidth(_mDetailLabel.frame)/2, self.HeightTop/2 + CGRectGetHeight(_mDetailLabel.frame)/2);
    }
    return _mDetailLabel;
}

- (UIButton*)mAddButtton{
    if (!_mAddButtton) {
        _mAddButtton = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [_mAddButtton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _mAddButtton.center = CGPointMake(SCREEN_W - MarginH(20) - CGRectGetWidth(_mAddButtton.frame), self.HeightTop/2);
    }
    
    return _mAddButtton;
}
-(MAMapView*)mMapView{
    if (!_mMapView) {
        _mMapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, self.HeightTop, SCREEN_W, self.HeightMap)];
    }
    return _mMapView;
}

-(void)addButtonAction:(UIButton*)sender{
    if (self.didSelectAddPOI) {
        self.didSelectAddPOI(self.mapPOI);
    }
}

-(void)loardMapPOI:(AMapPOI *)mapPOI showType:(NSInteger)type{
    self.mapPOI = mapPOI;
    [self.mMapView setCenterCoordinate:CLLocationCoordinate2DMake(mapPOI.location.latitude, mapPOI.location.longitude) animated:YES];
    
    self.mMapView.hidden = !type;
    [self.mNameLabel setText:mapPOI.name];
    [self.mDetailLabel setText:mapPOI.address];
}

@end
