//
//  DotSpreadTransition.h
//  YXPresentOneTransition(转场)
//
//  Created by Rookie_YX on 16/7/12.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YXDotSpreadTransitionType) {
  YXDotSpreadTransitionTypePresent = 0,
  YXDotSpreadTransitionTypeDismiss
};

@interface DotSpreadTransition : NSObject<UIViewControllerAnimatedTransitioning>
@property(nonatomic, assign) YXDotSpreadTransitionType type;

+ (instancetype)transitionDotSpreadWithTransitionType:(YXDotSpreadTransitionType)type;
- (instancetype)initDotSpreadWithTransitionType:(YXDotSpreadTransitionType)type;
@end
