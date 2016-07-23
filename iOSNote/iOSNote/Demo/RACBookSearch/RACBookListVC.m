//
//  RACBookListVC.m
//  iOSNote
//
//  Created by wangdong on 16/7/23.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RACBookListVC.h"
#import <ReactiveCocoa.h>
#import "RACBookEntity.h"

@interface RACBookListVC ()

@property (nonatomic, strong) NSArray *data;

@end

@implementation RACBookListVC

- (instancetype)initWithData:(NSArray *)data
{
    if (self = [super init]) {
        self.data = data;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"BookCell"];
    
    [RACObserve(self, data) subscribeNext:^(id x) {
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookCell" forIndexPath:indexPath];
    RACBookEntity *entity = _data[indexPath.row];
    cell.textLabel.text = entity.title;
    return cell;
}

@end
