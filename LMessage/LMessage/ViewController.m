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
#import "MJRefresh.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import "EHMapViewController.h"

@interface ViewController ()<MAMapViewDelegate, AMapLocationManagerDelegate>
@property (nonatomic, strong) AMapLocationManager *mLocationManager;

@property (nonatomic, strong) EHViewTableView *mTableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
	CGFloat scale = 1.0f;
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W - 19*scale - 20, 20, (19*scale), (25*scale))];
    rightBtn.titleLabel.font = Font15;
    [rightBtn addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"ic_location"] forState:UIControlStateNormal];
	rightBtn.center = CGPointMake(rightBtn.center.x, NAVBAR_H/2 + 10);
    [self.mNavBarView addSubview:rightBtn];
    [self hiddeBackButton];

    UIButton *seachBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(rightBtn.frame) + MarginH(20) ,
                                                                    20,
                                                                    CGRectGetMinX(rightBtn.frame)  - (CGRectGetWidth(rightBtn.frame) + MarginH(40)),
                                                                    NAVBAR_H - 30)];

    seachBtn.center = CGPointMake(seachBtn.center.x, CGRectGetHeight(self.mNavBarView.frame)/2 + 10);
    seachBtn.titleLabel.font = Font15;
    [seachBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [seachBtn setTitleColor:Color_black_30 forState:UIControlStateNormal];

    seachBtn.layer.borderColor = Color_white_30.CGColor;
    seachBtn.layer.borderWidth = 1.0f;
    seachBtn.layer.cornerRadius = 10.0f;
    [seachBtn addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.mNavBarView addSubview:seachBtn];
    
    [self.view addSubview:self.mTableView];
}

- (void)searchButtonAction:(UIButton*)sender{
    EHSearchViewController *vc = [[EHSearchViewController alloc] init];
    
    WS(weakSelf);
    [vc setDidAddLocationFinesh:^{
        [weakSelf updateView];
    }];
    
    [self pushViewController:vc];
}

-(void)saveButtonAction:(UIButton*)sender{
    EHMapViewController *vc = [[EHMapViewController alloc] init];
    [self pushViewController:vc];
}

- (void)tableViewHeardRefresh:(id)sender{
    [self.mLocationManager startUpdatingLocation];
}

#pragma mark - 
- (void)updateView{
    [self tableViewHeardRefresh:nil];
}

#pragma mark - 定位
-(void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    NSLog(@"定位成功！");
    LocationDataManager.mLocation = location;
    [self.mTableView headerEndRefreshing];
    [self.mTableView updateViewWithCLLocationCoordinate:location.coordinate];
}

-(void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"定位失败！");
    [self.mTableView headerEndRefreshing];
}


-(EHViewTableView*)mTableView{
    if (!_mTableView) {
        _mTableView = [[EHViewTableView alloc] initWithFrame:CGRectMake(0, NAVBAR_H, SCREEN_W, SCREEN_H - NAVBAR_H)];
        [_mTableView addHeaderWithTarget:self action:@selector(tableViewHeardRefresh:)];
    }
    return _mTableView;
}

-(AMapLocationManager*)mLocationManager{
    if (!_mLocationManager) {
        _mLocationManager = [[AMapLocationManager alloc] init];
        _mLocationManager.delegate = self;
    }
    return _mLocationManager;
}
@end
