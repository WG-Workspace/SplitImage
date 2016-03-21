//
//  SplitView.h
//  SliptImageDemo
//
//  Created by Commoner on 16/3/21.
//  Copyright © 2016年 Commoner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplitView : UIView

@property (nonatomic, strong) UIImage *splitImage;


- (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image;

@end
