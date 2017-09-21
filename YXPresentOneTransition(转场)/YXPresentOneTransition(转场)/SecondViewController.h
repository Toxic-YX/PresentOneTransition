//
//  SecondViewController.h
//  YXPresentOneTransition(转场)
//
//  Created by Rookie_YX on 16/7/11.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SecondViewControllerDelegate <NSObject>

- (void)SecondControllerPressedDissmiss;

@end
@interface SecondViewController : UIViewController
@property(nonatomic, assign) id<SecondViewControllerDelegate> delegate;
@end
