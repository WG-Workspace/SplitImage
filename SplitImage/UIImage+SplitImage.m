//
//  UIImage+SplitImage.m
//  SliptImageDemo
//
//  Created by Commoner on 16/3/21.
//  Copyright © 2016年 Commoner. All rights reserved.
//

#import "UIImage+SplitImage.h"

#define SAWTOOTH_COUNT 15
#define SAWTOOTH_WIDTH_FACTOR 30

@implementation UIImage (SplitImage)

+ (NSArray *)splitImageIntoTwoParts:(UIImage *)image {
    CGFloat scale = [UIScreen mainScreen].scale;
    NSMutableArray *array = [NSMutableArray array];;
    
    CGFloat width,height,widthgap,heightgap;
    int piceCount = SAWTOOTH_COUNT;
    width = image.size.width;
    height = image.size.height;
    widthgap = width / SAWTOOTH_WIDTH_FACTOR;
    heightgap = height / piceCount;
    
    
    CGContextRef context;
    CGImageRef imageMasked;
    UIImage *leftImage , *rightImage;
    
    UIGraphicsBeginImageContext(CGSizeMake(width*scale, height *scale));
    context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, scale, scale);
    CGContextMoveToPoint(context, 0, 0);
    
    int a = -1;
    
    for (int i = 0; i<piceCount + 1; i++) {
        CGContextAddLineToPoint(context, width/2+(widthgap * a), heightgap * i);
        a = a * -1;
        
    }
    CGContextAddLineToPoint(context, 0, height);
    CGContextClosePath(context);
    CGContextClip(context);
    [image drawAtPoint:CGPointMake(0, 0)];
    
    imageMasked = CGBitmapContextCreateImage(context);
    leftImage = [UIImage imageWithCGImage:imageMasked scale:scale orientation:UIImageOrientationUp];
    
    [array addObject:leftImage];
    
    UIGraphicsEndImageContext();
    
    
    
    UIGraphicsBeginImageContext(CGSizeMake(width*scale, height*scale));
    
    context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, scale, scale);
    CGContextMoveToPoint(context, width, 0);
    
    a=-1;
    
    for (int i = 0; i<piceCount + 1; i++) {
        CGContextAddLineToPoint(context, width/2+(widthgap * a), heightgap * i);
        a = a * -1;
    }
    CGContextAddLineToPoint(context, width, height);
    CGContextClosePath(context);
    CGContextClip(context);
    [image drawAtPoint:CGPointMake(0, 0)];
    imageMasked = CGBitmapContextCreateImage(context);
    rightImage = [UIImage imageWithCGImage:imageMasked scale:scale orientation:UIImageOrientationUp];
    
    [array addObject:rightImage];
    
    UIGraphicsEndImageContext();
    
    
    return array.copy;
    
    
}

@end
