//
//  HistoryViewController.m
//  LMessage
//
//  Created by GaoAng on 16/4/16.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import "HistoryViewController.h"

@implementation HistoryViewController


-(IBAction)backButtonActon:(id)sender{
//    [self popViewControllerAnimated];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end
