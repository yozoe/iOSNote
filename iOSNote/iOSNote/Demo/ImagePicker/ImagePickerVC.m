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
@property (nonatomic, strong) NSMutableArray *selectedAssetsArray;
@property (nonatomic, strong) ImagePickerUploadButton *uploadButton;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) UploadPhotoContext *context;

@end

@implementation ImagePickerVC

- (instancetype)initWithGroupURL:(NSURL *)assetsGroupUrl
{
    if (self = [super init]) {
//        _assetsArray = [NSMutableArray new];
//        _selectedAssetsArray = [NSMutableArray new];
        _assetsGroupURL = assetsGroupUrl;
//        _assetsLibrary = [[ALAssetsLibrary alloc] init];
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

- (void)didSelectCell:(ImagePickerCell *)cell
{
    cell.isSelected = [self seletedAssets:cell.asset];
}

- (void)didDeselectCell:(ImagePickerCell *)cell
{
    cell.isSelected = NO;
    [self deseletedAssets:cell.asset];
}

- (BOOL)seletedAssets:(ALAsset *)asset
{
    if ([self.context isSelectedAsset:asset]) {
        return NO;
    }
    UIBarButtonItem *firstItem = self.toolbarItems.firstObject;
    firstItem.enabled = YES;
    if (self.selectedAssetsArray.count >= 9) {
        return NO;
    }
    else {
        [self.context addSelectedAsset:asset];
        self.uploadButton.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)self.context.selectedAssetsArray.count];
        return YES;
    }
}

- (void)deseletedAssets:(ALAsset *)asset
{
    [self.context removeSelectedAsset:asset];
    self.uploadButton.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)self.context.selectedAssetsArray.count];
    if (self.selectedAssetsArray.count < 1) {
        UIBarButtonItem *firstItem = self.toolbarItems.firstObject;
        firstItem.enabled = NO;
    }
}

- (void)previewAction
{
    self.photos = [NSMutableArray array];
    
    for (ALAsset *asset in self.context.selectedAssetsArray) {
        [self.photos addObject:[MWPhoto photoWithURL:[asset valueForProperty:ALAssetPropertyAssetURL]]];
    }
    
    ImageBrowserVC *browser = [[ImageBrowserVC alloc] initWithDelegate:self];
    
    browser.displayActionButton = YES;
    browser.displayNavArrows = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = YES;
    browser.startOnGrid = NO;
    browser.autoPlayOnAppear = NO;
    browser.alwaysShowControls = YES;
    [browser setCurrentPhotoIndex:0];
    
 
    [self.navigationController pushViewController:browser animated:YES];
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
        [_delegate photoPicker:self photos:self.selectedAssetsArray];
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

- (void)groupAssetLoadFinished
{
    _assetsArray = [self.context fetchAssets];
    [_collectionView reloadData];
    self.title = self.context.groupName;
}

@end