//
//  ThirdView.m
//  NYNavigationViewDemo
//
//  Created by 牛严 on 2016/12/13.
//  Copyright © 2016年 牛严. All rights reserved.
//

#import "ThirdView.h"
#import "UIView+NYNavigation.h"

@implementation ThirdView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        
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
//    ThirdView *view = [[ThirdView alloc]initWithFrame:CGRectMake(0, 0, 300, 600)];
//    [self.navigationView pushView:view animated:YES];
}

- (void)pop
{
    [self.ny_naviagationView popViewAnimated:YES];
}

@end
