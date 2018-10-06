//
//  CSFooterCircleSubviewProtocol
//  CSFooterCircleFunctionView
//
//  Created by ChaoSo on 2018/8/29.
//  Copyright © 2018年 ChaoSo. All rights reserved.
//

#import "CSFotterCircleScrollToTopSubview.h"
@interface CSFotterCircleScrollToTopSubview()
@property (strong, nonatomic) UIImageView *imageView;

@property (assign, nonatomic) BOOL isAnimating;
@end

@implementation CSFotterCircleScrollToTopSubview

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_top"] highlightedImage:[UIImage imageNamed:@"bg_top_pressed"]];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [self.imageView setFrame:frame];
        [self addSubview:self.imageView];
    }
    return self;
}

#pragma mark - CSScrollViewFooterCircleFunctionSubviewProtocol
- (void)tableViewScrollDown:(UIView<CSFooterCircleViewProtocol> *)view index:(NSInteger)index {
    if (!self.hidden)
        [self setHidden:YES];
}

- (void)tableViewScrollStop:(UIView<CSFooterCircleViewProtocol> *)view {
    self.hidden = NO;
    [view showWithViewName:NSStringFromClass([self class])];
}

- (void)tableViewScrollUp:(UIView<CSFooterCircleViewProtocol> *)view index:(NSInteger)index {
    if (!self.hidden)
        [self setHidden:YES];
}

- (void)setHighlighted:(BOOL)isHighlighted
{
    [self.imageView setHighlighted:isHighlighted];
}


@end
