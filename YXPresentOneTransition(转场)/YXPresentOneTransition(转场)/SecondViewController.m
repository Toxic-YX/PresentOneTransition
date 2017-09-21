//
//  SecondViewController.m
//  YXPresentOneTransition(转场)
//
//  Created by Rookie_YX on 16/7/11.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//  被present控制器

#import "SecondViewController.h"
#import "YXPresentOneTransition.h"

@interface SecondViewController ()<UIViewControllerTransitioningDelegate>
@property(nonatomic, strong) UIImageView * imgView;
@property(nonatomic, strong) UIButton * btn;
@end

@implementation SecondViewController

- (instancetype)init
{
  self = [super init];
  if (self) {
    
    self.transitioningDelegate = self;
    // 界面弹出效果
    self.modalPresentationStyle = UIModalPresentationCustom;
  }
  return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   self.view.backgroundColor = [UIColor greenColor];
  [self setupUI];
}

- (void)setupUI{
  [self.view addSubview:self.imgView];
  [self.view addSubview:self.btn];
  
  // 布局
  __weak typeof(self) wSelf = self;
  [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(wSelf.view.mas_centerX);
    make.top.mas_equalTo(wSelf.view.mas_top).offset(0);
    make.size.mas_equalTo(CGSizeMake(100, 100));
  }];
  [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(wSelf.view.mas_centerX);
    make.top.mas_equalTo(wSelf.imgView.mas_bottom).offset(10);
  }];

}

#pragma mark -自定义
- (void)dismiss{
  NSLog(@"%s",__func__);
  if (_delegate &&[_delegate respondsToSelector:@selector(SecondControllerPressedDissmiss)]) {
    [_delegate SecondControllerPressedDissmiss];
  }
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
  // 这里我们初始化dimissType
  return [YXPresentOneTransition transitionWithTransitionType:YXPresentOneTransitionTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
  // 这里我们初始化dimissType
  return [YXPresentOneTransition transitionWithTransitionType:  YXPresentOneTransitionTypeDismiss];
}

#pragma mark - 懒加载
- (UIImageView *)imgView{
  if (!_imgView) {
    _imgView = [[UIImageView alloc]init];
    _imgView.image = [UIImage imageNamed:@"1"];
    _imgView.layer.cornerRadius = 8;
    _imgView.layer.masksToBounds = YES;
    _imgView.backgroundColor = [UIColor greenColor];
  }
  return _imgView;
}

- (UIButton *)btn{
  if (!_btn) {
    _btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_btn setTitle:@"返回" forState:(UIControlStateNormal)];
    _btn.backgroundColor = [UIColor lightGrayColor];
    _btn.layer.masksToBounds = YES;
    _btn.layer.cornerRadius = 5;
    [_btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
  }
  return _btn;
}

@end
