//
//  CSFooterCircleSubviewProtocol
//  CSFooterCircleFunctionView
//
//  Created by ChaoSo on 2018/8/29.
//  Copyright © 2018年 ChaoSo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSFooterCircleSubviewProtocol.h"
#import "UIScrollView+CSFooterCircleFuntionExtension.h"

typedef void(^WSClickActionCompletion)(WSScrollViewFotterCircleFunctionType type,UIView<CSFooterCircleSubviewProtocol> *subview);
typedef void(^WSShowIndexCompletion)(WSScrollViewFotterCircleFunctionType type,UIView<CSFooterCircleSubviewProtocol> *subview,NSUInteger index);
@interface CSFooterCircleFunctionView : UIView

@property (copy, nonatomic) WSClickActionCompletion actionCompletion;
@property (copy, nonatomic) WSShowIndexCompletion showIndexCompletion;
@property (weak, nonatomic) UITableView *weakTableView;

- (instancetype)initWithTypes:(NSArray *)types;
- (void)showWithType:(WSScrollViewFotterCircleFunctionType)type;
- (void)hide;

- (void)showIndexViewWithIndex:(NSString *)index total:(NSString *)total;
@end
