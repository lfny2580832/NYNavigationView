//
//  MidNYView.m
//  NYNavigationViewDemo
//
//  Created by 牛严 on 2016/12/14.
//  Copyright © 2016年 牛严. All rights reserved.
//

#import "MidNYView.h"
#import "UIView+NYNavigation.h"

@interface MidNYView ()
@property (nonatomic, strong) UIView *topView;
@end

@implementation MidNYView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.topView];
        CGFloat scale = self.frame.size.width/SCREEN_WIDTH;
        self.topView.transform = CGAffineTransformScale(self.transform, scale, scale);
        self.topView.center = CGPointMake(self.center.x, 64*scale/2);
    }
    return self;
}

- (void)leftItemTapped
{
    [self.ny_naviagationView popViewAnimated:YES];
}

- (void)rightItemTapped
{
    
}

- (void)setLeftImage:(UIImage *)image title:(NSString *)title rightItem:(NSString *)rightItem
{
    if (image) {
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton setImage:image forState:UIControlStateNormal];
        leftButton.frame = CGRectMake(14, 20, 44, 44);
        [leftButton addTarget:self action:@selector(leftItemTapped) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:leftButton];
    }
    if (title) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
        titleLabel.text = title;
        titleLabel.font = [UIFont systemFontOfSize:18];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.topView addSubview:titleLabel];
    }
    if (rightItem) {
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setTitle:rightItem forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        rightButton.frame = CGRectMake(SCREEN_WIDTH - 100,20 , 100, 44);
        [rightButton addTarget:self action:@selector(rightItemTapped) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:rightButton];
    }
}

- (UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        _topView.backgroundColor = rgba(249, 249, 249, 1);
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = rgba(213, 213, 213, 1);
        [_topView addSubview:lineView];
    }
    return _topView;
}

@end
