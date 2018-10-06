//
//  CSFooterCircleSubviewProtocol
//  CSFooterCircleFunctionView
//
//  Created by ChaoSo on 2018/8/29.
//  Copyright © 2018年 ChaoSo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CSFooterCircleFunctionView;
@protocol CSFooterCircleViewProtocol <NSObject>

- (void)showWithViewName:(NSString *)viewName;

- (void)hideWithViewName:(NSString *)viewName;

- (void)hide;
@end

@protocol CSFooterCircleSubviewProtocol <NSObject>
typedef void(^CSCircleFunctionSubviewsAnimationCompletion)(void);

@required
/**
 subview是否显示高亮

 @param isHighlighted 
 */
- (void)setHighlighted:(BOOL)isHighlighted;

/**
 父tableview控件向上滑动
    TODO: 需要使用加上willtableViewScrollUp回调，因为有些时候是需要状态的改变而不是持续的状态回调
 @param view CSFooterCircleFunctionView
 @param index 滑动时候显示的cell的index
 @param total 滑动时候显示的cell的总共的数量
 */

- (void)tableViewScrollUp:(UIView<CSFooterCircleViewProtocol> *)view index:(NSInteger)index;

/**
 父tableview控件向下滑动
 TODO: 需要使用加上willScrollDown回调，因为有些时候是需要状态的改变而不是持续的状态回调
 @param view CSFooterCircleFunctionView
 @param index 滑动时候显示的cell的index
 @param total 滑动时候显示的cell的总共的数量
 */
- (void)tableViewScrollDown:(UIView<CSFooterCircleViewProtocol> *)view index:(NSInteger)index;

/**
 父tableview控件停止滑动
 TODO: 需要使用加上willtableViewScrollStop回调，因为有些时候是需要状态的改变而不是持续的状态回调
 @param view CSFooterCircleFunctionView
 */
- (void)tableViewScrollStop:(UIView<CSFooterCircleViewProtocol> *)view;

@end
