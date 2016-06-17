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
    }
    return self;
}

-(UILabel*)mNameLabel{
    if (!_mNameLabel) {
        _mNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(MarginH(20), 0, SCREEN_W/2, MarginH(25))];
        _mNameLabel.center = CGPointMake(_mNameLabel.center.x, self.cellHeight/2 - CGRectGetHeight(_mNameLabel.frame)/2);
    }
    return _mNameLabel;
}


-(UILabel*)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(MarginH(20), 0, SCREEN_W/2, MarginH(25))];
        _addressLabel.center = CGPointMake(_mNameLabel.center.x, self.cellHeight/2+CGRectGetHeight(_addressLabel.frame)/2);
    }
    return _addressLabel;
}


-(UILabel*)distanceLabel{
    if (!_distanceLabel) {
        _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(MarginH(20), 0, SCREEN_W/2, MarginH(25))];
        _distanceLabel.center = CGPointMake(_mNameLabel.center.x, self.cellHeight/2);
    }
    return _distanceLabel;
}

- (void)loardTableCellWithLocationData:(EHLocationData*)locationData curPostion:(CLLocationCoordinate2D)locationCoord{
    self.mLocationData = locationData;
    [self.mNameLabel sizeToFitWithText:locationData.locationName MaxWidth:SCREEN_W/2];
    [self.distanceLabel sizeToFitWithText:locationData.address MaxWidth:SCREEN_W/2];
    
    CLLocation *curLocatioi = [[CLLocation alloc] initWithCoordinate:locationCoord altitude:kCLDistanceFilterNone horizontalAccuracy:kCLLocationAccuracyBest verticalAccuracy:kCLLocationAccuracyBest timestamp:[NSDate date]];
    CLLocation *curLocatioi11 = [[CLLocation alloc] initWithCoordinate:locationData.locationCoordinate altitude:kCLDistanceFilterNone horizontalAccuracy:kCLLocationAccuracyBest verticalAccuracy:kCLLocationAccuracyBest timestamp:[NSDate date]];
    
    CLLocationDistance distaicne = [curLocatioi distanceFromLocation:curLocatioi11];
    [self.distanceLabel  setText:[NSString stringWithFormat:@"%ld米",  (long)distaicne]];
    
}
@end
