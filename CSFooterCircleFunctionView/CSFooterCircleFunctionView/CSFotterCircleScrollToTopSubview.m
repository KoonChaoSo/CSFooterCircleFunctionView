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
        [self _seutp];
    }
    return self;
}
#pragma mark - Private
- (void)_seutp
{
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_top"] highlightedImage:[UIImage imageNamed:@"bg_top_pressed"]];
    [self addSubview:self.imageView];
}

#pragma mark - WSScrollViewFooterCircleFunctionSubviewProtocol
+ (UIView <CSFooterCircleSubviewProtocol> *)setupSubviewWithSuperView:(UIView *)superview
{
    CSFotterCircleScrollToTopSubview *subview = [[CSFotterCircleScrollToTopSubview alloc] initWithFrame:superview.bounds];
    [subview setHighlighted:NO];
    return subview;
}

- (void)hideAnimation:(BOOL)animated completion:(CSCircleFunctionSubviewsAnimationCompletion)completion {
    if (animated && !self.isAnimating)
    {
//        if (self.isAnimating == YES) return;
        self.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            
            self.alpha = 0;
            
        } completion:^(BOOL finished) {
            self.hidden = YES;
            if (finished)
            {
                completion();
            }
        }];
    }
    else
    {
        if (self.alpha == 0)
        {
            self.alpha = 1;
        }
        self.hidden = YES;
    }
}

- (void)showAnimation:(BOOL)animated completion:(CSCircleFunctionSubviewsAnimationCompletion)completion {
    if (animated && !self.isAnimating)
    {
//        if (self.isAnimating == YES) return;
        self.isAnimating = YES;
        self.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            
            self.alpha = 1;
            
        } completion:^(BOOL finished) {
            self.hidden = NO;
            self.isAnimating = NO;
            if (finished)
            {
                completion();
            }
        }];
    }
    else
    {
        self.alpha = 1;
        self.hidden = NO;
    }
}

- (void)setHighlighted:(BOOL)isHighlighted
{
    [self.imageView setHighlighted:isHighlighted];
}


@end
