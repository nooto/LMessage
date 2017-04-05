//
//  EHSearchViewController.m
//  LMessage
//
//  Created by GaoAng on 16/5/27.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import "EHSearchViewController.h"
#import "EHSearchTableView.h"
#import <AMapSearchKit/AMapSearchKit.h>
@interface EHSearchViewController() <EHSearchTableViewDelegate, AMapSearchDelegate>
@property (nonatomic, strong) UITextField *mTextField;
@property (nonatomic, strong) EHSearchTableView*mTableView;
@property (nonatomic, strong) NSMutableArray *mSourceDatas;
@property (nonatomic, strong) AMapSearchAPI *mSearchAPI;
@property (nonatomic, strong) AMapPOIAroundSearchRequest *mAroundRequest;
@end
@implementation EHSearchViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //配置用户Key
    [self.view addSubview:self.mTextField];
    [self.view addSubview:self.mTableView];
    self.automaticallyAdjustsScrollViewInsets = false;

    [self.mTextField becomeFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)textFieldDidChange:(NSObject*)sender{
//    [self.mAroundRequest setKeywords:self.mTextField.text];
//    [self.mSearchAPI cancelAllRequests];
//    [self.mSearchAPI AMapPOIAroundSearch:self.mAroundRequest];
}

#pragma mark -
-(void)backBtnPressed:(UIButton *)sender{
    [super backBtnPressed:sender];
    if (self.didAddLocationFinesh) {
        self.didAddLocationFinesh();
    }
}

#pragma mark - 
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{
    NSLog(@"%@",error.description);
}

-(void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    if (response.pois.count <= 0) {
        return;
    }
    
    [self.mSourceDatas removeAllObjects];
    [self.mSourceDatas addObjectsFromArray:response.pois];
	self.mTableView.showDetailViewIndex = -1;
    [self.mTableView reloadData];
}

-(void)searchButtonAction:(UIButton*)sender{
    [self.mSearchAPI cancelAllRequests];
    [self.mAroundRequest setKeywords:self.mTextField.text];
    [self.mSearchAPI AMapPOIAroundSearch:self.mAroundRequest];
    [self.mTextField resignFirstResponder];
}


#pragma mark - UITableView
-(NSArray*)seachTableViewSourceDatas{
    return self.mSourceDatas;
}

- (void)didSelectAMAPPOI:(AMapPOI *)mapPOI{
    [self.mTextField resignFirstResponder];
}

- (void)didSelectAddAMAPPOI:(AMapPOI *)mapPOI indexPath:(NSIndexPath *)indexPath{
    [LocationDataManager addMLocationData:[[EHLocationData alloc] initWithAMapPOI:mapPOI]];
    [self.mTableView reloadTableViewWithIndexPath:indexPath];
}

-(UITextField*)mTextField{
    if (!_mTextField) {
        _mTextField = [[UITextField alloc] initWithFrame:CGRectMake(MarginW(50), 20, SCREEN_W - MarginW(100), MarginH(44))];
        _mTextField.layer.cornerRadius = 15.0f;
        _mTextField.layer.borderColor = Color_white_50.CGColor;
        _mTextField.layer.borderWidth = 1.0f;
        _mTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_mTextField setPlaceholder:@"请输入内容。。。" WithColor:[UIColor grayColor]];
        [_mTextField setKeyboardType:UIKeyboardTypeDefault];
        
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, CGRectGetHeight(_mTextField.frame))];
        [_mTextField setLeftView:leftView];
        _mTextField.leftViewMode = UITextFieldViewModeAlways;
        
        UIButton *searchButton= [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetHeight(_mTextField.frame)-10, CGRectGetHeight(_mTextField.frame))];
        [searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [searchButton setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
        [_mTextField setRightView:searchButton];
        _mTextField.rightViewMode = UITextFieldViewModeAlways;
    }
    return _mTextField;
}

-(EHSearchTableView*)mTableView{
    if (!_mTableView) {
        _mTableView = [[EHSearchTableView alloc] initWithFrame:CGRectMake(0, NAVBAR_H, SCREEN_W, SCREEN_H - NAVBAR_H) withDelegate:self];
    }
    return _mTableView;
}

- (NSMutableArray*)mSourceDatas{
    if (!_mSourceDatas) {
        _mSourceDatas = [[NSMutableArray alloc] init];
    }
    return _mSourceDatas;
}

-(AMapSearchAPI*)mSearchAPI{
    if (!_mSearchAPI) {
        _mSearchAPI = [[AMapSearchAPI alloc] init];
        _mSearchAPI.delegate = self;
    }
    return _mSearchAPI;
}

- (AMapPOIAroundSearchRequest*)mAroundRequest{
    if (!_mAroundRequest) {
        _mAroundRequest = [[AMapPOIAroundSearchRequest alloc] init];
        _mAroundRequest.location = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];
//        request.keywords = @"方恒";
        // types属性表示限定搜索POI的类别，默认为：餐饮服务|商务住宅|生活服务
        // POI的类型共分为20种大类别，分别为：
        // 汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|
        // 医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|
        // 交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施
//        request.types = @"餐饮服务|生活服务";
        _mAroundRequest.sortrule = 0;
        _mAroundRequest.requireExtension = YES;
    }
    return _mAroundRequest;
}

@end
