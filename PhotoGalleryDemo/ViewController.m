//
//  ViewController.m
//  PhotoGalleryDemo
//
//  Created by Andrew554 on 16/7/24.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "ViewController.h"
#import "MRLineLayout.h"
#import "MRCircleLayout.h"
#import "MRPhotoViewCell.h"
#import "MRGridLayout.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

/**
 *  UICollectionView
 */
@property (nonatomic, strong) UICollectionView *collectionView;

/**
 *  图片名数组
 */
@property (nonatomic, strong) NSMutableArray *imageNames;

@end

@implementation ViewController

static NSString * const photoCellID = @"photo";

- (NSMutableArray *)imageNames {
    
    if(!_imageNames) {
        
        _imageNames = [NSMutableArray array];
        
        for (NSInteger i = 0; i < 20; i++) {
            [_imageNames addObject:[NSString stringWithFormat:@"%zd", (i+1)]];
        }
    }
    
    return _imageNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // 创建自定义布局
    MRLineLayout *layout = [[MRLineLayout alloc] init];
    // 设置UICollectionView中每个Item的size
    layout.itemSize = CGSizeMake(150, 150);
    
    CGFloat x = 0;
    CGFloat y = 100;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = 300;
    
    // 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(x, y, width, height) collectionViewLayout:layout];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    self.collectionView = collectionView;
    
    // 注册CollectionViewCell
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MRPhotoViewCell class]) bundle:nil]  forCellWithReuseIdentifier:photoCellID];

    [self.view addSubview:collectionView];
}


#pragma mark - <UICollectonViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MRPhotoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:photoCellID forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor brownColor];
    
    cell.imageName = self.imageNames[indexPath.item];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    // 删除数据源-减少个数
    [self.imageNames removeObjectAtIndex:indexPath.item];
    // 删除collectionView单元格-重新布局
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UICollectionViewLayout *layout; // 布局
    
    if([self.collectionView.collectionViewLayout isKindOfClass:[MRLineLayout class]]) {

        layout = [[MRCircleLayout alloc] init];
        
    }else if([self.collectionView.collectionViewLayout isKindOfClass:[MRCircleLayout class]]) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        
        // 重新设置布局
        [self.collectionView setCollectionViewLayout:layout animated:YES];
        
        return;
        
    }else if([self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]){
        
        MRGridLayout *layout = [[MRGridLayout alloc] init];
        
        [self.collectionView setCollectionViewLayout:layout animated:YES];

        return;
        
    }else {
        
        MRLineLayout *layout = [[MRLineLayout alloc] init];
        
        layout.itemSize = CGSizeMake(150, 150);
        
        // 重新设置布局
        [self.collectionView setCollectionViewLayout:layout animated:YES];
        
        return;
    }
    
    // 重新设置布局
    [self.collectionView setCollectionViewLayout:layout animated:YES];
}


@end
