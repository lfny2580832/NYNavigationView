//
//  BallAnimationLayer.m
//  GameCenterAnimation
//
//  Created by 牛严 on 2016/12/8.
//  Copyright © 2016年 牛严. All rights reserved.
//

#import "BallAnimationLayer.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define sinx(a)  sin(a/180*M_PI)
#define cosx(a)  cos(a/180*M_PI)

@interface BallAnimationLayer ()<CAAnimationDelegate>
@property (nonatomic, strong) CAGradientLayer *ball;
@property (nonatomic, strong) CAKeyframeAnimation *positionShowAnimation;
@end

@implementation BallAnimationLayer
{
    BallAnimationModel *_model;
}

static NSString *SHOWFADE = @"SHOWFADE";
static NSString *SHOWSCALE = @"SHOWSCALE";
static NSString *SHOWPOSITION = @"SHOWPOSITION";
static NSString *HIDEPOSITION = @"HIDEPOSITION";
static NSString *RANDOMPOSITION = @"RANDOMPOSITION";

- (instancetype)initWithModel:(BallAnimationModel *)model
{
    self = [super init];
    if (self) {
        _model = model;
        self.frame = CGRectMake(0, 0, 370, 667);
        [self addSublayer:self.ball];
        [self addShowAnimationGroup];
    }
    return self;
}

#pragma mark Private
- (void)addShowAnimationGroup
{
    CAAnimationGroup *group = [CAAnimationGroup animation];
    CAKeyframeAnimation *showOpacityAnimation = [self opacityAnimationFrom:0.0 to:0.5 duration:0.6];
    CABasicAnimation *showSizeAnimation = [self sizeAnimationFrom:_model.originalRadius to:_model.tempRadius originScale:1 duration:0.6];
    CAKeyframeAnimation *showPositionAnimation = [self positionShowAnimationWithStep:1 duration:0.8 ifEaseOut:NO];
    group.animations = @[showOpacityAnimation,showSizeAnimation,showPositionAnimation];
}

- (void)addRandomPositionAnimation
{
    for (int i = 0; i < 4; i ++) {
        CABasicAnimation *microPositionAni = [CABasicAnimation animationWithKeyPath:@"position"];
        microPositionAni.toValue = [NSValue valueWithCGPoint:CGPointMake(_model.tempPoint.x + [self randomPositionValue], _model.tempPoint.y + [self randomPositionValue])];
        if (i == 3) {
            microPositionAni.toValue = [NSValue valueWithCGPoint:CGPointMake(_model.tempPoint.x, _model.tempPoint.y)];
        }
        microPositionAni.duration = 0.55;
        microPositionAni.beginTime = CACurrentMediaTime() + i*0.55;
        microPositionAni.delegate = self;
        microPositionAni.removedOnCompletion = NO;
        microPositionAni.fillMode = kCAFillModeForwards;
        microPositionAni.autoreverses = NO;
        NSString *key = (i==3)? RANDOMPOSITION:nil;
        [self.ball addAnimation:microPositionAni forKey:key];
    }
}

- (void)addHideAnimationGroup
{
    CAAnimationGroup *group = [CAAnimationGroup animation];
    CAKeyframeAnimation *hideOpacityAnimation = [self opacityAnimationFrom:0.5 to:0.0 duration:0.6];
    CABasicAnimation *hideSizeAnimation = [self sizeAnimationFrom:_model.tempRadius to:_model.finalRadius originScale:_model.tempRadius/_model.originalRadius duration:0.6];
    CAKeyframeAnimation *hidePositionAnimation = [self positionShowAnimationWithStep:2 duration:0.6 ifEaseOut:YES];
    group.animations = @[hideOpacityAnimation,hideSizeAnimation,hidePositionAnimation];
}

///随机生成-2 ~ 2的小数
- (CGFloat)randomPositionValue
{
    return ((arc4random() % 100)/100.0 - 0.5) * 5;
}

#pragma mark CAAnimtionDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    if (anim == [self.ball animationForKey:SHOWPOSITION]) {
        [self addRandomPositionAnimation];
    }else if (anim == [self.ball animationForKey:RANDOMPOSITION]) {
        [self addHideAnimationGroup];
    }else if (anim == [self.ball animationForKey:HIDEPOSITION]) {
        
    }
    
    [CATransaction commit];
}

#pragma mark UIBeizerPath Methods
- (UIBezierPath *)pathWithModel:(BallAnimationModel *)model step:(NSInteger)step
{
    //两点中点
    UIBezierPath *path = [[UIBezierPath alloc]init];
    CGFloat x,y,k,cor,dis;
    if (step == 1) {
        CGPoint midPoint = CGPointMake(model.originalPoint.x + (model.tempPoint.x -  model.originalPoint.x)/2, model.tempPoint.y + (model.originalPoint.y - model.tempPoint.y)/2);
        //斜率
        k = (model.originalPoint.y - model.tempPoint.y)/(model.tempPoint.x - model.originalPoint.x);
        //两点距离的一半
        dis = sqrt(pow((model.originalPoint.y - model.tempPoint.y), 2) + pow((model.tempPoint.x - model.originalPoint.x), 2))/2;
        cor = atan(k)/M_PI*180;
        x = midPoint.x + model.showControlOffset * dis * cosx(cor);
        y = midPoint.y + model.showControlOffset * dis * sinx(cor);
        [path moveToPoint:model.originalPoint];
        [path addQuadCurveToPoint:model.tempPoint controlPoint:CGPointMake(x, y)];
    }else if (step ==2) {
        CGPoint midPoint = CGPointMake(model.tempPoint.x + (model.finalPoint.x -  model.tempPoint.x)/2, model.finalPoint.y + (model.tempPoint.y - model.finalPoint.y)/2);
        k = (model.finalPoint.y - model.tempPoint.y)/(model.tempPoint.x - model.finalPoint.x);
        dis = sqrt(pow((model.finalPoint.y - model.tempPoint.y), 2) + pow((model.tempPoint.x - model.finalPoint.x), 2))/2;
        cor = atan(k)/M_PI*180;
        x = midPoint.x + model.hideControlOffset * dis * cosx(cor);
        y = midPoint.y + model.hideControlOffset * dis * sinx(cor);
        [path moveToPoint:model.tempPoint];
        [path addQuadCurveToPoint:model.finalPoint controlPoint:CGPointMake(x, y)];
    }
    
    return path;
}

#pragma mark Animations
///透明度
- (CAKeyframeAnimation *)opacityAnimationFrom:(CGFloat)fromValue to:(CGFloat)toValue duration:(CGFloat)duration
{
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.values = @[@(fromValue),@(fromValue),@(toValue),@(toValue)];
    opacityAnimation.keyTimes = @[@(0.0),@(0.2),@(0.7),@(1.0)];
    opacityAnimation.duration = duration;
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    opacityAnimation.delegate = self;
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.autoreverses = NO;
    [opacityAnimation setValue:SHOWFADE forKey:SHOWFADE];
    [self.ball addAnimation:opacityAnimation forKey:SHOWFADE];
    return opacityAnimation;
}

///大小
- (CABasicAnimation *)sizeAnimationFrom:(CGFloat)fromValue to:(CGFloat)toValue originScale:(CGFloat)originScale duration:(CGFloat)duration
{
    CABasicAnimation *sizeAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    sizeAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(originScale, originScale, 0)];
    CGFloat scale = toValue/fromValue;
    sizeAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 0)];
    sizeAnimation.duration = duration;
    sizeAnimation.delegate = self;
    sizeAnimation.removedOnCompletion = NO;
    sizeAnimation.autoreverses = NO;
    sizeAnimation.fillMode = kCAFillModeForwards;
    [sizeAnimation setValue:SHOWSCALE forKey:SHOWSCALE];
    [self.ball addAnimation:sizeAnimation forKey:SHOWSCALE];
    return sizeAnimation;
}

///位置
- (CAKeyframeAnimation *)positionShowAnimationWithStep:(NSInteger)step duration:(CGFloat)duration ifEaseOut:(BOOL)isEaseOut
{
    CAKeyframeAnimation *positionShowAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path = [self pathWithModel:_model step:step];
    positionShowAnimation.path = CGPathCreateCopy(path.CGPath);
    positionShowAnimation.duration = duration;
    if (isEaseOut) {
        positionShowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    }else{
        positionShowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    }
    positionShowAnimation.delegate = self;
    positionShowAnimation.autoreverses = NO;
    positionShowAnimation.removedOnCompletion = NO;
    positionShowAnimation.fillMode = kCAFillModeForwards;
    NSString *key = (step==1)? SHOWPOSITION:HIDEPOSITION;
    [positionShowAnimation setValue:key forKey:key];
    [self.ball addAnimation:positionShowAnimation forKey:key];
    return positionShowAnimation;
}

#pragma mark Get
- (CALayer *)ball
{
    if (!_ball) {
        _ball = [[CAGradientLayer alloc]init];
        _ball.bounds = CGRectMake(0, 0, _model.originalRadius*2, _model.originalRadius*2);
        _ball.cornerRadius = _model.originalRadius;
        _ball.colors = @[(__bridge id)rgba(250, 120, 50, 1.0).CGColor,(__bridge id)rgba(235, 68, 56, 1.0).CGColor];
        _ball.locations = @[@0.0, @1.0];
        _ball.startPoint = CGPointMake(0, 0);
        _ball.endPoint = CGPointMake(1.0, 0);
    }
    return _ball;
}

@end
