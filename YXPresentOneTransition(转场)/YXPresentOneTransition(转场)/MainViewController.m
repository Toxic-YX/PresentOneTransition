//
//  MainViewController.m
//  YXPresentOneTransition(转场)
//
//  Created by Rookie_YX on 16/7/11.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView * tableView;
@property(nonatomic, strong) NSArray * infoData;
@property(nonatomic, strong) NSArray * classList;
@end

@implementation MainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  return self.infoData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell"];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"basicCell"];
  }
  cell.textLabel.text = self.infoData[indexPath.row];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
  [self pushViewController:self.classList[indexPath.row]];
}


- (void)pushViewController:(NSString *)className{
  
  // 将字符串转换为类
  Class cls = NSClassFromString(className);
  UIViewController * vcCls = [(UIViewController *)[cls alloc]init];
  [self.navigationController pushViewController:vcCls animated:YES];
}

- (UITableView *)tableView{
  
  if (!_tableView) {
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
  }
  return _tableView;
}

- (NSArray *)infoData{
  
  if (!_infoData) {
    _infoData = @[@"Present",@"Push",@"DotSpread"];
  }
  return  _infoData;
}

- (NSArray *)classList{
  
  if (!_classList) {
    _classList = @[@"FirstViewController",@"PushFirstViewController",@"DotSpreadFirstViewController"];
  }
  return _classList;
}
@end
