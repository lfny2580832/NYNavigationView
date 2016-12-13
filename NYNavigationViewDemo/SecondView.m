//
//  SecondView.m
//  NYNavigationViewDemo
//
//  Created by 牛严 on 2016/12/13.
//  Copyright © 2016年 牛严. All rights reserved.
//

#import "SecondView.h"
#import "ThirdView.h"
#import "UIView+NYNavigation.h"

@implementation SecondView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        [btn setTitle:@"push" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
        [btn2 setTitle:@"pop" forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn2];
    }
    return self;
}

- (void)push
{
    ThirdView *view = [[ThirdView alloc]initWithFrame:CGRectMake(0, 0, 250, 400)];
    [self.ny_naviagationView pushView:view animated:YES];
}

- (void)pop
{
    [self.ny_naviagationView popViewAnimated:YES];
}

@end
