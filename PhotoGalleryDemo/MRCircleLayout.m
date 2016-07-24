//
//  MRCircleLayout.m
//  PhotoGalleryDemo
//
//  Created by Andrew554 on 16/7/24.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "MRCircleLayout.h"

@interface MRCircleLayout ()

/**
 *  布局属性
 */
@property (nonatomic, strong) NSMutableArray *attrs;

@end

@implementation MRCircleLayout

- (NSMutableArray *)attrs {
    
    if(!_attrs) {
        
        _attrs = [NSMutableArray array];
        
    }
    
    return _attrs;
}

// 初始化布局属性
- (void)prepareLayout {
    [super prepareLayout];
    
    // 先删除之前的布局属性
    [self.attrs removeAllObjects];
    
    // 获取item的个数
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i < count; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [self.attrs addObject:attr];
    }
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return self.attrs;
}


/**
 * 这个方法需要返回indexPath位置对应cell的布局属性, 如果是继承自UICollectionViewLayout则必须实现这个方法, 继承UICollectionViewFlowLayout可以不用实现
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    CGFloat radius = 100;
    // 圆心的位置
    CGFloat oX = self.collectionView.frame.size.width * 0.5;
    CGFloat oY = self.collectionView.frame.size.height * 0.5;
    
    // 创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attrs.size = CGSizeMake(50, 50);
    
    if (count == 1) {
        attrs.center = CGPointMake(oX, oY);
    } else {
        CGFloat angle = (2 * M_PI / count) * indexPath.item;
        CGFloat centerX = oX + radius * sin(angle);
        CGFloat centerY = oY + radius * cos(angle);
        attrs.center = CGPointMake(centerX, centerY);
    }
    
    return attrs;
}

@end
