//
//  UIControl+Custom.m
//  Ttt
//
//  Created by wanggy820 on 16/8/27.
//  Copyright © 2016年 wanggy820. All rights reserved.
//

#import "UIControl+Custom.h"
#import <objc/runtime.h>


/**
 *  UISwitch 需要特殊处理
 */
@implementation UIControl (Custom)

+ (void)load{
    Method systemMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    SEL systemSEL = @selector(sendAction:to:forEvent:);
    Method customMethod = class_getInstanceMethod(self, @selector(custom_sendAction:to:forEvent:));
    SEL customSEL = @selector(custom_sendAction:to:forEvent:);
    //先添加方法 如果方法已经存在，就替换原方法
    BOOL didAddMethod = class_addMethod(self, systemSEL, method_getImplementation(customMethod), method_getTypeEncoding(customMethod));
    if (didAddMethod) {//如果有，替换方法，没有则exchange
        class_replaceMethod(self, customSEL, method_getImplementation(customMethod), method_getTypeEncoding(customMethod));
    }else{
        method_exchangeImplementations(systemMethod, customMethod);
    }
}

- (void)setCustom_acceptEventInterval:(NSTimeInterval)custom_acceptEventInterval{
    if (custom_acceptEventInterval < 0) {
        custom_acceptEventInterval = 0;
    }
    objc_setAssociatedObject(self, @"UIControll_acceptEventInterval", @(custom_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)custom_acceptEventInterval{
    return [objc_getAssociatedObject(self, @"UIControll_acceptEventInterval") doubleValue];
}

- (void)setCustom_acceptEventTime:(NSTimeInterval)custom_acceptEventTime{
    objc_setAssociatedObject(self, @"UIControll_acceptEventTime", @(custom_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)custom_acceptEventTime{
    return [objc_getAssociatedObject(self, @"UIControll_acceptEventTime") doubleValue];
}

- (void)custom_sendAction:(SEL)action to:(nullable id)target forEvent:(nullable UIEvent *)event{
    if ([self isKindOfClass:[UISwitch class]]) {
        [self custom_sendAction:action to:target forEvent:event];
    }
    BOOL needSendAction = ([[NSDate date] timeIntervalSince1970] - self.custom_acceptEventTime >= self.custom_acceptEventInterval);
    
    if (needSendAction) {
        [self custom_sendAction:action to:target forEvent:event];
        self.custom_acceptEventTime = [[NSDate date] timeIntervalSince1970];
    }
}


@end
