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

typedef void(^CSClickActionCompletion)(NSString *viewName,UIView<CSFooterCircleSubviewProtocol> *subview);

@interface CSFooterCircleFunctionView : UIView<CSFooterCircleViewProtocol>
@property (copy, nonatomic) CSClickActionCompletion actionCompletion; //点击的回调
@property (weak, nonatomic) UITableView *weakTableView;     //需要监听的tableview

- (instancetype)initWithSubViews:(NSArray<CSFooterCircleSubviewProtocol> *)subViews;

#pragma mark - CSFooterCircleViewProtocol
- (void)showWithViewName:(NSString *)viewName;
- (void)hide;

@end
