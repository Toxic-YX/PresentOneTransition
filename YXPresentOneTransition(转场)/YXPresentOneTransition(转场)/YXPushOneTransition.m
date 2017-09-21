//
//  YXPushOneTransition.m
//  YXPresentOneTransition(转场)
//
//  Created by Rookie_YX on 16/7/12.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//

#import "YXPushOneTransition.h"
#import "PushFirstViewController.h"
#import "PushSecondViewController.h"

@interface YXPushOneTransition()
@property(nonatomic, assign) YXPushOneTransitionType type;
@end
@implementation YXPushOneTransition

+ (instancetype)transitionPushWithTransitionType:(YXPushOneTransitionType)type{
  
  return [[self alloc] initWithPushTransitionType:type];
}

- (instancetype)initWithPushTransitionType:(YXPushOneTransitionType)type{
  
  self = [self init];
  if (self) {
    _type = type;
  }
  return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
  
  switch (_type) {
    case YXPushOneTransitionTypePush:
      [self doPushAnimation:transitionContext];
      break;
     case YXPushOneTransitionTypePop:
      [self doPopAnimation:transitionContext];
  }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
  
  return 0.1;
}

//Push动画逻辑
- (void)doPushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
  
  PushFirstViewController *fromVC = (PushFirstViewController *)[transitionContext     viewControllerForKey:UITransitionContextFromViewControllerKey];
  PushSecondViewController *toVC = (PushSecondViewController *)[transitionContext     viewControllerForKey:UITransitionContextToViewControllerKey];
  //拿到当前点击的cell的imageView
  PushFirstTableViewCell *cell = (PushFirstTableViewCell *)[fromVC.tableView cellForRowAtIndexPath:fromVC.currentIndexPath];
  UIView *containerView = [transitionContext containerView];
  containerView.backgroundColor = [UIColor orangeColor];
  //snapshotViewAfterScreenUpdates 对cell的imageView截图保存成另一个视图用于过渡，并将视图转换到当前控制器的坐标
  UIView *tempView = [cell.imageView snapshotViewAfterScreenUpdates:NO];
  tempView.frame = [cell.imageView convertRect:cell.imageView.bounds toView: containerView];
  //设置动画前的各个控件的状态
  cell.imageView.hidden = YES;
  toVC.view.alpha = 0;
  toVC.imagView.hidden = YES;
  //tempView 添加到containerView中，要保证在最前方，所以后添加
  [containerView addSubview:toVC.view];
  [containerView addSubview:tempView];
  //开始做动画
  [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.5    initialSpringVelocity:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
    
       tempView.frame = [toVC.imagView convertRect:toVC.imagView.bounds toView:containerView];
    toVC.view.alpha = 1;
  } completion:^(BOOL finished) {
    // tempView先隐藏不销毁，pop的时候还会用
    tempView.hidden = YES;
    toVC.imagView.hidden = NO;
    [UIView animateWithDuration:DURATION animations:^{
      [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
      [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:toVC.view cache:YES];
    }];
    [transitionContext completeTransition:YES];
  }];
}

//Pop动画逻辑
- (void)doPopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
  
  PushSecondViewController *fromVC = (PushSecondViewController *)[transitionContext     viewControllerForKey:UITransitionContextFromViewControllerKey];
  PushFirstViewController *toVC = (PushFirstViewController *)[transitionContext     viewControllerForKey:UITransitionContextToViewControllerKey];
  PushFirstTableViewCell *cell = (PushFirstTableViewCell *)[toVC.tableView cellForRowAtIndexPath:toVC.currentIndexPath];
  UIView *containerView = [transitionContext containerView];
  //这里的lastView就是push时候初始化的那个tempView
  UIView *tempView = containerView.subviews.lastObject;
  //设置初始状态
  cell.imageView.hidden = YES;
  fromVC.imagView.hidden = YES;
  tempView.hidden = NO;
  [containerView insertSubview:toVC.view atIndex:0];
  
  [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:1.0     initialSpringVelocity:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
    tempView.frame = [cell.imageView convertRect:cell.imageView.bounds toView:containerView];
    fromVC.view.alpha = 0;
  } completion:^(BOOL finished) {
    
    [UIView animateWithDuration:DURATION animations:^{
      [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
      [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:toVC.view cache:YES];
    }];
    //由于加入了手势必须判断
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    if ([transitionContext transitionWasCancelled]) {//手势取消了，原来隐藏的imageView要显示出来
      //失败了隐藏tempView，显示fromVC.imageView
      tempView.hidden = YES;
      fromVC.imagView.hidden = NO;
    }else{//手势成功，cell的imageView也要显示出来
      //成功了移除tempView，下一次pop的时候又要创建，然后显示cell的imageView
      cell.imageView.hidden = NO;
      [tempView removeFromSuperview];
    }
  }];
}

@end
