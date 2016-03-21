//
//  SplitView.m
//  SliptImageDemo
//
//  Created by Commoner on 16/3/21.
//  Copyright © 2016年 Commoner. All rights reserved.
//

#import "SplitView.h"
#import "UIImage+SplitImage.h"

@interface SplitView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) BOOL isSpliting;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;

@end

@implementation SplitView

- (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image{
    if (self = [super initWithFrame:frame]) {
        // 初始化ImageView
        self.imageView = [[UIImageView alloc]initWithFrame:frame];
        self.imageView.image = image;
        [self addSubview:self.imageView];
        
        // 添加捏合手势
        UIPinchGestureRecognizer *pinchRecognizer =[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
        [self addGestureRecognizer:pinchRecognizer];
    }

    return self;
}

- (void)pinch:(UIPinchGestureRecognizer *)pinRecognizer {

    if (pinRecognizer.state == UIGestureRecognizerStateBegan) {
        
        if (pinRecognizer.scale > 1) {
            
            self.isSpliting = YES;
            
            NSArray *array = [UIImage splitImageIntoTwoParts:self.imageView.image];
        
            self.leftImageView = [[UIImageView alloc]initWithFrame:self.frame];
            self.leftImageView.image = [array objectAtIndex:0];
            
            self.rightImageView = [[UIImageView alloc]initWithFrame:self.frame];
            self.rightImageView.image = [array objectAtIndex:1];
            
            [self addSubview: self.leftImageView];
            [self addSubview: self.rightImageView];
            [self.imageView setHidden:YES];
            
        }else {
            self.isSpliting = NO;
        }
    }else if (pinRecognizer.state == UIGestureRecognizerStateChanged) {
    
        if (self.isSpliting) {
            self.leftImageView.transform = CGAffineTransformMakeTranslation(-160*(pinRecognizer.scale -1), 0);
            self.rightImageView.transform = CGAffineTransformMakeTranslation(160*(pinRecognizer.scale -1), 0);
            
        }
        
        
    }else if (pinRecognizer.state == UIGestureRecognizerStateEnded) {
    
        [UIView beginAnimations:@"split" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        self.leftImageView.transform = CGAffineTransformIdentity;
        self.rightImageView.transform = CGAffineTransformIdentity;
        [UIView commitAnimations];
    }

}


-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([animationID isEqualToString:@"split"] && finished) {
        self.imageView.hidden = NO;
        [self.leftImageView removeFromSuperview];
        [self.rightImageView removeFromSuperview];
    }
    
}






























@end
