//
//  MRLineLayout.m
//  PhotoGalleryDemo
//
//  Created by Andrew554 on 16/7/24.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "MRLineLayout.h"

@interface MRLineLayout ()

/**
 *  布局属性
 */
@property (nonatomic, strong) NSArray *attrs;

@end

@implementation MRLineLayout

- (NSArray *)attrs {
    
    if(!_attrs) {
        
        _attrs = [NSArray array];
        
    }
    
    return _attrs;
}

/**
 * 当collectionView的显示范围发生改变的时候，是否需要重新刷新布局
 * 一旦重新刷新布局，就会重新调用下面的方法：
 * 1.prepareLayout
 * 2.layoutAttributesForElementsInRect:方法
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    
    return YES;
}


/**
 * 在collectionView滑动停止之后collectionView的偏移量
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    
    // 计算出最终显示的矩形框 遍历该矩形框中的cell相对中心线的间距选择最合适的cell进行调整
    CGRect currentRect;
    currentRect.origin.x = proposedContentOffset.x;
    currentRect.origin.y = 0;
    currentRect.size = CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height);

    // 获得对应rect中super已经计算好的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:currentRect];
    
    // 计算collectionView最中心点的x值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 存放最小的间距值
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in array) {
        
        if(ABS(minDelta) > ABS(attr.center.x - centerX)) {
            
            minDelta = attr.center.x - centerX;
        }
    }
    
    // 修改原有的偏移量
    proposedContentOffset.x += minDelta;
    
    return proposedContentOffset;
}


/**
 * 用来做布局的初始化操作（不建议在init方法中进行布局的初始化操作)
 */
- (void)prepareLayout {
    
    [super prepareLayout];
    
    // 水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置内边距
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}

/**
 * UICollectionViewLayoutAttributes *attrs;
 * 1.一个cell对应一个UICollectionViewLayoutAttributes对象
 * 2.UICollectionViewLayoutAttributes对象决定了cell的frame
 * 这个方法的返回值是一个数组（数组里面存放着rect范围内所有元素的布局属性）
 * 这个方法的返回值决定了rect范围内所有元素的排布（frame）
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    // 获取super(UICollectionViweFlowLayout)已经计算好的布局属性
    NSArray *attrs = [super layoutAttributesForElementsInRect:rect];
    
    // 计算collectionView最中心点的x值 (等于collectionView的偏移量 + collectionView的宽度的一半)
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 在原有的布局属性上进行微调达到缩放的效果
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        
        // cell的中心点x值 和 collectionView的中心点x值的间距
        CGFloat delay = ABS(attr.center.x - centerX);
        
        // 根据间距计算cell的缩放比例
        CGFloat scale = 1 - (delay / self.collectionView.frame.size.width);
        
        // 设置缩放比例
        attr.transform3D = CATransform3DMakeScale(scale, scale, scale);
    }
    
    self.attrs = attrs;
    
    // 返回调整之后的布局属性数组
    return attrs;
}


/**
 * 重新刷新布局时会调用
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    return attr;
}
@end
