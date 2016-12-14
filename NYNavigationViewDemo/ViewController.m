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



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addNavView];
}

- (void)addNavView
{
    FirstView *view = [[FirstView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.7, SCREEN_HEIGHT*0.7)];
    view.center = self.view.center;
    NYNavigationView *navView = [[NYNavigationView alloc]initWithRootView:view];
    [self.view addSubview:navView];
    UIImageView *statusBar = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.3/2+1, SCREEN_HEIGHT*0.3/2+0.5, view.frame.size.width-2, 14)];
    statusBar.image = [UIImage imageNamed:@"statusbar.jpg"];
    [self.view addSubview:statusBar];
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.15, SCREEN_HEIGHT*0.3/2+0.5-20, 100, 14)];
    timeLabel.center = CGPointMake(self.view.center.x, SCREEN_HEIGHT*0.3/2+7.5);
    timeLabel.text = @"3.45 PM";
    timeLabel.backgroundColor = rgba(249, 249, 249, 1);
    timeLabel.font = [UIFont boldSystemFontOfSize:8];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:timeLabel];
}

- (IBAction)pop:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
