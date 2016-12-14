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
#import "GameCenterView.h"

@interface FirstView ()
@property (nonatomic, strong) GameCenterView *gameCenterView;

@end
@implementation FirstView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self setLeftImage:nil title:@"第一页" rightItem:@"下一页"];
        
        self.gameCenterView = [[GameCenterView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.gameCenterView.center = self.center;
        [self addSubview:_gameCenterView];
        
        [self.gameCenterView startAnimation];
    }
    return self;
}

- (void)rightItemTapped
{
    SecondView *view = [[SecondView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.7, SCREEN_HEIGHT*0.7)];
    [self.ny_naviagationView pushView:view animated:YES];
}

//- (void)layoutSubviews
//{
//    
//}

@end
