//
//  DotSpreadSecondViewController.m
//  YXPresentOneTransition(转场)
//
//  Created by Rookie_YX on 16/7/12.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//

#import "DotSpreadSecondViewController.h"
#import "DotSpreadTransition.h"

@interface DotSpreadSecondViewController ()<UIViewControllerTransitioningDelegate>
@property(nonatomic, strong) UIButton * btn;
@property(nonatomic, strong) UIImageView * imgView;
@end

@implementation DotSpreadSecondViewController

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
  }
  return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   self.view.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:self.imgView];
  [self.view addSubview:self.btn];
}

- (void)dissmis{
   [self dismissViewControllerAnimated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
  return [DotSpreadTransition transitionDotSpreadWithTransitionType:YXDotSpreadTransitionTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
  return [DotSpreadTransition transitionDotSpreadWithTransitionType:YXDotSpreadTransitionTypeDismiss];
}

#pragma mark -  懒加载

- (UIButton *)btn{
  
  if (!_btn) {
    _btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _btn.frame = CGRectMake(0, 100,self.view.frame.size.width, 30);
    [_btn setTitle:@"点击我返回" forState:(UIControlStateNormal)];
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(dissmis) forControlEvents:UIControlEventTouchUpInside];
    _btn.backgroundColor = [UIColor cyanColor];
    
  }
  return _btn;
}

- (UIImageView *)imgView{
  
  if (!_imgView) {
    _imgView = [[UIImageView alloc]init];
    _imgView.frame = self.view.bounds;
    _imgView.image = [UIImage imageNamed:@"pic2.jpeg"];
  }
  return _imgView;
}


@end
