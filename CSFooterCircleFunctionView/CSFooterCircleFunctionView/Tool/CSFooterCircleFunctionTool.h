//
//  CSFooterCircleSubviewProtocol
//  CSFooterCircleFunctionView
//
//  Created by ChaoSo on 2018/8/29.
//  Copyright © 2018年 ChaoSo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define force_inline __inline__ __attribute__((always_inline))
static force_inline UIColor *UIColorFromHexWithAlpha(int hexValue, CGFloat a) {
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:a];
}

static force_inline UIColor *UIColorFromHex(int hexValue) {
    return UIColorFromHexWithAlpha(hexValue, 1.0);
}
@interface CSFooterCircleFunctionTool : NSObject

@end
