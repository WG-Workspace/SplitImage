//
//  ViewController.m
//  SliptImageDemo
//
//  Created by Commoner on 16/3/21.
//  Copyright © 2016年 Commoner. All rights reserved.
//

#import "ViewController.h"
#import "SplitView.h"

@interface ViewController ()

@property (nonatomic, strong) SplitView *splitView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.splitView = [[SplitView alloc]initWithFrame:CGRectMake(0, 0, 375, 400) andImage:[UIImage imageNamed:@"1.jpg"]];
    
    [self.view addSubview:self.splitView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
