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
#import "ImagePickerEditCell.h"
#import "UploadPhotoContext.h"

@interface EditImageVC () <UICollectionViewDelegate, UICollectionViewDataSource, ImagePickerVCDelegate>
{
    UICollectionView *_collectionView;
    BOOL _editing;
}

@property (nonatomic, strong) NSMutableArray *source;
@property (nonatomic, strong) UploadPhotoContext *context;

@end

@implementation EditImageVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _context = [UploadPhotoContext context];
    
    _source = [[NSMutableArray alloc] init];
    
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
    [_collectionView registerClass:[ImagePickerEditCell class] forCellWithReuseIdentifier:@"ImagePickerEditCell"];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_collectionView];
    
    if( self.navigationItem != nil )
    {
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}

- (void)rightButtonAction:(UIButton *)sender
{
    _editing = !_editing;
    if (_editing) {
        UIButton *button = ((UIButton *)self.navigationItem.rightBarButtonItem.customView);
        [button setTitle:@"取消" forState:UIControlStateNormal];
    } else {
        UIButton *button = ((UIButton *)self.navigationItem.rightBarButtonItem.customView);
        [button setTitle:@"编辑" forState:UIControlStateNormal];
    }
    [_collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _source.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor redColor];
        return cell;
    } else {
        ImagePickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImagePickerEditCell" forIndexPath:indexPath];
        ALAsset *asset = self.source[indexPath.row - 1];
        [cell fillWithAsset:asset isSelected:NO];
        cell.editing = _editing;
        //    cell.delegate = self;
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width, height;
    width = height = ([UIScreen mainScreen].bounds.size.width - 10) / 4;
    CGSize size = CGSizeMake(width, height);
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2, 2, 2, 2);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
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
}

- (void)photoPicker:(ImagePickerVC *)picker photos:(NSArray *)photos
{
    _source = [NSMutableArray arrayWithArray:_context.selectedAssetsArray];
    [_collectionView reloadData];
}

@end