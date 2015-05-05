//
//  ImageItem.h
//  PopupImages
//
//  Created by lic on 15/4/29.
//  Copyright (c) 2015年 lic. All rights reserved.
//
/**
 *  可缩放的view
 */
#import <UIKit/UIKit.h>

@interface ImageItem : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *rimView;
@property (nonatomic, strong) UIScrollView *scrollView;

- (id)initWithFrame:(CGRect)frame andImage:(UIImage *)image;

@end
