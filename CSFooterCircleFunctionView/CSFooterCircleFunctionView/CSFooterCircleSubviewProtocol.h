//
//  CSFooterCircleSubviewProtocol
//  CSFooterCircleFunctionView
//
//  Created by ChaoSo on 2018/8/29.
//  Copyright © 2018年 ChaoSo. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    CSScrollViewFotterCircleScrolToTopType = 0, //置顶功能
    CSScrollViewFotterCircleShowSrcollIndexType, //显示第几个功能
} CSScrollViewFotterCircleFunctionType;


@protocol CSFooterCircleSubviewProtocol <NSObject>
//typedef void(^WSCircleFunctionSubviewsActionCompletion)(WSScrollViewFotterCircleFunctionType type,UIView <WSScrollViewFotterCircleFunctionSubviewsProtocol>* view);
typedef void(^CSCircleFunctionSubviewsAnimationCompletion)(void);

@required
+ (UIView <CSFooterCircleSubviewProtocol>*)setupSubviewWithSuperView:(UIView *)superview;

- (void)showAnimation:(BOOL)animated completion:(CSCircleFunctionSubviewsAnimationCompletion)completion;

- (void)hideAnimation:(BOOL)animated completion:(CSCircleFunctionSubviewsAnimationCompletion)completion;

- (void)setHighlighted:(BOOL)isHighlighted;
@optional
- (void)setIndex:(NSString *)index total:(NSString *)total;
@end
