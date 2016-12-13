//
//  UIView+NYNavigation.m
//  NYNavigationViewDemo
//
//  Created by 牛严 on 2016/12/13.
//  Copyright © 2016年 牛严. All rights reserved.
//

#import "UIView+NYNavigation.h"
#import <objc/runtime.h>

@implementation UIView (NYNavigation)

static const char NYNavigationKey = '\0';


- (void)setNy_naviagationView:(NYNavigationView *)ny_naviagationView
{
    objc_setAssociatedObject(self, &NYNavigationKey, ny_naviagationView, OBJC_ASSOCIATION_ASSIGN);
}

- (NYNavigationView *)ny_naviagationView
{
    NYNavigationView *view = objc_getAssociatedObject(self,&NYNavigationKey);
    return view;
}

@end
