//
//  MRPhotoViewCell.m
//  PhotoGalleryDemo
//
//  Created by Andrew554 on 16/7/24.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "MRPhotoViewCell.h"

@interface MRPhotoViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation MRPhotoViewCell

- (void)setImageName:(NSString *)imageName {
    
    _imageName = [imageName copy];
    
    self.imageView.image = [UIImage imageNamed:imageName];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 设置边框: 给图层上添加边框
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.borderWidth = 5;
}

@end
