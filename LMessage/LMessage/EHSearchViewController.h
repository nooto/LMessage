//
//  EHSearchViewController.h
//  LMessage
//
//  Created by GaoAng on 16/5/27.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import "EHBaseViewController.h"
#import "EHLocationDataManager.h"
#import <AMapSearchKit/AMapSearchKit.h>
@interface EHSearchViewController : EHBaseViewController
@property (nonatomic, copy) void(^didAddLocationFinesh)();
@end
