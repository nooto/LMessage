//
//  HistoryViewController.m
//  LMessage
//
//  Created by GaoAng on 16/4/16.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import "HistoryViewController.h"
#import "AppDelegate.h"
@interface HistoryViewController() <UITableViewDelegate, UITableViewDataSource>

@end
@implementation HistoryViewController

-(IBAction)backButtonActon:(id)sender{
    [self popViewControllerAnimated];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return MarginH(44);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    cell.backgroundColor = indexPath.row%2 ? [UIColor greenColor] : [UIColor yellowColor];
    return cell;
}

@end
