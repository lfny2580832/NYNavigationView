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
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setLeftImage:[UIImage imageNamed:@"back-red"] title:@"第三页" rightItem:nil];

        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
        imageView.center = self.center;
        imageView.image = [UIImage imageNamed:@"dragon2"];
        [self addSubview:imageView];
    }
    return self;
}

- (void)leftItemTapped
{
    [self.ny_naviagationView popViewAnimated:YES];
}

@end
