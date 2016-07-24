//
//  MRGridLayout.m
//  PhotoGalleryDemo
//
//  Created by Andrew554 on 16/7/25.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "MRGridLayout.h"

@interface MRGridLayout ()

/**
 *  布局属性
 */
@property (nonatomic, strong) NSMutableArray *attrs;

@end

@implementation MRGridLayout

- (NSMutableArray *)attrs{
    
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


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger i = indexPath.item;
    
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = self.collectionView.frame.size.width * 0.5;
    CGFloat height = 0;
    
    if(i == 0) {
        height = width;
        attr.frame = CGRectMake(x, y, width, height);
    }else if(i == 1) {
        height = width * 0.5;
        x = width;
        attr.frame = CGRectMake(x, y, width, height);
    }else if(i == 2) {
        height = width * 0.5;
        x = width;
        y = height;
        attr.frame = CGRectMake(x, y, width, height);
    }else if(i == 3) {
        height = width * 0.5;
        y = width;
        attr.frame = CGRectMake(x, y, width, height);
    }else if(i == 4) {
        height = width * 0.5;
        y = width + height;
        attr.frame = CGRectMake(x, y, width, height);
    }else if(i == 5) {
        height = width;
        x = width;
        y = height;
        attr.frame = CGRectMake(x, y, width, height);
    }else {
        UICollectionViewLayoutAttributes *lastAttr = self.attrs[i-6];
        CGRect lastRect = lastAttr.frame;
        lastRect.origin.y += 2 * width;
        attr.frame = lastRect;
    }
    
    return attr;
}

- (CGSize)collectionViewContentSize {
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    NSInteger rows = (count + 3 - 1)/3;
    
    CGFloat rowHeight = self.collectionView.frame.size.width * 0.5;
    
    CGFloat y = rowHeight * rows;
    
    return CGSizeMake(0, y);
}
@end
