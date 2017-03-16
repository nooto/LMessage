//
//  EHAnnotationView.h
//  LMessage
//
//  Created by GaoAng on 2017/3/16.
//  Copyright © 2017年 GaoAng. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import <MAMapKit/MAPointAnnotation.h>
@interface EHAnnotationView : MAAnnotationView
@property (nonatomic, strong) MAPointAnnotation* annotion;

-(id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier;


@end
