//
//  ImageItem.m
//  PopupImages
//
//  Created by lic on 15/4/29.
//  Copyright (c) 2015年 lic. All rights reserved.
//

#import "ImageItem.h"
#import "UIImage+LCImage.h"

#define kZoneSizeWidth  300
#define kZoneSizeHeight 400

@implementation ImageItem

- (id)initWithFrame:(CGRect)frame andImage:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.scrollView setDelegate:self];
        [self.scrollView setMinimumZoomScale:0.5];
        [self.scrollView setMaximumZoomScale:5.0];
        [self.scrollView setDecelerationRate:1.0];
        [self.scrollView setZoomScale:1.0];
        [self.scrollView setContentSize:CGSizeMake(frame.size.width, frame.size.height)];
        [self.scrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self addSubview:self.scrollView];
        
        CGFloat scale = [UIImage getScaleWithImageSize:image.size andZoneSize:CGSizeMake(kZoneSizeWidth, kZoneSizeHeight)];
        CGSize imageSize = CGSizeMake(image.size.width * scale, image.size.height * scale);
        
        _rimView = [[UIView alloc] initWithFrame:CGRectMake((frame.size.width-imageSize.width-20)*0.5, (frame.size.height-imageSize.height-20)*0.5, imageSize.width+20, imageSize.height+20)];
        _rimView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:_rimView];
        
//        _rimView.layer.cornerRadius = 5;
//        _rimView.layer.masksToBounds = YES;
        
        _imageView = [[UIImageView alloc] initWithImage:image];
        _imageView.frame = CGRectMake(10, 10, imageSize.width, imageSize.height);
        [_rimView addSubview:_imageView];
        
    }
    
    return self;
}

#pragma mark ==== scrollview delegate ====
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _rimView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.rimView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                      scrollView.contentSize.height * 0.5 + offsetY);
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2f];
    view.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                              scrollView.contentSize.height * 0.5 + offsetY);
    [UIView commitAnimations];
}

@end
