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
#import "MWPhotoBrowser.h"

@interface ImagePickerVC () <UICollectionViewDelegate, UICollectionViewDataSource, ImagePickerCellDelegate, MWPhotoBrowserDelegate>
{
    UICollectionView *_collectionView;
}

@property (nonatomic, strong) NSURL *assetsGroupURL;
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) ALAssetsGroup *assetsGroup;
@property (nonatomic, strong) NSMutableArray *assetsArray;
@property (nonatomic, strong) NSMutableArray *selectedAssetsArray;
@property (nonatomic, strong) ImagePickerUploadButton *uploadButton;
@property (nonatomic, strong) NSMutableArray *photos;

@end

@implementation ImagePickerVC

- (instancetype)initWithGroupURL:(NSURL *)assetsGroupUrl
{
    if (self = [super init]) {
        _assetsArray = [NSMutableArray new];
        _selectedAssetsArray = [NSMutableArray new];
        _assetsGroupURL = assetsGroupUrl;
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
    [self setupData];
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
    [_collectionView registerClass:[ImagePickerCell class] forCellWithReuseIdentifier:@"cell"];
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

- (void)setupData
{
    [_assetsLibrary groupForURL:self.assetsGroupURL resultBlock:^(ALAssetsGroup *group) {
        self.assetsGroup = group;
        if (self.assetsGroup) {
            self.title = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
            [self loadData];
        }
    } failureBlock:^(NSError *error) {
        
    }];
}

- (void)loadData
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.assetsGroup enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result) {
                [self.assetsArray insertObject:result atIndex:0];
            }
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.imageFlowCollectionView reloadData];
//            [self scrollerToBottom:NO];
            [_collectionView reloadData];
        });
    });
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assetsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImagePickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    ALAsset *asset = self.assetsArray[indexPath.row];
    [cell fillWithAsset:asset isSelected:[self assetIsSelected:asset]];
    cell.delegate = self;
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
    if ([self assetIsSelected:asset]) {
        return NO;
    }
    UIBarButtonItem *firstItem = self.toolbarItems.firstObject;
    firstItem.enabled = YES;
    if (self.selectedAssetsArray.count >= 9) {
        
        return NO;
    }
    else {
        [self addAssetsObject:asset];
        self.uploadButton.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)self.selectedAssetsArray.count];
        return YES;
    }
}

- (void)deseletedAssets:(ALAsset *)asset
{
    [self removeAssetsObject:asset];
    self.uploadButton.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)self.selectedAssetsArray.count];
    if (self.selectedAssetsArray.count < 1) {
        UIBarButtonItem *firstItem = self.toolbarItems.firstObject;
        firstItem.enabled = NO;
    }
}

- (void)addAssetsObject:(ALAsset *)asset
{
    [self.selectedAssetsArray addObject:asset];
}

- (void)removeAssetsObject:(ALAsset *)asset
{
    if ([self assetIsSelected:asset]) {
        [self.selectedAssetsArray removeObject:asset];
    }
}

- (BOOL)assetIsSelected:(ALAsset *)targetAsset
{
    for (ALAsset *asset in self.selectedAssetsArray) {
        NSURL *assetURL = [asset valueForProperty:ALAssetPropertyAssetURL];
        NSURL *targetAssetURL = [targetAsset valueForProperty:ALAssetPropertyAssetURL];
        NSLog(@"%@", [assetURL absoluteString]);
        if ([[assetURL absoluteString] isEqualToString:[targetAssetURL absoluteString]]) {
            return YES;
        }
    }
    return NO;
}

- (void)previewAction
{
//    [self browserPhotoAsstes:self.selectedAssetsArray pageIndex:0];
    
    self.photos = [NSMutableArray array];
    
    // Add photos
    
    [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png"]]];
    [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png"]]];
    
    ALAsset *hehe = self.assetsArray[0];
    
    [self.photos addObject:[MWPhoto photoWithURL:[hehe valueForProperty:ALAssetPropertyAssetURL]]];
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    // Set options
    browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    browser.autoPlayOnAppear = NO; // Auto-play first video
    
    // Optionally set the current visible photo before displaying
    
    
    
    [browser setCurrentPhotoIndex:1];
    
    // Present
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
    NSLog(@"%@", self.selectedAssetsArray);
    if ([_delegate respondsToSelector:@selector(hehe)]) {
        [_delegate hehe];
    }
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}

@end
