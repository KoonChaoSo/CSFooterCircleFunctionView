//
//  CSFooterCircleSubviewProtocol
//  CSFooterCircleFunctionView
//
//  Created by ChaoSo on 2018/8/29.
//  Copyright © 2018年 ChaoSo. All rights reserved.
//

#import "UIScrollView+CSFooterCircleFuntionExtension.h"
#import <objc/runtime.h>
@implementation UIScrollView (CSFooterCircleFuntionExtension)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod([UIScrollView class], @selector(setDelegate:));
        Method replaceMethod = class_getInstanceMethod([UIScrollView class], @selector(hook_setDelegate:));
        method_exchangeImplementations(originalMethod, replaceMethod);
    });
}

- (void)hook_setDelegate:(id<UIScrollViewDelegate>)delegate {
    [self hook_setDelegate:delegate];
    
    if ([self isKindOfClass:[UIScrollView class]]) {
        //Hook (scrollViewDidEndDecelerating:) 方法
        Hook_Method([delegate class], @selector(scrollViewDidEndDecelerating:), [self class], @selector(p_scrollViewDidEndDecelerating:), @selector(add_scrollViewDidEndDecelerating:));
        
        //Hook (scrollViewDidEndDragging:willDecelerate:) 方法
        Hook_Method([delegate class], @selector(scrollViewDidEndDragging:willDecelerate:), [self class], @selector(p_scrollViewDidEndDragging:willDecelerate:), @selector(add_scrollViewDidEndDragging:willDecelerate:));
    } else {
    }
}


- (void)p_scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self p_scrollViewDidEndDecelerating:scrollView];
    // 停止类型1、停止类型2
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
    if (scrollToScrollStop) {
        [scrollView stopScroll:scrollView];
    }
}

- (void)p_scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self p_scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    if (!decelerate) {
        // 停止类型3
        BOOL dragToDragStop = scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
        if (dragToDragStop) {
            [scrollView stopScroll:scrollView];
        }
    }
}

// 那没有实现需要hook的代理方法时，调用此处方法
- (void)add_scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 停止类型1、停止类型2
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
    if (scrollToScrollStop) {
        [scrollView stopScroll:scrollView];
    }
}

- (void)add_scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        // 停止类型3
        BOOL dragToDragStop = scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
        if (dragToDragStop) {
            [scrollView stopScroll:scrollView];
        }
    }
}

static const char p_stopScrollBlock = '\0';
- (StopScrollBlock)stopScrollBlock {
    return objc_getAssociatedObject(self, &p_stopScrollBlock);
}

- (void)setStopScrollBlock:(StopScrollBlock)stopScrollBlock {
    objc_setAssociatedObject(self, &p_stopScrollBlock, stopScrollBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)stopScroll:(UIScrollView *)scrollView {
    if (self.stopScrollBlock) {
        self.stopScrollBlock(scrollView);
    }
}

static void Hook_Method(Class originalClass, SEL originalSel, Class replacedClass, SEL replacedSel, SEL noneSel){
    // 原实例方法
    Method originalMethod = class_getInstanceMethod(originalClass, originalSel);
    // 替换的实例方法
    Method replacedMethod = class_getInstanceMethod(replacedClass, replacedSel);
    // 如果没有实现 delegate 方法，则手动动态添加
    if (!originalMethod) {
        Method noneMethod = class_getInstanceMethod(replacedClass, noneSel);
        BOOL addNoneMethod = class_addMethod(originalClass, originalSel, method_getImplementation(noneMethod), method_getTypeEncoding(noneMethod));
        if (addNoneMethod) {
        }
        return;
    }
    // 向实现 delegate 的类中添加新的方法
    // 这里是向 originalClass 的 replaceSel（@selector(p_scrollViewDidEndDecelerating:)） 添加 replaceMethod
    BOOL addMethod = class_addMethod(originalClass, replacedSel, method_getImplementation(replacedMethod), method_getTypeEncoding(replacedMethod));
    if (addMethod) {
        // 添加成功
        // 重新拿到添加被添加的 method,这里是关键(注意这里 originalClass, 不 replacedClass), 因为替换的方法已经添加到原类中了, 应该交换原类中的两个方法
        Method newMethod = class_getInstanceMethod(originalClass, replacedSel);
        // 实现交换
        method_exchangeImplementations(originalMethod, newMethod);
    }else{
        // 添加失败，则说明已经 hook 过该类的 delegate 方法，防止多次交换。
    }
}
@end
