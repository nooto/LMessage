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
@end

@implementation EHViewTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier height:(CGFloat)cellHeight{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier height:cellHeight]) {
        self.cellHeight = cellHeight;
        [self.contentView addSubview:self.mNameLabel];
    }
    return self;
}

-(UILabel*)mNameLabel{
    if (!_mNameLabel) {
        _mNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(MarginH(20), 0, SCREEN_W/2, MarginH(25))];
        _mNameLabel.center = CGPointMake(_mNameLabel.center.x, self.cellHeight/2);
    }
    return _mNameLabel;
}

- (void)setMLocationData:(EHLocationData *)mLocationData{
    _mLocationData = mLocationData;
    [self.mNameLabel sizeToFitWithText:mLocationData.locationName MaxWidth:SCREEN_W/2];
}
@end
