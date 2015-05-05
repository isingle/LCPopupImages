//
//  UIImage+LCImage.m
//  PopupImages
//
//  Created by lic on 15/4/29.
//  Copyright (c) 2015年 lic. All rights reserved.
//

#import "UIImage+LCImage.h"

@implementation UIImage (LCImage)

+ (CGFloat)getScaleWithImageSize:(CGSize)imgSize andZoneSize:(CGSize)zoneSize
{
    CGFloat scale = 1.0;
    CGFloat width = zoneSize.width;
    CGFloat height = zoneSize.height;
    CGFloat imgWd = imgSize.width;
    CGFloat imgHt = imgSize.height;
    
    if (imgWd > width && imgHt <= height) {
        scale = width / imgWd;
    }else if (imgHt > height && imgWd <= width){
        scale = height / imgHt;
    }else{
        CGFloat sw = width / imgWd;
        CGFloat sh = height / imgHt;
        scale = (sw > sh) ? sh : sw;
    }
    return scale;
}

@end
