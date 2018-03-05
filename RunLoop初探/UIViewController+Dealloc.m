//
//  UIViewController+Dealloc.m
//  RunLoop初探
//
//  Created by Mr Gao on 2018/3/5.
//  Copyright © 2018年 Calvin. All rights reserved.
//

#import "UIViewController+Dealloc.h"

@implementation UIViewController (Dealloc)

+ (void)load
{
    Method originMothed = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method newMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"customDealloc"));
    method_exchangeImplementations(originMothed, newMethod);
}

- (void)customDealloc
{
    NSLog(@"%@ 被释放了", NSStringFromClass([self class]));
    [self customDealloc];
}

@end
