//
//  EHSearchTableView.m
//  LMessage
//
//  Created by GaoAng on 16/6/16.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import "EHSearchTableView.h"
#import "EHSearchTableCellView.h"
@interface EHSearchTableView() <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) id<EHSearchTableViewDelegate> m_delegate;
@property (nonatomic, assign) NSInteger  selectIndex;
@end

@implementation EHSearchTableView
-(id)initWithFrame:(CGRect)frame withDelegate:(id)delegate{
    if (self = [super initWithFrame:frame style:UITableViewStyleGrouped]) {
        self.dataSource = self;
        self.selectIndex = -1;
        self.m_delegate = delegate;
        self.delegate = self;
        self.rowHeight = MarginH(55);
    }
    return self;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.selectIndex) {
        return MarginH(120);
    }
    else{
        return MarginH(60);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.m_delegate seachTableViewSourceDatas].count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indetifier  =@"EHSearchTableCellView";
    EHSearchTableCellView *cell = [tableView dequeueReusableCellWithIdentifier:indetifier];
    if (!cell) {
        cell = [[EHSearchTableCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indetifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        WS(weakSelf);
        [cell setDidSelectAddPOI:^(AMapPOI *mapPOI) {
            if (weakSelf.m_delegate && [weakSelf.m_delegate respondsToSelector:@selector(didSelectAddAMAPPOI:)]) {
                [weakSelf.m_delegate didSelectAddAMAPPOI:mapPOI];
            }
        }];
    }
    [cell loardMapPOI:[[self.m_delegate seachTableViewSourceDatas] objectAtIndex:indexPath.row] showType: self.selectIndex == indexPath.row ? 1: 0];
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:2];
    if (self.selectIndex < 0) {
        [arr addObject:indexPath];
    }
    else{
        if (self.selectIndex != indexPath.row) {
            [arr addObject:[NSIndexPath indexPathForRow:self.selectIndex inSection:0]];
        }
    }
    [arr addObject:indexPath];
    
    
    if (self.selectIndex == indexPath.row) {
        self.selectIndex = -1;
    }
    self.selectIndex = indexPath.row;
    
    //
    [self beginUpdates];
    [self reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationTop];
    [self endUpdates];

    
    if (self.m_delegate && [self.m_delegate respondsToSelector:@selector(didSelectAMAPPOI:)]) {
        [self.m_delegate didSelectAMAPPOI:[[self.m_delegate seachTableViewSourceDatas] objectAtIndex:indexPath.row]];
    }
}

@end
