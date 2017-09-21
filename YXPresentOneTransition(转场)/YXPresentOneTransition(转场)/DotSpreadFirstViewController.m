//
//  DotSpreadFirstViewController.m
//  YXPresentOneTransition(转场)
//
//  Created by Rookie_YX on 16/7/12.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//

#import "DotSpreadFirstViewController.h"
#import "DotSpreadSecondViewController.h"

@interface DotSpreadFirstViewController ()
@property(nonatomic, strong) UIButton * btn;
@property(nonatomic, strong) UIImageView * imgView;
@end

@implementation DotSpreadFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.title = @"DotSpread";
  self.view.backgroundColor = [UIColor whiteColor];
  
  [self.view addSubview:self.imgView];
  [self.view addSubview:self.btn];
  UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
  [self.btn addGestureRecognizer:pan];
  // 布局
  __weak typeof(self) wSelf = self;
  [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.mas_equalTo(CGPointMake(0, 0)).priorityLow();
    make.size.mas_equalTo(CGSizeMake(60,60));
    make.left.greaterThanOrEqualTo(wSelf.view);
    make.top.greaterThanOrEqualTo(wSelf.view).offset(64);
    make.bottom.right.lessThanOrEqualTo(wSelf.view);

  }];
}

- (void)present{
  DotSpreadSecondViewController *presentVC = [DotSpreadSecondViewController new];
  [self presentViewController:presentVC animated:YES completion:nil];
}

- (void)pan:(UIPanGestureRecognizer *)sender{
  NSLog(@"%s",__func__);
  UIView * btnView = sender.view;
  CGFloat x = [sender translationInView:sender.view].x + btnView.center.x - [UIScreen mainScreen].bounds.size.width / 2;
  CGFloat y = [sender translationInView:sender.view].y + btnView.center.y - [UIScreen mainScreen].bounds.size.height / 2;
  NSLog(@"%f,%f",x,y);
  CGPoint newCenter = CGPointMake(x, y);
  // 更新布局
  [self.btn mas_updateConstraints:^(MASConstraintMaker *make) {
    make.center.mas_equalTo(newCenter).priorityLow();
  }];
  [sender setTranslation:CGPointZero inView:sender.view];
}


#pragma mark -  懒加载
- (CGRect)buttonFrame{
  return self.btn.frame;
}
- (UIButton *)btn{
  
  if (!_btn) {
    _btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_btn setTitle:@"点击或拖动我" forState:(UIControlStateNormal)];
    _btn.titleLabel.numberOfLines = 0;
    _btn.titleLabel.textAlignment = 1;
    _btn.titleLabel.font = [UIFont systemFontOfSize:11];
    _btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    _btn.backgroundColor = [UIColor cyanColor];
    _btn.layer.cornerRadius = 30;
    _btn.layer.masksToBounds = YES;
   
  }
  return _btn;
}

- (UIImageView *)imgView{
  
  if (!_imgView) {
    _imgView = [[UIImageView alloc]init];
    _imgView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
    _imgView.image = [UIImage imageNamed:@"pic1.jpg"];
  }
  return _imgView;
}

@end
