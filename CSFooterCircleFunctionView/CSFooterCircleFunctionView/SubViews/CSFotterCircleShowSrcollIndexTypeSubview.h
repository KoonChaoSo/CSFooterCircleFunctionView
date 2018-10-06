//
//  CSFooterCircleSubviewProtocol
//  CSFooterCircleFunctionView
//
//  Created by ChaoSo on 2018/8/29.
//  Copyright © 2018年 ChaoSo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSFooterCircleSubviewProtocol.h"

@interface CSFotterCircleShowSrcollIndexTypeSubview : UIView<CSFooterCircleSubviewProtocol>
- (void)setHighlighted:(BOOL)isHighlighted;
@property (assign, nonatomic) NSUInteger total;
@end
