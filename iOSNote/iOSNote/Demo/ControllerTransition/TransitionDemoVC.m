//
//  TransitionDemoVC.m
//  iOSNote
//
//  Created by wangdong on 16/5/13.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "TransitionDemoVC.h"
#import "TDModel.h"
#import "TDDemoCell.h"
#import "TransitionDemoSecVC.h"
#import "TDTransitionFromFirToSec.h"

@interface TransitionDemoVC () <UINavigationControllerDelegate>

@property (nonatomic, strong) NSArray *things;

@end

@implementation TransitionDemoVC

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self != nil) {
        _things = [TDModel exampleThings];
        self.title = @"Things";
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    if (fromVC == self && [toVC isKindOfClass:[TransitionDemoSecVC class]]) {
        return [[TDTransitionFromFirToSec alloc] init];
    } else {
        return nil;
    }
}

- (TDDemoCell *)collectionViewCellForThing:(TDModel *)model
{
    return nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[TransitionDemoSecVC class]]) {
        NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
        if (selectedIndexPath != nil) {
            TransitionDemoSecVC *secVC = segue.destinationViewController;
            secVC.thing = self.things[selectedIndexPath.row];
        }
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.things.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TDDemoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TDDemoCell class]) forIndexPath:indexPath];
    
    TDModel *thing = self.things[indexPath.row];
    cell.titleLabel.text = thing.title;
    cell.imageView.image = thing.image;
    
    return cell;
}

@end
