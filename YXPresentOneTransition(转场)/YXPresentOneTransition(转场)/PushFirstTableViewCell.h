//
//  PushFirstTableViewCell.h
//  YXPresentOneTransition(转场)
//
//  Created by Rookie_YX on 16/7/12.
//  Copyright © 2016年 YX_Rookie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PushFirstTableViewCell : UITableViewCell
@property(nonatomic, strong) UIImageView * imgView;
@property(nonatomic, strong) UILabel * lable;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame;
@end
