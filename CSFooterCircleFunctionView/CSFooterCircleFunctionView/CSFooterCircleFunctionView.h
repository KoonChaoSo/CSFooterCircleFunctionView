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

typedef void(^CSClickActionCompletion)(CSScrollViewFotterCircleFunctionType type,UIView<CSFooterCircleSubviewProtocol> *subview);
typedef void(^CSShowIndexCompletion)(CSScrollViewFotterCircleFunctionType type,UIView<CSFooterCircleSubviewProtocol> *subview,NSUInteger index);
@interface CSFooterCircleFunctionView : UIView

@property (copy, nonatomic) CSClickActionCompletion actionCompletion;
@property (copy, nonatomic) CSShowIndexCompletion showIndexCompletion;
@property (weak, nonatomic) UITableView *weakTableView;

- (instancetype)initWithSubViews:(NSArray<CSFooterCircleSubviewProtocol> *)subViews;
- (void)showWithViewName:(NSString *)viewName;
- (void)hide;

@end
