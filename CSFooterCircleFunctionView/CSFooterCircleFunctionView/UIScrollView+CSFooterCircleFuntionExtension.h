//
//  CSFooterCircleSubviewProtocol
//  CSFooterCircleFunctionView
//
//  Created by ChaoSo on 2018/8/29.
//  Copyright © 2018年 ChaoSo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^StopScrollBlock)(UIScrollView *view);
@interface UIScrollView (CSFooterCircleFuntionExtension)
@property(nonatomic, copy) StopScrollBlock stopScrollBlock;
@end
