//
//  EHSearchTableSelectedCellView.m
//  LMessage
//
//  Created by GaoAng on 2017/3/23.
//  Copyright © 2017年 GaoAng. All rights reserved.
//

#import "EHSearchTableSelectedCellView.h"
@interface EHSearchTableSelectedCellView()
@property (nonatomic, strong) MAMapView *mMapView;
@end

@implementation EHSearchTableSelectedCellView
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		[self setupview];
		[self.contentView addSubview:self.mMapView];
	}
	return self;
}

-(MAMapView*)mMapView{
	if (!_mMapView) {
		_mMapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, CellTopHeight, SCREEN_W, CellBottomHeight)];
	}
	return _mMapView;
}
-(void)layoutSubviews{
	[super layoutSubviews];
	[self.mMapView setFrame:CGRectMake(0, CellTopHeight, SCREEN_W, CellBottomHeight)];
}

-(void)setMapPOI:(AMapPOI *)mapPOI{
	[super setMapPOI:mapPOI];
	[self.mMapView setCenterCoordinate:CLLocationCoordinate2DMake(mapPOI.location.latitude, mapPOI.location.longitude) animated:YES];
}

@end
