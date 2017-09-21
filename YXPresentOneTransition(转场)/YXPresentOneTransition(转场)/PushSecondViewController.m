//
//  PushSecondViewController.m
//  YXPresentOneTransition(转场)
//
//  Created by Rookie_YX on 16/7/11.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//

#import "PushSecondViewController.h"

@interface PushSecondViewController ()
@property(nonatomic, strong) UILabel * lable;
@end

@implementation PushSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.title = @"Push";
  self.view.backgroundColor = [UIColor clearColor];
  [self.view addSubview:self.imagView];
  [self.view addSubview:self.lable];
  
  // 布局
  __weak typeof(self) wSelf = self;
  [self.lable mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(wSelf.imagView.mas_bottom).offset(10);
    make.left.equalTo(wSelf.imagView.mas_left);
    make.size.mas_equalTo(CGSizeMake(wSelf.imagView.frame.size.width, 100));
  }];
}

#pragma mark -  UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
  
  // 分pop和push两种情况分别返回动画过渡代理相应不同的动画操作
  return [YXPushOneTransition transitionPushWithTransitionType:operation == UINavigationControllerOperationPush ? YXPushOneTransitionTypePush : YXPushOneTransitionTypePop];
}

#pragma mark -  懒加载
- (UIImageView *)imagView{
  
  if (!_imagView) {
    _imagView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width / 2, self.view.frame.size.height / 2)];
    _imagView.center = self.view.center;
    _imagView.backgroundColor = [UIColor cyanColor];
    if (self.imageName == nil) {
      _imagView.image = [UIImage imageNamed:@"1"];  // 默认图片
    }
    _imagView.image = [UIImage imageNamed:self.imageName];
  }
  return _imagView;
}

- (UILabel *)lable{
  
  if (!_lable) {
    _lable = [[UILabel alloc]init];
    _lable.text = @"放眼望去你发现景色是那么美丽!";
    _lable.textColor = [UIColor cyanColor];
    _lable.numberOfLines = 0;
    _lable.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
  }
  return _lable;
}


@end
