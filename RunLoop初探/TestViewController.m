//
//  TestViewController.m
//  RunLoop初探
//
//  Created by admin on 2018/2/6.
//  Copyright © 2018年 Calvin. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@property (nonatomic, strong) NSThread *thread;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL isStop;      // 是否停止

@end

@implementation TestViewController

- (void)dealloc
{
    NSLog(@"TestViewController 被释放");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.isStop = NO;
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(openNewThread) object:nil];
    [self.thread start];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.isStop = YES;
}

#pragma mark - Mothed
// 开启计时器
- (void)openNewThread
{
    // 定时器的初始化和runloop的开启
    self.timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(doSomethings) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
}

// 定时器中耗时的操作
- (void)doSomethings
{
    // 通过isStop这个属性去让线程自己判断是否需要退出
    if (self.isStop) {
        [self quit];
        return;
    }
    
    static int i = 0;
    i++;
    NSLog(@"第%d次调用", i);
}

// 退出
- (void)quit
{
    // 子线程的开启和关闭都放在子线程中去控制
    if ([[NSThread currentThread] isEqual:self.thread]) {
        [self cancel];
    }
    else {
        [self performSelector:@selector(cancel) onThread:self.thread withObject:nil waitUntilDone:YES];
    }
}

// 取消
- (void)cancel
{
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
    CFRunLoopStop(CFRunLoopGetCurrent());
}

@end
