//
//  EHSearchTableView.m
//  LMessage
//
//  Created by GaoAng on 16/6/16.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import "EHSearchTableView.h"
#import "EHSearchTableCellView.h"
#import "EHSearchTableSelectedCellView.h"


@interface EHSearchTableView() <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) id<EHSearchTableViewDelegate> m_delegate;
@property (nonatomic, assign) NSInteger  showDetailViewIndex;
@end

@implementation EHSearchTableView
-(id)initWithFrame:(CGRect)frame withDelegate:(id)delegate{
    if (self = [super initWithFrame:frame style:UITableViewStylePlain]) {
        self.dataSource = self;
        self.showDetailViewIndex = -1;
        self.m_delegate = delegate;
        self.delegate = self;
    }
    return self;
}
- (void)reloadTableViewWithIndexPath:(NSIndexPath *)indexPath{
    if (![indexPath isKindOfClass:[NSIndexPath class]]) {
        return;
    }

    if ( indexPath.row >=0 && indexPath.row < [self.m_delegate seachTableViewSourceDatas].count) {
        [self beginUpdates];
        [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self endUpdates];
    }
    
}
#pragma mark =
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.showDetailViewIndex) {
        return CellTopHeight + CellBottomHeight;
    }
    else{
        return CellTopHeight;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.m_delegate seachTableViewSourceDatas].count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSString *indetifier = nil;
	EHSearchTableCellView *cell = nil;

	if (indexPath.row == self.showDetailViewIndex) {
		indetifier  =@"EHSearchTableSelectedCellView";
		cell = [tableView dequeueReusableCellWithIdentifier:indetifier];
		if (![cell isKindOfClass:[EHSearchTableSelectedCellView class]]) {
			cell = [[EHSearchTableSelectedCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indetifier];
		}
	}
	else{
		indetifier  =@"EHSearchTableCellView";
		cell = [tableView dequeueReusableCellWithIdentifier:indetifier];
		if (![cell isKindOfClass:[EHSearchTableCellView class]]) {
			cell = [[EHSearchTableCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indetifier];
		}
	}

	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	WS(weakSelf);
	[cell setDidSelectAddPOI:^(AMapPOI *mapPOI) {
		if (weakSelf.m_delegate && [weakSelf.m_delegate respondsToSelector:@selector(didSelectAddAMAPPOI: indexPath:)]) {
			[weakSelf.m_delegate didSelectAddAMAPPOI:mapPOI indexPath:indexPath];
		}
	}];
	[cell setMapPOI:[[self.m_delegate seachTableViewSourceDatas] objectAtIndex:indexPath.row]];
	return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:2];
    if (self.showDetailViewIndex < 0) {
        [arr addObject:indexPath];
        self.showDetailViewIndex = indexPath.row;
    }
    else if (self.showDetailViewIndex == indexPath.row){
        [arr addObject:indexPath];
        self.showDetailViewIndex = -1;
    }
    else{
		if (self.showDetailViewIndex < indexPath.row) {
			[arr addObject:indexPath];
			[arr addObject:[NSIndexPath indexPathForRow:self.showDetailViewIndex inSection:0]];
		}
		else{
			[arr addObject:[NSIndexPath indexPathForRow:self.showDetailViewIndex inSection:0]];
			[arr addObject:indexPath];
		}
        self.showDetailViewIndex = indexPath.row;
    }

    if (arr.count) {
        [self beginUpdates];
        [self reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
        [self endUpdates];
    }

    if (self.m_delegate && [self.m_delegate respondsToSelector:@selector(didSelectAMAPPOI:)]) {
        [self.m_delegate didSelectAMAPPOI:[[self.m_delegate seachTableViewSourceDatas] objectAtIndex:indexPath.row]];
    }
}

@end
