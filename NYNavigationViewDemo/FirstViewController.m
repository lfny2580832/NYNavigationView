//
//  FirstViewController.m
//  NYNavigationViewDemo
//
//  Created by 牛严 on 2016/12/14.
//  Copyright © 2016年 牛严. All rights reserved.
//

#import "FirstViewController.h"
#import "GameCenterView/GameCenterView.h"

@interface FirstViewController ()
@property (nonatomic, strong) GameCenterView *gameCenterView;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.gameCenterView = [[GameCenterView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.gameCenterView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.gameCenterView startAnimation];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.gameCenterView stopAnimation];
}

@end
