//
//  YXPresentOneTransition.m
//  YXPresentOneTransition(转场)
//
//  Created by Rookie_YX on 16/7/11.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//

#import "YXPresentOneTransition.h"

@interface YXPresentOneTransition()

/**手势类型*/
@property (nonatomic, assign) YXPresentOneTransitionType type;

@end

@implementation YXPresentOneTransition
+ (instancetype)transitionWithTransitionType:(YXPresentOneTransitionType)type{
  return [[self alloc]initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(YXPresentOneTransitionType)type{
  self = [self init];
  if (self) {
    _type = type;
  }
  return self;
}
#pragma mark - UIViewControllerAnimatedTransitioning
// 动画执行所需要的时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
  return 0.5;
}

// 处理自定动画效果方法
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
  
  // 两种动画的逻辑
  switch (_type) {
    case YXPresentOneTransitionTypePresent:
      [self presentAnimation:transitionContext];
      break;
    case YXPresentOneTransitionTypeDismiss:
      [self dismissAnimation:transitionContext];
      break;
  }
}

#pragma mark - 自定义函数
//实现present动画逻辑代码
- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
  
  // 通过viewControllerForKey取出转场前后的两个控制器，这里toVC就是firstVC、fromVC就是secondVC
  UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  // snapshotViewAfterScreenUpdates可以对某个视图截图
  UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
  tempView.frame = fromVC.view.frame;
  // 因为对截图做动画，firstVC就可以隐藏了
  fromVC.view.hidden = YES;
  // 这里有个重要的概念containerView,来管理转场动画作用
  UIView *containerView = [transitionContext containerView];
  // 设置一下背景色
  containerView.backgroundColor = [UIColor cyanColor];
  [containerView addSubview:tempView];
  [containerView addSubview:toVC.view];
  //设置secondVC的frame
  toVC.view.frame = CGRectMake(0, containerView.height, containerView.width, 400);
  
  //开始动画吧，弹簧效果的动画
  [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0 / 0.55 options:0 animations:^{
    //首先我们让secondVC向上移动
    toVC.view.transform = CGAffineTransformMakeTranslation(0, -400);
    //然后让截图视图缩小一点即可
    tempView.transform = CGAffineTransformMakeScale(0.85, 0.85);
  } completion:^(BOOL finished) {
    //使用如下代码标记整个转场过程是否正常完成[transitionContext transitionWasCancelled]代表手势是否取消了，如果取消了就传NO表示转场失败，反之亦然，如果不用手势present的话直接传YES也是可以的，但是无论如何我们都必须标记转场的状态，系统才知道处理转场后的操作，否者认为你一直还在转场中，会出现无法交互的情况
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    //转场失败后的处理
    if ([transitionContext transitionWasCancelled]) {
      //失败后，我们要把firstVC显示出来
      fromVC.view.hidden = NO;
      //然后移除截图视图，因为下次触发present会重新截图
      [tempView removeFromSuperview];
    }
  }];
}

//实现dismiss动画逻辑代码
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
  //注意在dismiss的时候fromVC就是secondVC了，toVC才是firstVC
  UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  //参照present动画的逻辑，present成功后，containerView的最后一个子视图就是截图视图，我们将其取出准备动画
  UIView *containerView = [transitionContext containerView];
  NSArray *subviewsArray = containerView.subviews;
  UIView *tempView = subviewsArray[MIN(subviewsArray.count, MAX(0, subviewsArray.count - 2))];
  
  //动画开始
  [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
    //因为present的时候都是使用的transform，这里的动画只需要将transform恢复就可以了
    fromVC.view.transform = CGAffineTransformIdentity;
    tempView.transform = CGAffineTransformIdentity;
  } completion:^(BOOL finished) {
    if ([transitionContext transitionWasCancelled]) {
      //失败
      [transitionContext completeTransition:NO];
    }else{
      //如果成功,firstVC显示出来,移除截图视图，
      [transitionContext completeTransition:YES];
      toVC.view.hidden = NO;
      [tempView removeFromSuperview];
    }
  }];

}


@end
