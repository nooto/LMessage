//
//  EHViewTableViewCell.h
//  LMessage
//
//  Created by GaoAng on 16/5/31.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHLocationData.h"
@interface EHViewTableViewCell : UITableViewCell
@property (nonatomic, weak) EHLocationData *mLocationData;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellHeight:(CGFloat)cellHeight;
@end
