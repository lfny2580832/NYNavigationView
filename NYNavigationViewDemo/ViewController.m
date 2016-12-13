//
//  ViewController.m
//  NYNavigationViewDemo
//
//  Created by 牛严 on 2016/12/13.
//  Copyright © 2016年 牛严. All rights reserved.
//

#import "ViewController.h"
#import "NYNavigationView/NYNavigationView.h"
#import "FirstView.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 600, 100, 40)];
    btn.backgroundColor = [UIColor grayColor];
    [btn addTarget:self action:@selector(addNavView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)addNavView
{
    FirstView *view = [[FirstView alloc]initWithFrame:CGRectMake(75, 100, 250, 400)];
    view.center = self.view.center;
    NYNavigationView *navView = [[NYNavigationView alloc]initWithRootView:view];
    [self.view addSubview:navView];
}



@end
