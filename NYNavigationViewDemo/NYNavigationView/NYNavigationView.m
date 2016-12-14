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
{
    CGFloat _width;
    BOOL _isPushing;
    BOOL _isPoping;
}

static NSString *PUSH = @"push";
static NSString *POP = @"pop";

- (instancetype)initWithRootView:(UIView *)rootView
{
    self = [super initWithFrame:rootView.frame];
    if (self) {
        self.clipsToBounds = YES;
        self.views = [NSMutableArray array];
        self.rootView = rootView;
        [self.views addObject:rootView];
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor grayColor].CGColor;
    }
    return self;
}

- (void)didMoveToWindow
{
    self.rootView.ny_naviagationView = self;
}

///PUSH
- (void)pushView:(UIView *)view animated:(BOOL)animated
{
    if (animated) {
        if (_isPushing) {
            return;
        }
        _isPushing = YES;
        CAKeyframeAnimation *pushAnimation = [self animationWithKeyPath:@"position.x" values:@[@(1.5*_width),@(0.5*_width)]];
        [pushAnimation setValue:PUSH forKey:PUSH];
        [view.layer addAnimation:pushAnimation forKey:PUSH];
        
        view.layer.shadowColor = [UIColor blackColor].CGColor;
        view.layer.shadowOffset = CGSizeMake(-5, 0);
        view.layer.shadowRadius = 3;
        CAKeyframeAnimation *shadowAnimation = [self animationWithKeyPath:@"shadowOpacity" values:@[@0,@0.3]];
//        [view.layer addAnimation:shadowAnimation forKey:nil];
        
        CAKeyframeAnimation *nextAnimation = [self animationWithKeyPath:@"position.x" values:@[@(0.5*_width),@(0.25*_width)]];
        UIView *nextView = [self.views lastObject];
        [nextView.layer addAnimation:nextAnimation forKey:nil];

    }
    [self.views addObject:view];
    view.ny_naviagationView = self;
    [self addSubview:view];
}

///POP
- (void)popViewAnimated:(BOOL)animated
{
    UIView *view = [self.views lastObject];
    if (animated) {
        if (_isPoping) {
            return;
        }
        _isPoping = YES;
        CAKeyframeAnimation *popAnimation = [self animationWithKeyPath:@"position.x" values:@[@(0.5*_width),@(1.5*_width)]];
        [popAnimation setValue:POP forKey:POP];
        [view.layer addAnimation:popAnimation forKey:POP];

        CAKeyframeAnimation *shadowAnimation = [self animationWithKeyPath:@"shadowOpacity" values:@[@0.3,@0]];
//        [view.layer addAnimation:shadowAnimation forKey:nil];
        
        CAKeyframeAnimation *nextAnimation = [self animationWithKeyPath:@"position.x" values:@[@(0.25*_width),@(0.5*_width)]];
        UIView *nextView = self.views[self.views.count - 2];
        [nextView.layer addAnimation:nextAnimation forKey:nil];
    }else{
        [self.views removeObject:view];
        [view removeFromSuperview];
    }
}

///生成push、pop中需要的动画
- (CAKeyframeAnimation *)animationWithKeyPath:(NSString *)keyPath values:(NSArray *)values
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    animation.values = values;
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.delegate = self;
    animation.autoreverses = NO;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

///设置rootView 类似UINavigationViewController的rootViewController
- (void)setRootView:(UIView *)rootView
{
    _rootView = rootView;
    _width = rootView.frame.size.width;
    CGRect frame = rootView.frame;
    frame.origin = CGPointMake(0, 0);
    rootView.frame = frame;
    [self addSubview:rootView];
}

#pragma mark CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    UIView *view = [self.views lastObject];
    if (anim == [view.layer animationForKey:POP ]) {
        _isPoping = NO;
        [self.views removeObject:view];
        [view removeFromSuperview];
    }else if (anim == [view.layer animationForKey:PUSH]) {
        _isPushing = NO;
    }
}

@end
