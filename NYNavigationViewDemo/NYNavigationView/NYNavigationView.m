//
//  NYNavigationView.m
//  NYNavigationViewDemo
//
//  Created by 牛严 on 2016/12/13.
//  Copyright © 2016年 牛严. All rights reserved.
//

#import "NYNavigationView.h"
#import "UIView+NYNavigation.h"

@interface NYNavigationView ()<CAAnimationDelegate>
@property (nonatomic, strong) UIView *rootView;
@property (nonatomic, strong) NSMutableArray *views;
@end

@implementation NYNavigationView

static NSString *PUSH = @"push";
static NSString *POP = @"pop";

- (instancetype)initWithRootView:(UIView *)rootView
{
    self = [super initWithFrame:rootView.frame];
    if (self) {
        self.rootView = rootView;
        self.rootView.clipsToBounds = YES;
        CGRect frame = rootView.frame;
        frame.origin = CGPointMake(0, 0);
        rootView.frame = frame;
        [self addSubview:rootView];
        self.views = [NSMutableArray array];
        [self.views addObject:rootView];
    }
    return self;
}

- (void)didMoveToWindow
{
    self.rootView.ny_naviagationView = self;
}

- (void)pushView:(UIView *)view animated:(BOOL)animated
{
    if (animated) {
        CAKeyframeAnimation *pushAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
        pushAnimation.values = @[@(1.5*self.rootView.frame.size.width),@(0.5*self.rootView.frame.size.width)];
        pushAnimation.duration = 0.3;
        pushAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pushAnimation.delegate = self;
        pushAnimation.autoreverses = NO;
        pushAnimation.removedOnCompletion = NO;
        pushAnimation.fillMode = kCAFillModeForwards;
        [pushAnimation setValue:PUSH forKey:PUSH];
        [view.layer addAnimation:pushAnimation forKey:PUSH];
    }
    [self.views addObject:view];
    view.ny_naviagationView = self;
    [self addSubview:view];
}

- (void)popViewAnimated:(BOOL)animated
{
    UIView *view = [self.views lastObject];
    if (animated) {
        CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
        popAnimation.values = @[@(0.5*self.rootView.frame.size.width),@(1.5*self.rootView.frame.size.width)];
        popAnimation.duration = 0.3;
        popAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        popAnimation.delegate = self;
        popAnimation.autoreverses = NO;
        popAnimation.removedOnCompletion = NO;
        popAnimation.fillMode = kCAFillModeForwards;
        [popAnimation setValue:POP forKey:POP];
        [view.layer addAnimation:popAnimation forKey:POP];
    }else{
        [self.views removeObject:view];
        [view removeFromSuperview];
    }
}

#pragma mark CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    UIView *view = [self.views lastObject];
    if (anim == [view.layer animationForKey:POP ]) {
        [self.views removeObject:view];
        [view removeFromSuperview];
    }
}

@end
