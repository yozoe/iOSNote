//
//  CellHeightDemoVC.m
//  iOSNote
//
//  Created by wangdong on 2016/12/1.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "CellHeightDemoVC.h"
#import "HeightDemoCell_1.h"
#import "HeightDemoStackViewCell.h"

@interface CellHeightDemoVC ()

@end

@implementation CellHeightDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HeightDemoCell_1" bundle:nil] forCellReuseIdentifier:@"HeightDemoCell_1"];

    [self.tableView registerNib:[UINib nibWithNibName:@"HeightDemoStackViewCell" bundle:nil] forCellReuseIdentifier:@"HeightDemoStackViewCell"];

    
    self.tableView.estimatedRowHeight = 44.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row % 2 != 0) {
        HeightDemoCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:@"HeightDemoCell_1" forIndexPath:indexPath];
        cell.testTitle.text = self.lableTitle;
        
        NSLog(@"%d", arc4random() % 2);
        
        if (indexPath.row % 2 != 0) {
            cell.testImageView.image = [UIImage imageNamed:@"selecte"];
        }
        else {
            cell.testImageView.image = [UIImage imageNamed:@"123"];
        }

        return cell;
    }
    else {
        HeightDemoStackViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeightDemoStackViewCell" forIndexPath:indexPath];
        
        //
        for (int i = 0; i < 5; i++) {
            UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selecte"]];
            [cell.stackView addArrangedSubview:view];
        }
        
        return cell;
    }
    
    
}

- (NSString *)lableTitle
{
    return @[
             @"aaaaaaaaaaaaaaa",
             @"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
             @"c",
             @"d",
             @"e"
             ][arc4random() % 4];
}

- (UIImage *)randomImage
{
    return [UIImage imageNamed:(@[
                                  @"dot",
                                  @"selecte"
                                  ][arc4random() % 1])];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return [self.lineupCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize
//                          withHorizontalFittingPriority:UILayoutPriorityDefaultLow
//                                verticalFittingPriority:UILayoutPriorityDefaultHigh].height;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    CGFloat height = [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize
                      withHorizontalFittingPriority:UILayoutPriorityDefaultLow
                                                      verticalFittingPriority:UILayoutPriorityDefaultHigh].height;
    
    NSLog(@"%f", height);
    
}

@end
