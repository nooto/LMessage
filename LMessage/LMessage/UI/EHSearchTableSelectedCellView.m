//
//  EHSearchTableSelectedCellView.m
//  LMessage
//
//  Created by GaoAng on 2017/3/23.
//  Copyright © 2017年 GaoAng. All rights reserved.
//

#import "EHSearchTableSelectedCellView.h"
#import "EHLocationDataManager.h"
#import "EHAnnotationView.h"
@interface EHSearchTableSelectedCellView()<MAMapViewDelegate>
@property (nonatomic, strong) MAMapView *mMapView;
@property (nonatomic, strong) MAPointAnnotation *mPointAnnotation;
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
		_mMapView.delegate = self;
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
	if (self.mPointAnnotation) {
		[self.mMapView removeAnnotation:self.mPointAnnotation];
	}

//	do {
//		[self.mMapView removeAnnotation:self.mMapView.annotations.firstObject];
//	} while (self.mMapView.annotations.count > 0);

	MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
	pointAnnotation.title = mapPOI.name;
	pointAnnotation.subtitle = mapPOI.address;
	pointAnnotation.coordinate = CLLocationCoordinate2DMake(mapPOI.location.latitude, mapPOI.location.longitude);
	[self.mMapView addAnnotation:pointAnnotation];
	self.mPointAnnotation = pointAnnotation;
}

- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
	NSString * reusableIdentifier = @"EHAnnotationView";
	EHAnnotationView *annotationView = (EHAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:reusableIdentifier];
	if (!annotationView) {
		annotationView = [[EHAnnotationView alloc] initWithFrame:CGRectMake(0, 0, 100, 150) reuseIdentifier:reusableIdentifier];
	}
	if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
		[annotationView setAnnotion:(MAPointAnnotation*)annotation];
	}
	return annotationView;
}

@end
