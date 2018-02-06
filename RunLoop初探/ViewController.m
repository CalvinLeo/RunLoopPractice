//
//  ViewController.m
//  RunLoop初探
//
//  Created by admin on 2018/2/6.
//  Copyright © 2018年 Calvin. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 150) * 0.5, 200, 150, 30)];
    [button setTitle:@"跳转" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(jumpToNextController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)jumpToNextController
{
    TestViewController *vc = [[TestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
