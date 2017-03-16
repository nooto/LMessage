//
//  EHMapViewController.m
//  LMessage
//
//  Created by GaoAng on 16/6/20.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import "EHMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <MAMapKit/MAAnnotation.h>
#import <MAMapKit/MAPointAnnotation.h>
#import "EHAnnotationView.h"

@interface EHMapViewController() <MAMapViewDelegate>
@property (nonatomic, strong) MAMapView *mMapView;
@end

@implementation EHMapViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setTitle:@"地图查看"];
    [self.view addSubview:self.mMapView];
    [self.mMapView setCenterCoordinate:LocationDataManager.mLocation.coordinate animated:YES];
//    [self.mMapView addAnnotations:[LocationDataManager createArrOfPointAnnotation]];
    [self.mMapView addAnnotation:[LocationDataManager createArrOfPointAnnotation].firstObject];
//    [self.mMapView selectAnnotation:self.mMapView.annotations.firstObject animated:YES];
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
- (void)mapView:(MAMapView *)mapView mapWillZoomByUser:(BOOL)wasUserAction{

}

-(MAMapView*)mMapView{
    if (!_mMapView) {
        _mMapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, NAVBAR_H, SCREEN_W, SCREEN_H - NAVBAR_H)];
        _mMapView.delegate = self;
    }
    return _mMapView;
}



@end
