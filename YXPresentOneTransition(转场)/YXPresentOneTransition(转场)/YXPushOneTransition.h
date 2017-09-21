//
//  YXPushOneTransition.h
//  YXPresentOneTransition(转场)
//
//  Created by Rookie_YX on 16/7/12.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 管理present和dismiss2个动画枚举
typedef NS_ENUM(NSUInteger, YXPushOneTransitionType){
  YXPushOneTransitionTypePush = 0,//管理push动画
  YXPushOneTransitionTypePop//管理pop动画
};

@interface YXPushOneTransition : NSObject<UIViewControllerAnimatedTransitioning>


///根据定义的枚举初始化的两个方法

/**
 *  转场动画管理类型 - 类方法
 *
 *  @param type 类型
 *
 */
+ (instancetype)transitionPushWithTransitionType:(YXPushOneTransitionType)type;

/**
 *  转场动画管理类型 - 对象方法
 *
 *  @param type 类型
 *
 */
- (instancetype)initWithPushTransitionType:(YXPushOneTransitionType)type;
@end
