//
//  ViewController.m
//  PopupImages
//
//  Created by lic on 14/12/22.
//  Copyright (c) 2014年 lic. All rights reserved.
//

#import "ViewController.h"
#import "ImagesContainerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
    
    //test
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 90, 120)];
    [button1 setImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(showImages:) forControlEvents:UIControlEventTouchUpInside];
    button1.tag = 0;
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(140, 100, 90, 120)];
    [button2 setImage:[UIImage imageNamed:@"2.jpg"] forState:UIControlStateNormal];

    [button2 addTarget:self action:@selector(showImages:) forControlEvents:UIControlEventTouchUpInside];
    button2.tag = 1;
    [self.view addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(270, 100, 90, 120)];
    [button3 setImage:[UIImage imageNamed:@"3.jpg"] forState:UIControlStateNormal];
    
    [button3 addTarget:self action:@selector(showImages:) forControlEvents:UIControlEventTouchUpInside];
    button3.tag = 2;
    [self.view addSubview:button3];
}

- (void)showImages:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    NSArray *images = @[@"1.jpg", @"2.jpg", @"3.jpg"];
    
    ImagesContainerView *imagesView = [[ImagesContainerView alloc] initWithFrame:self.view.bounds andImages:images andStartRect:btn.frame];
    [imagesView showImageItem:btn.tag];
    [self.view addSubview:imagesView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
