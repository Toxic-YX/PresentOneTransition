//
//  ViewController.m
//  TableView的insertRow
//
//  Created by Rookie_YX on 16/6/3.
//  Copyright © 2016年 YX_Rookic. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftBarBtnItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *animLoadInfoBarBtnItem;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * numberArray;            //存放数字的数组
@property (nonatomic, strong) NSMutableArray * infoArray;     //UItableView数据源
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载tableview
    [self tableView];
    
    //加载按钮数据
//    [self addInfo];
    
    // 动画插入数据
    [self animLoadInfo];
}
- (void)addInfo{
    //初始化_numberArray数组，并且将0~99数字转换为NSNumber对象添加进入该数组
    _numberArray = [[NSMutableArray alloc] initWithCapacity:3];
    for(int i = 0;i < 100;i++)
    {
        NSNumber *tempNumber = [NSNumber numberWithInt:i];
        [_numberArray addObject:tempNumber];
    }
    //初始化TableView数据源
    _infoArray = [[NSMutableArray alloc] initWithCapacity:3];
}

- (void)animLoadInfo{
    //初始化_numberArray，并且将0~99数字转换成NSNumber，然后加入数组
    _numberArray = [[NSMutableArray alloc] initWithCapacity:3];
    for(int i = 0;i < 100;i++)
    {
        NSNumber *tempNumber = [NSNumber numberWithInt:i];
        [_numberArray addObject:tempNumber];
    }
    //初始化数据源数组_infoArray
    NSNumber *num0 = [NSNumber numberWithInt:1];
    NSNumber *num1 = [NSNumber numberWithInt:30];
    NSNumber *num2 = [NSNumber numberWithInt:47];
    NSNumber *num3 = [NSNumber numberWithInt:68];
    NSNumber *num4 = [NSNumber numberWithInt:75];
    NSNumber *num5 = [NSNumber numberWithInt:88];
    _infoArray = [[NSMutableArray alloc] initWithObjects:num0,num1,num2,num3,num4,num5, nil];
}

- (IBAction)leftBarBtnItem:(UIButton *)sender {
    // - 加载数据 
//    int count = (int)[_numberArray count];
//    //0~count随机数
//    int randomIndex = rand()%count;
//    NSNumber *tempNumber = [_numberArray objectAtIndex:randomIndex];
//    [_infoArray addObject:tempNumber];
//    [_numberArray removeObject:tempNumber];
//    //调用TableView的reloadData刷新界面
//    [self.tableView reloadData];
    
    // -  insertInfo  动画
    NSLog(@"%s",__func__);
    int count = (int)[_numberArray count];
    //0~count随机数
    int randomIndex = rand()%count;
    //随机从_numberArray中获取一个元素insertNumber
    NSNumber *insertNumber = [_numberArray objectAtIndex:randomIndex];
    int index = 0;
    for (NSNumber *tempNumber in _infoArray) {
        //将要插入的元素与数据源_infoArray中的元素进行大小比较
        int insertInt = [insertNumber intValue];
        int existInt = [tempNumber intValue];
        //因为数据源是顺序排列的，所以如果要插入的数字小于_infoArray数据源中的某个值时候则插入数字
        //index是用于记录要插入的位置的
        if (insertInt<=existInt) {
            [_infoArray insertObject:insertNumber atIndex:index];
            NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            [indexPaths addObject:indexPath];
            [self performSelectorOnMainThread:@selector(insertTableViewRow:) withObject:indexPaths waitUntilDone:YES];
            //这里是到主线程中刷新界面，因为现在就是在主线程，所以这段话有点多此一举，可以直接调用下面的代码
//            [self insertTableViewRow:indexPaths];
            
            //为什么需要一个break语句呢？因为如果不通过break停止for循环，则会出现插入错误。
            break;
        }
        index++;
    }
    //为了不重复插入_numberArray中的数据，则要将已经插_infoArray数据源中的数据从原来的数组中删除
    [_numberArray removeObject:insertNumber];
}
- (IBAction)animInsertInfo:(id)sender {
 
}


#pragma mark -  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%ld",_infoArray.count);
    return _infoArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"cellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
    }
//    if (_infoArray.count != 0){
        cell.textLabel.text = [NSString stringWithFormat:@"%@",_infoArray[indexPath.row]];
//    }
    return cell;
}

- (void)insertTableViewRow:(NSMutableArray *)indexPaths
{
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    //UITableViewRowAnimationFade是一种渐变淡出的效果，这个在删除行的时候使用比较好，这里使用UITableViewRowAnimationAutomatic动画效果比较好
}
#pragma mark- 懒加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [UITableView new];
        _tableView.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
