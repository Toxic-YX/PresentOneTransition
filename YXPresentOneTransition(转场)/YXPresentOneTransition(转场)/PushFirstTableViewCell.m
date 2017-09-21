//
//  PushFirstTableViewCell.m
//  YXPresentOneTransition(转场)
//
//  Created by Rookie_YX on 16/7/12.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//

#import "PushFirstTableViewCell.h"

@implementation PushFirstTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame{
  
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.contentView.frame = frame;
    // UI
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.lable];
    
    // 布局
      __weak typeof(self) wSelf = self;
    [self.lable mas_makeConstraints:^(MASConstraintMaker *make) {
      make.bottom.mas_equalTo(wSelf.imgView.mas_bottom).offset(- 0.1);
      make.size.mas_equalTo(CGSizeMake(wSelf.contentView.frame.size.width, 30));
    }];
  }
  return self;
}

- (UIImageView *)imgView{
  
  if (!_imgView) {
    _imgView = [[UIImageView alloc]init];
    _imgView.frame = CGRectMake(0, 0,self.contentView.frame.size.width, self.contentView.frame.size.height);
    _imgView.backgroundColor = [UIColor cyanColor];
  }
  return _imgView;
}

- (UILabel *)lable{
  
  if (!_lable) {
    _lable = [[UILabel alloc]init];
    _lable.text = @"放眼望去你发现景色是那么美丽!";
    _lable.textColor = [UIColor cyanColor];
    _lable.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
  }
  return _lable;
}
@end
