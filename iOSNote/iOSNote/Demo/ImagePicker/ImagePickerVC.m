//
//  ImagePickerVC.m
//  iOSNote
//
//  Created by wangdong on 16/5/17.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "ImagePickerVC.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ImagePickerCell.h"
#import "ImagePickerUploadButton.h"
#import "ImageBrowserVC.h"
#import "UploadPhotoContext.h"

@interface ImagePickerVC () <UICollectionViewDelegate, UICollectionViewDataSource, ImagePickerCellDelegate, MWPhotoBrowserDelegate, UploadAssetContextDelegate>
{
    UICollectionView *_collectionView;
}

@property (nonatomic, strong) NSURL *assetsGroupURL;
@property (nonatomic, strong) NSArray *assetsArray;
@property (nonatomic, strong) NSMutableArray *heheSelectedAssetsArray;
@property (nonatomic, strong) ImagePickerUploadButton *uploadButton;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) UploadPhotoContext *context;
@property (nonatomic, strong) ImageBrowserVC *imageBroswerVc;

@end

@implementation ImagePickerVC

- (instancetype)initWithGroupURL:(NSURL *)assetsGroupUrl
{
    if (self = [super init]) {
        _assetsGroupURL = assetsGroupUrl;
        _context = [UploadPhotoContext context];
        _context.delegate = self;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateToolbar];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.toolbarHidden = YES;
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
    [self.context loadGroupAssetsWithURL:_assetsGroupURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 2.0;
    layout.minimumInteritemSpacing = 2.0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
    [_collectionView registerClass:[ImagePickerCell class] forCellWithReuseIdentifier:@"ImagePickerCell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_collectionView];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"预览" style:UIBarButtonItemStylePlain target:self action:@selector(previewAction)];
    [item1 setTintColor:[UIColor blackColor]];
    item1.enabled = NO;
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithCustomView:self.uploadButton];
    UIBarButtonItem *item4 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    item4.width = -10;
    
    [self setToolbarItems:@[item1, item2, item3, item4] animated:NO];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assetsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImagePickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImagePickerCell" forIndexPath:indexPath];
    ALAsset *asset = self.assetsArray[indexPath.row];
    NSLog(@"%i", [self.context isSelectedAsset:asset]);
    [cell fillWithAsset:asset isSelected:[self.context isSelectedAsset:asset]];
    cell.editing = YES;
    cell.delegate = self;
    return cell;
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
    
}

- (void)didClickCell:(ImagePickerCell *)cell
{
    NSInteger index = [_collectionView indexPathForCell:cell].row;
    ALAsset *asset = self.assetsArray[index];
    if ([self.context isSelectedAsset:asset]) {
        [self deseletedAssets:asset];
    } else {
        [self seletedAssets:asset];
    }
    [_collectionView reloadData];
}

- (BOOL)seletedAssets:(ALAsset *)asset
{
    if ([self.context isSelectedAsset:asset]) {
        return NO;
    }
    
    if (self.context.selectedAssetsArray.count >= 9) {
        return NO;
    }
    else {
        [self.context addSelectedAsset:asset];
        [self updateToolbar];
        return YES;
    }
}

- (void)deseletedAssets:(ALAsset *)asset
{
    [self.context removeSelectedAsset:asset];
    [self updateToolbar];
}

- (void)updateToolbar
{
    self.uploadButton.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)self.context.selectedAssetsArray.count];
    UIBarButtonItem *firstItem = self.toolbarItems.firstObject;
    firstItem.enabled = self.context.selectedAssetsArray.count;
}

- (void)previewAction
{
    self.photos = [NSMutableArray array];
    
    for (ALAsset *asset in self.context.selectedAssetsArray) {
        [self.photos addObject:[MWPhoto photoWithURL:[asset valueForProperty:ALAssetPropertyAssetURL]]];
    }
    
    ImageBrowserVC *b = [[ImageBrowserVC alloc] initWithDelegate:self];
    b.displayActionButton = YES;
    b.displayNavArrows = NO;
    b.displaySelectionButtons = NO;
    b.zoomPhotosToFill = YES;
    b.enableGrid = YES;
    b.startOnGrid = NO;
    b.autoPlayOnAppear = NO;
    b.alwaysShowControls = YES;
    [b setCurrentPhotoIndex:0];
    
    self.heheSelectedAssetsArray = [self.context.selectedAssetsArray mutableCopy];
    
    [self.navigationController pushViewController:b animated:YES];
}

- (ImagePickerUploadButton *)uploadButton
{
    if (!_uploadButton) {
        _uploadButton = [[ImagePickerUploadButton alloc] initWithFrame:CGRectZero];
        [_uploadButton addTaget:self action:@selector(handleUploadButtonAction:)];
    }
    return _uploadButton;
}

- (void)handleUploadButtonAction:(ImagePickerUploadButton *)sender
{
    if ([_delegate respondsToSelector:@selector(photoPicker:photos:)]) {
        [_delegate photoPicker:self photos:self.context.selectedAssetsArray];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}

- (void)photoBrowser:(ImageBrowserVC *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index
{
    ALAsset *asset = self.context.selectedAssetsArray[index];
    photoBrowser.actionButtonSelected = ([self.context isSelectedAsset:asset] && [_heheSelectedAssetsArray containsObject:asset]);
}

- (void)photoBrowser:(ImageBrowserVC *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index
{
    ALAsset *asset = self.context.selectedAssetsArray[index];

    if ([self.context isSelectedAsset:asset] && [_heheSelectedAssetsArray containsObject:asset]) {
//        [self.heheSelectedAssetsArray removeObject:asset];
        [self.heheSelectedAssetsArray replaceObjectAtIndex:index withObject:[NSNull null]];
        photoBrowser.actionButtonSelected = NO;
    } else {
        [self.heheSelectedAssetsArray replaceObjectAtIndex:index withObject:asset];
        photoBrowser.actionButtonSelected = YES;
    }
    
    [_collectionView reloadData];
}

- (void)groupAssetLoadFinished
{
    _assetsArray = [self.context fetchAssets];
    [_collectionView reloadData];
    self.title = self.context.groupName;
}

- (void)result
{
    [self.context.selectedAssetsArray removeAllObjects];
    for (ALAsset *asset in self.heheSelectedAssetsArray) {
        if (![asset isKindOfClass:[NSNull class]]) {
            [self.context addSelectedAsset:asset];
        }
    }
    [_collectionView reloadData];
}

@end
