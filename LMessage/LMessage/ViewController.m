//
//  ViewController.m
//  LMessage
//
//  Created by GaoAng on 16/3/21.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import "ViewController.h"
#import "EHSearchViewController.h"
#import "EHViewTableView.h"
#import <MAMapKit/MAMapKit.h>
@interface ViewController ()<MAMapViewDelegate>
@property (nonatomic, strong) MAMapView *mMapView;
@property (nonatomic, strong) AMapLocationManager *mLocationManager;
@property (nonatomic, strong) EHViewTableView *mTableView;
@property (nonatomic, strong) UIButton  *mLocationButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W - 40 - 15 ,20, NAVBAR_H+20, NAVBAR_H - 20)];
    rightBtn.titleLabel.font = Font15;
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addRightButton:rightBtn];
    
    [self.view addSubview:self.mTableView];
    [self.view addSubview:self.mMapView];
    [self.view addSubview:self.mLocationButton];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.mMapView.showsUserLocation = YES;
    self.mMapView.userTrackingMode = MAUserTrackingModeFollow;
    [self.mMapView setZoomLevel:16.1 animated:YES];
    self.mMapView.visibleMapRect = MAMapRectMake(220880104, 101476980, 272496, 466656);

}

-(void)saveButtonAction:(UIButton*)sender{
    EHSearchViewController *vc = [[EHSearchViewController alloc] init];
    [self pushViewController:vc];
}
- (void)locationButtonAction:(UIButton*)sender{

    self.mMapView.showsUserLocation = YES;
}

-(void)mapViewDidStopLocatingUser:(MAMapView *)mapView{
    self.mMapView.showsUserLocation = YES;
}

-(EHViewTableView*)mTableView{
    if (!_mTableView) {
        _mTableView = [[EHViewTableView alloc] initWithFrame:CGRectMake(0, NAVBAR_H, SCREEN_W, SCREEN_H/2)];
    }
    return _mTableView;
}

-(MAMapView*)mMapView{
    if (!_mMapView) {
        _mMapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.mTableView.frame), SCREEN_W, SCREEN_H - CGRectGetMaxY(self.mTableView.frame))];
        _mMapView.delegate = self;
        _mMapView.showsUserLocation = YES;
    }
    return _mMapView;
}

-(UIButton*)mLocationButton{
    if (!_mLocationButton) {
        _mLocationButton = [[UIButton alloc] initWithFrame:CGRectMake(MarginH(20), SCREEN_H - 60, 50, 50)];
        _mLocationButton.backgroundColor = [UIColor grayColor];
        _mLocationButton.layer.borderWidth = 1.0f;
        _mLocationButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _mLocationButton.layer.cornerRadius = CGRectGetWidth(_mLocationButton.frame)/2;
        [_mLocationButton addTarget:self action:@selector(locationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mLocationButton;
}
@end
