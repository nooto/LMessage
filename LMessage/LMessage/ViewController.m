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
@interface ViewController ()<MAMapViewDelegate, AMapLocationManagerDelegate>
@property (nonatomic, strong) AMapLocationManager *mLocationManager;

@property (nonatomic, strong) EHViewTableView *mTableView;
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
    [self hiddeBackButton];
    
    [self.view addSubview:self.mTableView];
}

-(void)saveButtonAction:(UIButton*)sender{
    EHSearchViewController *vc = [[EHSearchViewController alloc] init];
    
    WS(weakSelf);
    [vc setDidAddLocationFinesh:^{
        [weakSelf updateView];
    }];
    
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
