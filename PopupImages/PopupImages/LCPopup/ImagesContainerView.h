//
//  ImagesContainerView.h
//  PopupImages
//
//  Created by lic on 15/4/29.
//  Copyright (c) 2015年 lic. All rights reserved.
//
/**
 *  图片容器--加载多张图片，滑动缩放查看
 */

#import <UIKit/UIKit.h>
#import "ImageItem.h"

@interface ImagesContainerView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) UIView* maskView;
@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) NSMutableArray* imagePages;
@property (nonatomic, strong) UIPageControl* pageControl;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, assign) CGRect startRect;
@property (nonatomic, assign) CGSize firstImageSize;
@property (nonatomic, strong) ImageItem *imageItem;

- (id)initWithFrame:(CGRect)frame andImages:(NSArray *)images andStartRect:(CGRect)rect;
- (void)setCurrentPageScrollView:(NSInteger)index;
- (void)showImageItem:(NSInteger)index;

@end
