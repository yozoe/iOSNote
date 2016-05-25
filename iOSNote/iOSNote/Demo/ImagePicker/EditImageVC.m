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
#import "UploadAssetDBHelper.h"
#import "UploadAssetManagedObject.h"
#import "UploadPhotoModel.h"
#import "MWPhotoBrowser.h"

@interface EditImageVC () <UICollectionViewDelegate, UICollectionViewDataSource, ImagePickerVCDelegate, ImagePickerCellDelegate, MWPhotoBrowserDelegate>
{
    UICollectionView *_collectionView;
    BOOL _editing;
}

@property (nonatomic, strong) NSMutableArray *source;
@property (nonatomic, strong) UploadPhotoContext *context;
@property (nonatomic, strong) NSMutableArray *selectedArray;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIButton *retryButton;
@property (nonatomic, strong) UIToolbar *retryToolbar;
@property (nonatomic, strong) UIToolbar *deleteToolbar;
@property (nonatomic, strong) NSMutableArray *photos;

@end

@implementation EditImageVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.tintColor = [UIColor blackColor];
    navBar.barTintColor = nil;
    navBar.shadowImage = nil;
    navBar.translucent = YES;
    navBar.barStyle = UIBarStyleDefault;
    [navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsLandscapePhone];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _context = [UploadPhotoContext context];
    
    _source = [[NSMutableArray alloc] init];
    _selectedArray = [[NSMutableArray alloc] init];
    
    self.title = @"取车";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initView];
    
    [self loadDB];
    [self loadServer];
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
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [_collectionView registerClass:[ImagePickerEditCell class] forCellWithReuseIdentifier:@"ImagePickerEditCell"];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
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
    [self changeEditStage];
}

- (void)changeEditStage
{
    if (_editing) {
        UIButton *button = ((UIButton *)self.navigationItem.rightBarButtonItem.customView);
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [_selectedArray removeAllObjects];
        self.deleteToolbar.hidden = NO;
        [_collectionView setContentInset:UIEdgeInsetsMake(_collectionView.contentInset.top, 0, 44, 0)];
    } else {
        UIButton *button = ((UIButton *)self.navigationItem.rightBarButtonItem.customView);
        [button setTitle:@"编辑" forState:UIControlStateNormal];
        self.deleteToolbar.hidden = YES;
        [_collectionView setContentInset:UIEdgeInsetsMake(_collectionView.contentInset.top, 0, 0, 0)];
    }
//    [_collectionView reloadData];
    
    NSArray *array = _collectionView.visibleCells;
    for (UICollectionViewCell *cell in array) {
        if ([cell isKindOfClass:[ImagePickerEditCell class]]) {
            ((ImagePickerEditCell *)cell).editing = _editing;
        }
    }
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
        ImagePickerEditCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImagePickerEditCell" forIndexPath:indexPath];
        UploadPhotoModel *model = _source[indexPath.row - 1];
        
        cell.model = model;
        cell.editing = _editing;
        cell.delegate= self;
        
        return cell;
    }
}

- (BOOL)isSelectedModel:(UploadPhotoModel *)model
{
    return [_selectedArray containsObject:model];
}

- (void)didClickCell:(ImagePickerEditCell *)cell
{
    NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
    UploadPhotoModel *model = self.source[indexPath.row - 1];
    if ([self isSelectedModel:model]) {
        [self.selectedArray removeObject:model];
        model.selected = NO;
    } else {
        model.selected = YES;
        [self.selectedArray addObject:model];
    }
    cell.isSelected = model.selected;
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
        
        NSString *gourpID = [self.context loadPhotoGourpID];
        
        ALAssetsLibrary *assetsLibiary = [[ALAssetsLibrary alloc] init];
        
        [assetsLibiary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            if (*stop == NO && group == nil) {
                [self showAlbumPicker];
            }
            
            NSString *assetsGroupID= [group valueForProperty:ALAssetsGroupPropertyPersistentID];
            if ([assetsGroupID isEqualToString:gourpID]) {
                *stop = YES;
                NSURL *assetsGroupURL = [group valueForProperty:ALAssetsGroupPropertyURL];
                UIViewController *albumPickerVC = [[AlbumPickerVC alloc] init];
                ImagePickerVC *imagePickerVC = [[ImagePickerVC alloc] initWithGroupURL:assetsGroupURL];
                imagePickerVC.delegate = self;
                [self.navigationController setViewControllers:@[self, albumPickerVC,imagePickerVC] animated:YES];
            }
        } failureBlock:^(NSError *error) {
            [self showAlbumPicker];
        }];
    } else {
        [self previewAction];
    }
}

- (void)previewAction
{
    self.photos = [NSMutableArray array];
    
    for (UploadPhotoModel *model in self.source) {
        if (!model.url) {
            model.url = [NSURL URLWithString:@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png"];
        }
        [self.photos addObject:[MWPhoto photoWithURL:model.url]];
    }
    
    [self.context initPreviewAssets];
    
    MWPhotoBrowser *b = [[MWPhotoBrowser alloc] init];
    b.delegate = self;
    b.displayActionButton = NO;
    b.displayNavArrows = NO;
    b.displaySelectionButtons = NO;
    b.zoomPhotosToFill = YES;
    b.enableGrid = YES;
    b.startOnGrid = NO;
    b.autoPlayOnAppear = NO;
    b.alwaysShowControls = NO;
    [b setCurrentPhotoIndex:0];
    
    [self.navigationController pushViewController:b animated:YES];
}

- (void)photoPickerClickUploadButton:(ImagePickerVC *)picker
{
    for (ALAsset *asset in _context.selectedAssetsArray) {
        NSURL *url = [asset valueForProperty:ALAssetPropertyAssetURL];
        [[UploadAssetDBHelper defaultHelper] insertNewUploadAssetWithURL:[url absoluteString]];
        UploadPhotoModel *model = [UploadPhotoModel new];
        model.asset = asset;
        model.imageFrom = ImageFromLibrary;
        [_source addObject:model];
    }
    
    [_collectionView reloadData];
}

- (void)showAlbumPicker
{
    UIViewController *albumPickerVC = [[AlbumPickerVC alloc] init];
    [self.navigationController pushViewController:albumPickerVC animated:YES];
}

- (void)loadDB
{
    NSArray *array = [[UploadAssetDBHelper defaultHelper] fetchAll];
    
    for (UploadAssetManagedObject *model in array) {
        UploadPhotoModel *uploadPhotoModel = [UploadPhotoModel new];
        uploadPhotoModel.url = [NSURL URLWithString:model.url];
        uploadPhotoModel.imageFrom = ImageFromDB;
        [_source addObject:uploadPhotoModel];
    }
    
    [_collectionView reloadData];
}

- (void)loadServer
{
    for (int i = 0; i < 100; i++) {
        UploadPhotoModel *model = [UploadPhotoModel new];
        model.imageFrom = ImageFromServer;
        [_source addObject:model];
    }
    [_collectionView reloadData];
}

- (UIToolbar *)retryToolbar
{
    if (!_retryToolbar) {
        _retryToolbar = [[UIToolbar alloc] init];
        UILabel *label = [[UILabel alloc] init];
        label.text = @"请检查您的网络";
        [label sizeToFit];
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:label];
        [item1 setTintColor:[UIColor blackColor]];
        item1.enabled = NO;
        UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        
        UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithCustomView:self.retryButton];
        UIBarButtonItem *item4 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        item4.width = -10;
        
        [_retryToolbar setItems:@[item1, item2, item3]];
        [self.view addSubview:_retryToolbar];
        
        [_retryToolbar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(44.f);
        }];
    }
    return _retryToolbar;
}

- (UIToolbar *)deleteToolbar
{
    if (!_deleteToolbar) {
        _deleteToolbar = [[UIToolbar alloc] init];

        UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:self.deleteButton];
        
        UIBarButtonItem *item0 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        [_deleteToolbar setItems:@[item0, item1, item2]];
        
        [self.view addSubview:_deleteToolbar];
        
        [_deleteToolbar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(44.f);
        }];
    }
    return _deleteToolbar;
}

- (UIButton *)retryButton
{
    if (!_retryButton) {
        _retryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_retryButton setTitle:@"重试" forState:UIControlStateNormal];
        _retryButton.frame = CGRectMake(0, 0, 50, 30);
        [_retryButton addTarget:self action:@selector(handleRetryButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_retryButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    return _retryButton;
}

- (UIButton *)deleteButton
{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(handleDeleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton.frame = CGRectMake(0, 0, 50, 30);
        [_deleteButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    return _deleteButton;
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

- (void)handleRetryButtonAction
{
    NSLog(@"retry");
}

- (void)handleDeleteButtonAction
{
    NSLog(@"delete");
}

@end
