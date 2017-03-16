//
//  EHAnnotationView.m
//  LMessage
//
//  Created by GaoAng on 2017/3/16.
//  Copyright © 2017年 GaoAng. All rights reserved.
//

#import "EHAnnotationView.h"
#import "UILabel+AutoSize.h"
@interface EHAnnotationView ()
@property (nonatomic, strong) UILabel *mNameLabel;
@end

@implementation EHAnnotationView
-(id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithAnnotation:nil reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.mNameLabel];
    }
    return self;
}

-(UILabel*)mNameLabel{
    if (!_mNameLabel) {
        _mNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -20, 140, 20)];
        [_mNameLabel setFont:Font13];
        _mNameLabel.textAlignment = NSTextAlignmentCenter;
        [_mNameLabel setTextColor:Color_black_100];
    }
    return _mNameLabel;
}

-(void)layoutSubviews{
    [_mNameLabel sizeToFitForWidth];
    [_mNameLabel setCenter:CGPointMake(CGRectGetWidth(self.frame)/2, -CGRectGetHeight(_mNameLabel.frame)/2)];
    [super layoutSubviews];
}

-(void)setAnnotion:(MAPointAnnotation*)annotion{
    _annotion = annotion;
    NSLog(@"%f %f", annotion.coordinate.latitude, annotion.coordinate.longitude);
    self.image = [UIImage imageNamed:@"ic_add"];
    [self.mNameLabel setText:annotion.subtitle];
}

@end
