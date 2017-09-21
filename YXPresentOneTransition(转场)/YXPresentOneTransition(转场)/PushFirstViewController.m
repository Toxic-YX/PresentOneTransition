//
//  PushFirstViewController.m
//  YXPresentOneTransition(转场)
//
//  Created by Rookie_YX on 16/7/11.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//

#import "PushFirstViewController.h"
#import "PushSecondViewController.h"

@interface PushFirstViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property(nonatomic, strong) NSArray * imgInfoData;
@end

@implementation PushFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.title = @"Push";
  self.view.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:self.tableView];
}

#pragma mark - tableView的代理和数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  return self.imgInfoData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  PushFirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PushFirstCell"];
  if (!cell) {
    cell = [[PushFirstTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"PushFirstCell" frame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
  }
  cell.imgView.image = [UIImage imageNamed:self.imgInfoData[indexPath.row]];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
  _currentIndexPath = indexPath;
  PushSecondViewController * secondVC = [PushSecondViewController new];
  secondVC.imageName = self.imgInfoData[indexPath.row];
  //设置导航控制器的代理为推出的控制器，可以达到自定义不同控制器的退出效果的目的
  self.navigationController.delegate = secondVC;
  [self.navigationController pushViewController:secondVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  return  200;
}

#pragma mark - 懒加载
- (UITableView *)tableView{
  
  if (!_tableView) {
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
  }
  return _tableView;
}

- (NSArray *)imgInfoData{
  
  if (!_imgInfoData) {
    _imgInfoData = @[@"pic1.jpg",@"zrx3.jpg",@"zrx4.jpg",@"pic1.jpg",@"zrx3.jpg",@"zrx4.jpg",@"pic1.jpg",@"zrx3.jpg",@"zrx4.jpg"];
  }
  return _imgInfoData;
}
@end
