//
//  AlbumPickerVC.m
//  iOSNote
//
//  Created by wangdong on 16/5/17.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "AlbumPickerVC.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ImagePickerVC.h"

ALAssetsFilter * ALAssetsFilterFromDNImagePickerControllerFilterType(DNImagePickerFilterType type)
{
    switch (type) {
        default:
        case DNImagePickerFilterTypeNone:
            return [ALAssetsFilter allAssets];
            break;
        case DNImagePickerFilterTypePhotos:
            return [ALAssetsFilter allPhotos];
            break;
        case DNImagePickerFilterTypeVideos:
            return [ALAssetsFilter allVideos];
            break;
    }
}

@interface AlbumPickerVC ()

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) NSArray *groupTypes;
@property (nonatomic, strong) NSArray *assetsGroups;

@end

@implementation AlbumPickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"相册";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setView];
    [self setData];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setView
{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)setData
{
    self.groupTypes = @[@(ALAssetsGroupAll)];
    self.assetsGroups = [NSMutableArray new];
}

- (void)loadData
{
    __weak typeof(self) weakSelf = self;
    [self loadAssetsGroupsWithTypes:self.groupTypes completion:^(NSArray *groupAssets)
     {
         __strong typeof(weakSelf) strongSelf = weakSelf;
         strongSelf.assetsGroups = groupAssets;
         [strongSelf.tableView reloadData];
     }];
}

- (ALAssetsLibrary *)assetsLibrary
{
    if (nil == _assetsLibrary) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    return _assetsLibrary;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.assetsGroups.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    ALAssetsGroup *group = self.assetsGroups[indexPath.row];
    
    cell.textLabel.attributedText = [self albumTitle:group];
    
    //choose the latest pic as poster image
    __weak UITableViewCell *blockCell = cell;
    [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:group.numberOfAssets-1] options:NSEnumerationConcurrent usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            *stop = YES;
            blockCell.imageView.image = [UIImage imageWithCGImage:result.thumbnail];
        }
    }];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ALAssetsGroup *group = self.assetsGroups[indexPath.row];
    NSURL *url = [group valueForProperty:ALAssetsGroupPropertyURL];
    ImagePickerVC *imageFlowViewController = [[ImagePickerVC alloc] initWithGroupURL:url];
    [self.navigationController pushViewController:imageFlowViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)loadAssetsGroupsWithTypes:(NSArray *)types completion:(void (^)(NSArray *assetsGroups))completion
{
    __block NSMutableArray *assetsGroups = [NSMutableArray array];
    __block NSUInteger numberOfFinishedTypes = 0;
    
    for (NSNumber *type in types) {
        __weak typeof(self) weakSelf = self;
        [self.assetsLibrary enumerateGroupsWithTypes:[type unsignedIntegerValue]
                                          usingBlock:^(ALAssetsGroup *assetsGroup, BOOL *stop)
         {
             __strong typeof(weakSelf) strongSelf = weakSelf;
             if (assetsGroup) {
                 // Filter the assets group
//                 [assetsGroup setAssetsFilter:ALAssetsFilterFromDNImagePickerControllerFilterType([[strongSelf dnImagePickerController] filterType])];
                 // Add assets group
                 if (assetsGroup.numberOfAssets > 0) {
                     // Add assets group
                     [assetsGroups addObject:assetsGroup];
                 }
             } else {
                 numberOfFinishedTypes++;
             }
             
             // Check if the loading finished
             if (numberOfFinishedTypes == types.count) {
                 //sort
                 NSArray *sortedAssetsGroups = [assetsGroups sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                     
                     ALAssetsGroup *a = obj1;
                     ALAssetsGroup *b = obj2;
                     
                     NSNumber *apropertyType = [a valueForProperty:ALAssetsGroupPropertyType];
                     NSNumber *bpropertyType = [b valueForProperty:ALAssetsGroupPropertyType];
                     if ([apropertyType compare:bpropertyType] == NSOrderedAscending)
                     {
                         return NSOrderedDescending;
                     }
                     return NSOrderedSame;
                 }];
                 
                 // Call completion block
                 if (completion) {
                     completion(sortedAssetsGroups);
                 }
             }
         } failureBlock:^(NSError *error) {
             __strong typeof(weakSelf) strongSelf = weakSelf;
             if ([ALAssetsLibrary authorizationStatus] != ALAuthorizationStatusAuthorized){
//                 [strongSelf showUnAuthorizedTipsView];
             }
         }];
    }
}

- (NSAttributedString *)albumTitle:(ALAssetsGroup *)assetsGroup
{
    NSString *albumTitle = [assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    NSString *numberString = [NSString stringWithFormat:@"  (%@)",@(assetsGroup.numberOfAssets)];
    NSString *cellTitleString = [NSString stringWithFormat:@"%@%@",albumTitle,numberString];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:cellTitleString];
    [attributedString setAttributes: @{
                                       NSFontAttributeName : [UIFont systemFontOfSize:16.0f],
                                       NSForegroundColorAttributeName : [UIColor blackColor],
                                       }
                              range:NSMakeRange(0, albumTitle.length)];
    [attributedString setAttributes:@{
                                      NSFontAttributeName : [UIFont systemFontOfSize:16.0f],
                                      NSForegroundColorAttributeName : [UIColor grayColor],
                                      } range:NSMakeRange(albumTitle.length, numberString.length)];
    return attributedString;
    
}

@end
