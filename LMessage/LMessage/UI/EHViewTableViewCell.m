//
//  EHViewTableViewCell.m
//  LMessage
//
//  Created by GaoAng on 16/5/31.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import "EHViewTableViewCell.h"
#import "UILabel+AutoSize.h"
@interface EHViewTableViewCell()
@property (nonatomic, strong) UILabel *mNameLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, weak) EHLocationData *mLocationData;
@end

@implementation EHViewTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier height:(CGFloat)cellHeight{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier height:cellHeight]) {
        self.cellHeight = cellHeight;
        [self.contentView addSubview:self.mNameLabel];
        [self.contentView addSubview:self.addressLabel];
        [self.contentView addSubview:self.distanceLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLongPress:)];
        [self addGestureRecognizer:longGesture];
    }
    return self;
}

-(UILabel*)mNameLabel{
    if (!_mNameLabel) {
        _mNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(MarginH(20), 0, SCREEN_W/2, MarginH(25))];
        _mNameLabel.font = Font15;
        [_mNameLabel setTextColor:Color_black_50];
        _mNameLabel.center = CGPointMake(_mNameLabel.center.x, self.cellHeight/2 - CGRectGetHeight(_mNameLabel.frame)/2);
    }
    return _mNameLabel;
}


-(UILabel*)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(MarginH(20), 0, SCREEN_W - MarginH(40), MarginH(25))];
        _addressLabel.font = Font13;
        [_addressLabel setTextColor:Color_black_30];
        _addressLabel.center = CGPointMake(_addressLabel.center.x, self.cellHeight/2+CGRectGetHeight(_addressLabel.frame)/2);
    }
    return _addressLabel;
}


-(UILabel*)distanceLabel{
    if (!_distanceLabel) {
        _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.mNameLabel.frame), 0, SCREEN_W - CGRectGetMaxX(self.mNameLabel.frame) - MarginH(20), MarginH(25))];
        _distanceLabel.textAlignment = NSTextAlignmentRight;
        _distanceLabel.font = Font13;
        [_distanceLabel setTextColor:Color_Main];
        _distanceLabel.center = CGPointMake(_distanceLabel.center.x, self.mNameLabel.center.y);
    }
    return _distanceLabel;
}

-(void)btnLongPress:(UILongPressGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateBegan) {
        if (self.didLongPress) {
            self.didLongPress(self.mLocationData);
        }
    }
}
- (void)loardTableCellWithLocationData:(EHLocationData*)locationData curPostion:(CLLocationCoordinate2D)locationCoord{
    self.mLocationData = locationData;
    [self.mNameLabel setText:locationData.locationName];
    [self.addressLabel setText:locationData.address];
    
    CLLocation *curLocatioi = [[CLLocation alloc] initWithCoordinate:locationCoord altitude:kCLDistanceFilterNone horizontalAccuracy:kCLLocationAccuracyBest verticalAccuracy:kCLLocationAccuracyBest timestamp:[NSDate date]];
    CLLocation *curLocatioi11 = [[CLLocation alloc] initWithCoordinate:locationData.locationCoordinate altitude:kCLDistanceFilterNone horizontalAccuracy:kCLLocationAccuracyBest verticalAccuracy:kCLLocationAccuracyBest timestamp:[NSDate date]];
    
    CLLocationDistance distaicne = [curLocatioi distanceFromLocation:curLocatioi11];
    [self.distanceLabel  setText:[NSString stringWithFormat:@"%ld米",  (long)distaicne]];
    
}
@end
