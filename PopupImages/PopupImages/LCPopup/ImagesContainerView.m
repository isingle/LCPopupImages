//
//  ImagesContainerView.m
//  PopupImages
//
//  Created by lic on 15/4/29.
//  Copyright (c) 2015年 lic. All rights reserved.
//

#import "ImagesContainerView.h"
#import "UIImage+LCImage.h"

#define kScrollViewForPageControll      5001
#define KScrollViewForZoom              5002
#define kZoneSizeWidth  300
#define kZoneSizeHeight 400

@implementation ImagesContainerView


- (id)initWithFrame:(CGRect)frame andImages:(NSArray *)images andStartRect:(CGRect)rect
{
    self = [super initWithFrame:frame];
    if (self) {
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.maskView.backgroundColor = [UIColor blackColor];
        self.maskView.alpha = 0.8f;
        [self addSubview:self.maskView];
        
        self.startRect = rect;

        NSInteger nCount = [images count];
        self.images = [[NSMutableArray alloc] init];
        self.imagePages = [[NSMutableArray alloc] init];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.scrollView setDelegate:self];
        [self.scrollView setTag:kScrollViewForPageControll];
        [self.scrollView setPagingEnabled:YES];
        [self.scrollView setContentSize:CGSizeMake(frame.size.width * nCount, frame.size.height)];
        [self.scrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self addSubview:self.scrollView];
        
        [self loadImagePages:images];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSelfView)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)loadImagePages:(NSArray *)paths
{
    CGFloat scale;
    NSString *name;
    UIImage *image;
    CGSize size;
    NSString *path;
    NSInteger count = paths.count;
    for (NSInteger i=0; i<count; i++) {
        name = [paths objectAtIndex:i];
        path = [[NSBundle mainBundle] pathForResource:name ofType:nil];
        if (path == nil) continue;
        
        image = [UIImage imageWithContentsOfFile:path];
        
        scale = [UIImage getScaleWithImageSize:image.size andZoneSize:CGSizeMake(kZoneSizeWidth, kZoneSizeHeight)];
        size = CGSizeMake(image.size.width * scale, image.size.height * scale);
        if (i == 0) {
//            self.startRect = rect;
//            self.firstImageSize = size;
        }
        
        ImageItem *page = [[ImageItem alloc] initWithFrame:CGRectMake(0 + (self.frame.size.width * i), 0, self.frame.size.width, self.frame.size.height) andImage:image];
        [self.scrollView addSubview:page];
        
        [self.images addObject:image];
        [self.imagePages addObject:page];
        
    }
    
    if (count > 1) {
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [self.pageControl setCenter:CGPointMake(self.frame.size.width * 0.5, self.frame.size.height - 50)];
        [self.pageControl setNumberOfPages:count];
        [self.pageControl setCurrentPage:0];
        [self addSubview:self.pageControl];
    }

}

- (void)showImageItem:(NSInteger)index
{
//    CGRect frame = self.bounds;
//    ImageItem *page = [self.imagePages objectAtIndex:index];
//    CGRect pageFrame = CGRectMake((frame.size.width - self.firstImageSize.width) * 0.5 - 10,
//                                  (frame.size.height - self.firstImageSize.height) * 0.5 - 10,
//                                  self.firstImageSize.width + 20,
//                                  self.firstImageSize.height + 20);
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.2f];
//    [self.maskView setAlpha:0.75];
//    [page.rimView setFrame:pageFrame];
//    [page.imageView setFrame:CGRectMake(10, 10, pageFrame.size.width - 20, pageFrame.size.height - 20)];
//    [UIView commitAnimations];
    [self setCurrentPageScrollView:index];
}

- (void)hideSelfView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(hideViewCallback)];
    [self setAlpha:0.0f];
    [self.imageItem.rimView setFrame:self.startRect];
    [self.imageItem.imageView setFrame:self.startRect];
    [UIView commitAnimations];
}

- (void)hideViewCallback
{
    [self removeFromSuperview];
}

- (void)setCurrentPageScrollView:(NSInteger)index
{
    if (index >= 0 && self.images.count > 1) {
        [self.scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width*index, 0) animated:NO];
        [self.pageControl setCurrentPage:index];
    }
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView tag] == KScrollViewForZoom) return;
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    NSLog(@"==>> page = %d", page);
    self.pageControl.currentPage = page;
    self.imageItem = [self.imagePages objectAtIndex:page];
}

@end
