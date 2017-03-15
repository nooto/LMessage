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

@interface EHMapViewController() <MAMapViewDelegate>
@property (nonatomic, strong) MAMapView *mMapView;
@end

@implementation EHMapViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.mMapView];
    [self.mMapView setCenterCoordinate:LocationDataManager.mLocation.coordinate animated:YES];
    [self.mMapView addAnnotations:[LocationDataManager createArrOfPointAnnotation]];
//    [self.mMapView selectAnnotation:self.mMapView.annotations.firstObject animated:YES];
}

- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    NSString * pinReusableIdentifier = @"fadsfsdfasdfasdfasf";

    MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:pinReusableIdentifier];
    if (!annotationView) {
        annotationView = [[MAAnnotationView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    }
    annotationView.image = [UIImage imageNamed:@"ic_add_selected"];
    
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
