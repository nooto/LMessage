//
//  EHMapViewController.m
//  LMessage
//
//  Created by GaoAng on 16/6/20.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import "EHMapViewController.h"
#import <MAMapKit/MAMapKit.h>
@interface EHMapViewController() <MAMapViewDelegate>
@property (nonatomic, strong) MAMapView *mMapView;
@end

@implementation EHMapViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.mMapView];
}

-(MAMapView*)mMapView{
    if (!_mMapView) {
        _mMapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, NAVBAR_H, SCREEN_W, SCREEN_H - NAVBAR_H)];
        _mMapView.delegate = self;
    }
    return _mMapView;
}

@end
