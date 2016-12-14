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
        self.backgroundColor = [UIColor whiteColor];
        
        [self setLeftImage:[UIImage imageNamed:@"back-red"] title:@"第二页" rightItem:@"下一页"];

        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
        imageView.center = self.center;
        imageView.image = [UIImage imageNamed:@"dragon1"];
        [self addSubview:imageView];
    }
    return self;
}

- (void)leftItemTapped
{
    [self.ny_naviagationView popViewAnimated:YES];
}

- (void)rightItemTapped
{
    ThirdView *view = [[ThirdView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.7, SCREEN_HEIGHT*0.7)];
    [self.ny_naviagationView pushView:view animated:YES];
}

@end
