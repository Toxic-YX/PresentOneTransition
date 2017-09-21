//
//  FirstViewController.m
//  YXPresentOneTransition(转场)
//
//  Created by Rookie_YX on 16/7/11.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//  present控制器

#import "FirstViewController.h"
#import "SecondViewController.h"


@interface FirstViewController ()<SecondViewControllerDelegate>

@property(nonatomic, strong) UIImageView * imgView;
@property(nonatomic, strong) UIButton * btn;
@end

@implementation FirstViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  self.title = @"present";
  self.view.backgroundColor = [UIColor whiteColor];
  // UI
  [self setupUI];
}

- (void)setupUI{
  
  [self.view addSubview:self.imgView];
  [self.view addSubview:self.btn];
  
  // 布局
  __weak typeof(self) wSelf = self;
  [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(wSelf.view.mas_centerX);
    make.top.mas_equalTo(wSelf.view.mas_top).offset(64);
    make.size.mas_equalTo(CGSizeMake(300, 300));
  }];
  [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(wSelf.view.mas_centerX);
    make.top.mas_equalTo(wSelf.imgView.mas_bottom).offset(10);
  }];
}

- (void)present{
  NSLog(@"%s",__func__);
  SecondViewController * secondeVC = [SecondViewController new];
  secondeVC.delegate = self;
  self.navigationController.navigationBarHidden = YES;
  [self presentViewController:secondeVC animated:YES completion:nil];
}

#pragma mark - SecondViewControllerDelegate
- (void)SecondControllerPressedDissmiss{
  self.navigationController.navigationBarHidden = NO;
  [self dismissViewControllerAnimated:YES completion:nil];
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
    [_btn setTitle:@"点击我" forState:(UIControlStateNormal)];
    _btn.backgroundColor = [UIColor lightGrayColor];
    _btn.layer.masksToBounds = YES;
    _btn.layer.cornerRadius = 5;
    [_btn addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
  }
  return _btn;
}
@end
