//
//  FirstView.m
//  NYNavigationViewDemo
//
//  Created by 牛严 on 2016/12/13.
//  Copyright © 2016年 牛严. All rights reserved.
//

#import "FirstView.h"
#import "SecondView.h"
#import "UIView+NYNavigation.h"

@implementation FirstView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        [btn setTitle:@"push" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}

- (void)push
{
    SecondView *view = [[SecondView alloc]initWithFrame:CGRectMake(0, 0, 250, 400)];
    [self.ny_naviagationView pushView:view animated:YES];
}

@end
