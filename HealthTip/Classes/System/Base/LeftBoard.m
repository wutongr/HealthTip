//
//  LeftBoard.m
//  HealthTip
//
//  Created by Yorke on 15/2/28.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#import "LeftBoard.h"

@interface LeftBoard ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *tableData;

@end

@implementation LeftBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)initView{
    [super initView];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"LeftBoard";
}

- (void)initData{
    [super initData];
}

- (UITableView *)tableView{
    if(!_tableView){
        
    }
    return _tableView;
}

- (NSArray *)tableData{
    if(!_tableData){
        _tableData = @[@"",@""];
    }
    return _tableData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
