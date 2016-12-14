//
//  BallAnimationModel.h
//  GameCenterAnimation
//
//  Created by 牛严 on 2016/12/8.
//  Copyright © 2016年 牛严. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BallAnimationModel : NSObject

@property (nonatomic, assign) CGPoint originalPoint;
@property (nonatomic, assign) CGPoint tempPoint;
@property (nonatomic, assign) CGPoint finalPoint;

@property (nonatomic, assign) CGFloat originalRadius;
@property (nonatomic, assign) CGFloat tempRadius;
@property (nonatomic, assign) CGFloat finalRadius;

///-1-0-1，0在两点中点，-1在左边，1在右边，等腰直角三角形的直角点
@property (nonatomic, assign) CGFloat showControlOffset;
@property (nonatomic, assign) CGFloat hideControlOffset;

@end
