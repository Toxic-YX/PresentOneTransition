//
//  转场动画笔记.m
//  YXPresentOneTransition(转场)
//
//  Created by Rookie_YX on 16/7/11.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//  关注我的博客: http://www.jianshu.com/users/480a52903ce5

/**
 
 实现自定义转场的步骤做个总结：
 第一步: 需要自定义一个遵循的<UIViewControllerAnimatedTransitioning>协议的动画过渡管理对象，并实现两个必须实现的方法：
 ① //返回动画事件
    - (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext;
 
 ② //所有的过渡动画事务都在这个方法里面完成
    - (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext;
 
 第二步: 需要自定义一个继承于UIPercentDrivenInteractiveTransition的手势过渡管理对象，我把它成为百分比手势过渡管理对象，因为动画的过程是通过百分比控制的
 
 第三步: 成为相应的代理，实现相应的代理方法,并返回前两步自定义的对象即可 .
    
 //  增加点: ------------------------------------------------
     模态推送需要实现如下4个代理方法:
 ① //返回一个管理prenent动画过渡的对象
    - (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source;
 ② //返回一个管理pop动画过渡的对象
    - (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed;
 ③  //返回一个管理prenent手势过渡的对象
     - (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator;
 ④  //返回一个管理pop动画过渡的对象
     - (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator;
 
     导航控制器实现如下2个代理方法:
 ① //返回转场动画过渡管理对象
     - (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
       interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController NS_AVAILABLE_IOS(7_0);
 ②   //返回手势过渡管理对象
     - (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
       animationControllerForOperation:(UINavigationControllerOperation)operation
       fromViewController:(UIViewController *)fromVC
       toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0);
     
    
     tabBar控制器也有相应的两个方法
 ①   //返回转场动画过渡管理对象
     - (nullable id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
     interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController NS_AVAILABLE_IOS(7_0);
 ②  //返回手势过渡管理对象
    - (nullable id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
    animationControllerForTransitionFromViewController:(UIViewController *)fromVC
    toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0);
 
 
总结 : 自定义转场都只需要这3个步骤,如果不需要手势控制，步骤2还可以取消

 */
