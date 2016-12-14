//
//  BallAnimationLayer.h
//  GameCenterAnimation
//
//  Created by 牛严 on 2016/12/8.
//  Copyright © 2016年 牛严. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

#import "BallAnimationModel.h"

@interface BallAnimationLayer : CALayer

- (instancetype)initWithModel:(BallAnimationModel *)model;

@end
