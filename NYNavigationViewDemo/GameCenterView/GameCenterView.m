//
//  GameCenterView.m
//  GameCenterAnimation
//
//  Created by 牛严 on 2016/12/8.
//  Copyright © 2016年 牛严. All rights reserved.
//

#import "GameCenterView.h"
#import "BallAnimationLayer.h"
#import "BallAnimationModel.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)

@interface GameCenterView ()<CAAnimationDelegate>

@end

@implementation GameCenterView
{
    NSMutableArray *_layers;
    CALayer *_logoLayer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    CGRect tempframe = CGRectMake(0, 150, 375, 500);
    self = [super initWithFrame:tempframe];
    if (self) {
        self.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        NSLog(@"-----%f",self.center.y);
        if (frame.size.width < 375) {
            CGFloat scale = frame.size.width/375;
            self.transform = CGAffineTransformScale(self.transform, scale, scale);
        }else if (frame.size.width > 375) {
            self.transform = CGAffineTransformScale(self.transform, 1.2, 1.2);
        }
        
    }
    return self;
}

- (void)startAnimation
{
    [self addBalls];
    [self addLogo];
}

- (void)stopAnimation
{
    [self removeElements];
}

- (void)addBalls
{
    BallAnimationModel *model1 = [BallAnimationModel new];
    model1.originalPoint = CGPointMake(-90, 450);
    model1.originalRadius = 24.0;
    model1.tempPoint = CGPointMake(145, 203);
    model1.tempRadius = 35.0;
    model1.finalPoint = CGPointMake(60, 0);
    model1.finalRadius = 60.0;
    model1.showControlOffset = 0.4;
    model1.hideControlOffset = - 0.4;
    BallAnimationLayer *layer1 = [[BallAnimationLayer alloc]initWithModel:model1];
    [self.layer addSublayer:layer1];
    
    BallAnimationModel *model2 = [BallAnimationModel new];
    model2.originalPoint = CGPointMake(-90, 557);
    model2.originalRadius = 60.0;
    model2.tempPoint = CGPointMake(170, 270);
    model2.tempRadius = 100.0;
    model2.finalPoint = CGPointMake(120, -120);
    model2.finalRadius = 300.0;
    model2.showControlOffset = 0.6;
    model2.hideControlOffset = - 0.2;
    BallAnimationLayer *layer2 = [[BallAnimationLayer alloc]initWithModel:model2];
    [self.layer addSublayer:layer2];
    
    BallAnimationModel *model3 = [BallAnimationModel new];
    model3.originalPoint = CGPointMake(-30, 617);
    model3.originalRadius = 12.0;
    model3.tempPoint = CGPointMake(105, 330);
    model3.tempRadius = 20.0;
    model3.finalPoint = CGPointMake(0, 0);
    model3.finalRadius = 60.0;
    model3.showControlOffset = 0.4;
    model3.hideControlOffset = -0.3;
    BallAnimationLayer *layer3 = [[BallAnimationLayer alloc]initWithModel:model3];
    [self.layer addSublayer:layer3];
    
    BallAnimationModel *model4 = [BallAnimationModel new];
    model4.originalPoint = CGPointMake(-30, 727);
    model4.originalRadius = 60.0;
    model4.tempPoint = CGPointMake(185, 295);
    model4.tempRadius = 100.0;
    model4.finalPoint = CGPointMake(270, -100);
    model4.finalRadius = 300.0;
    model4.showControlOffset = 0.4;
    model4.hideControlOffset = 0.3;
    BallAnimationLayer *layer4 = [[BallAnimationLayer alloc]initWithModel:model4];
    [self.layer addSublayer:layer4];
    
    BallAnimationModel *model5 = [BallAnimationModel new];
    model5.originalPoint = CGPointMake(265, 727);
    model5.originalRadius = 60.0;
    model5.tempPoint = CGPointMake(185, 280);
    model5.tempRadius = 100.0;
    model5.finalPoint = CGPointMake(270, -100);
    model5.finalRadius = 300.0;
    model5.showControlOffset = -0.3;
    model5.hideControlOffset = 0.3;
    BallAnimationLayer *layer5 = [[BallAnimationLayer alloc]initWithModel:model5];
    [self.layer addSublayer:layer5];
    
    BallAnimationModel *model6 = [BallAnimationModel new];
    model6.originalPoint = CGPointMake(435, 657);
    model6.originalRadius = 60.0;
    model6.tempPoint = CGPointMake(200, 290);
    model6.tempRadius = 100.0;
    model6.finalPoint = CGPointMake(330, -120);
    model6.finalRadius = 300.0;
    model6.showControlOffset = -0.6;
    model6.hideControlOffset = 0.3;
    BallAnimationLayer *layer6 = [[BallAnimationLayer alloc]initWithModel:model6];
    [self.layer addSublayer:layer6];
    
    BallAnimationModel *model7 = [BallAnimationModel new];
    model7.originalPoint = CGPointMake(412, 580);
    model7.originalRadius = 27.0;
    model7.tempPoint = CGPointMake(240, 357);
    model7.tempRadius = 45.0;
    model7.finalPoint = CGPointMake(375, 0);
    model7.finalRadius = 135.0;
    model7.showControlOffset = -0.7;
    model7.hideControlOffset = 0.3;
    BallAnimationLayer *layer7 = [[BallAnimationLayer alloc]initWithModel:model7];
    [self.layer addSublayer:layer7];
    
    _layers = [[NSMutableArray alloc]initWithObjects:layer1,layer2,layer3,layer4,layer5,layer6,layer7, nil];
    
}

- (void)addLogo
{
    _logoLayer = [CALayer layer];
    _logoLayer.frame = CGRectMake((370-140)/2, 292-24, 140, 42);
    _logoLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"LOGO"].CGImage);
    _logoLayer.opacity = 0;
    CAAnimationGroup *group = [CAAnimationGroup animation];
    CABasicAnimation *showAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    showAnimation.toValue = @(1);
    showAnimation.beginTime = CACurrentMediaTime() + 0.6;
    showAnimation.duration = 0.4;
    showAnimation.removedOnCompletion = NO;
    showAnimation.fillMode = kCAFillModeForwards;
    showAnimation.autoreverses = NO;
    [_logoLayer addAnimation:showAnimation forKey:nil];
    CABasicAnimation *hideAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    hideAnimation.toValue = @(0);
    hideAnimation.beginTime = CACurrentMediaTime() + 2.8;
    hideAnimation.duration = 0.4;
    hideAnimation.removedOnCompletion = NO;
    hideAnimation.fillMode = kCAFillModeForwards;
    hideAnimation.autoreverses = NO;
    hideAnimation.delegate = self;
    [_logoLayer addAnimation:hideAnimation forKey:@"hide"];
    group.animations = @[showAnimation,hideAnimation];
    [_layers addObject:_logoLayer];
    [self.layer addSublayer:_logoLayer];
}

- (void)removeElements
{
    for (CALayer *layer in _layers){
        [layer removeAllAnimations];
        [layer removeFromSuperlayer];
    }
}

#pragma mark CAAnimation Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == [_logoLayer animationForKey:@"hide"]) {
        [_logoLayer removeAllAnimations];
        [_logoLayer removeFromSuperlayer];
    }
}

@end
