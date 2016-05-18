//
//  ImagePickerVC.m
//  iOSNote
//
//  Created by wangdong on 16/5/17.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "EditImageVC.h"
#import "AlbumPickerVC.h"
#import "ImagePickerVC.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface EditImageVC () <UICollectionViewDelegate, UICollectionViewDataSource, ImagePickerVCDelegate>
{
    UICollectionView *_collectionView;
}

@end

@implementation EditImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"取车";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 2.0;
    layout.minimumInteritemSpacing = 2.0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    
    
    [self.view addSubview:_collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

#define kSizeThumbnailCollectionView  ([UIScreen mainScreen].bounds.size.width-10)/4
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(kSizeThumbnailCollectionView, kSizeThumbnailCollectionView);
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2, 2, 2, 2);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    
    ALAssetsLibrary *assetsLibiary = [[ALAssetsLibrary alloc] init];
    [assetsLibiary enumerateGroupsWithTypes:ALAssetsGroupAll
                                 usingBlock:^(ALAssetsGroup *assetsGroup, BOOL *stop)
     {

         *stop = YES;
         
//         NSString *assetsGroupID= [assetsGroup valueForProperty:ALAssetsGroupPropertyPersistentID];
         if (assetsGroup) {
             NSURL *assetsGroupURL = [assetsGroup valueForProperty:ALAssetsGroupPropertyURL];
             UIViewController *albumTableViewController = [[AlbumPickerVC alloc] init];
             ImagePickerVC *imageFlowController = [[ImagePickerVC alloc] initWithGroupURL:assetsGroupURL];
             imageFlowController.delegate = self;
             [self.navigationController setViewControllers:@[self, albumTableViewController,imageFlowController] animated:YES];
         }
         
     }
                               failureBlock:^(NSError *error)
     {
//         [self showAlbumList];
     }];
}

- (void)hehe
{
    NSLog(@"1");
}

@end
