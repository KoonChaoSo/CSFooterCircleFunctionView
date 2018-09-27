//
//  CSFooterCircleSubviewProtocol
//  CSFooterCircleFunctionView
//
//  Created by ChaoSo on 2018/8/29.
//  Copyright © 2018年 ChaoSo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CSFooterCircleFunctionView;

@protocol CSFooterCircleSubviewProtocol <NSObject>
typedef void(^CSCircleFunctionSubviewsAnimationCompletion)(void);

@required
+ (UIView <CSFooterCircleSubviewProtocol>*)setupSubviewWithSuperView:(UIView *)superview;
//
//- (void)showAnimation:(BOOL)animated completion:(CSCircleFunctionSubviewsAnimationCompletion)completion;
//
//- (void)hideAnimation:(BOOL)animated completion:(CSCircleFunctionSubviewsAnimationCompletion)completion;
//

//@optional
//- (void)setIndex:(NSString *)index total:(NSString *)total;


//new delegate


/**
 subview是否显示高亮

 @param isHighlighted 
 */
- (void)setHighlighted:(BOOL)isHighlighted;
/**
 父tableview控件向上滑动

 @param view CSFooterCircleFunctionView
 @param index 滑动时候显示的cell的index
 @param total 滑动时候显示的cell的总共的数量
 */
- (void)tableViewScrollUp:(CSFooterCircleFunctionView *)view index:(NSInteger)index;

/**
 父tableview控件向下滑动
 
 @param view CSFooterCircleFunctionView
 @param index 滑动时候显示的cell的index
 @param total 滑动时候显示的cell的总共的数量
 */
- (void)tableViewScrollDown:(CSFooterCircleFunctionView *)view index:(NSInteger)index;

/**
 父tableview控件停止滑动
 
 @param view CSFooterCircleFunctionView
 */
- (void)tableViewScrollStop:(CSFooterCircleFunctionView *)view;

@end
