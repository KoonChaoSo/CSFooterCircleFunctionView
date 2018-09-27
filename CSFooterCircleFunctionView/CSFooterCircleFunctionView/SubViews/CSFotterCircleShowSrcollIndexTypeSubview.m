//
//  CSFooterCircleSubviewProtocol
//  CSFooterCircleFunctionView
//
//  Created by ChaoSo on 2018/8/29.
//  Copyright © 2018年 ChaoSo. All rights reserved.
//

#import "CSFotterCircleShowSrcollIndexTypeSubview.h"
#import "CSFooterCircleFunctionTool.h"
@interface CSFotterCircleShowSrcollIndexTypeSubview()
@property (nonatomic, strong) UIImageView *bgView;

@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) UILabel *totlaLabel;
@end
@implementation CSFotterCircleShowSrcollIndexTypeSubview

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_top2"] highlightedImage:[UIImage imageNamed:@"bg_top2_pressed"]];
        
        self.frame = _bgView.bounds;
        [self addSubview:_bgView];
        
        self.indexLabel = [UILabel new];
        _indexLabel.backgroundColor = [UIColor clearColor];
        _indexLabel.font = [UIFont systemFontOfSize:10];
        _indexLabel.textColor = UIColorFromHex(0x333333);
        
        [self addSubview:_indexLabel];
        
        self.totlaLabel = [UILabel new];
        _totlaLabel.backgroundColor = [UIColor clearColor];
        _totlaLabel.font = [UIFont systemFontOfSize:10];
        _totlaLabel.textColor = UIColorFromHex(0x333333);
        
        [self addSubview:_totlaLabel];
        
    }
    return self;
}


- (void)setHighlighted:(BOOL)isHighlighted
{
    [_bgView setHighlighted:isHighlighted];
}

- (void)hideAnimation:(BOOL)animated completion:(CSCircleFunctionSubviewsAnimationCompletion)completion {
    if (animated)
    {
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
        self.alpha = 0;
        self.hidden = YES;
    }
}

- (void)showAnimation:(BOOL)animated completion:(CSCircleFunctionSubviewsAnimationCompletion)completion {
    if (animated)
    {
        self.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            
            self.alpha = 1;
            
        } completion:^(BOOL finished) {
            self.hidden = NO;
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

+ (UIView<CSFooterCircleSubviewProtocol> *)setupSubviewWithSuperView:(UIView *)superview {
    CSFotterCircleShowSrcollIndexTypeSubview *subview = [[CSFotterCircleShowSrcollIndexTypeSubview alloc] initWithFrame:superview.bounds];
    [subview setHighlighted:NO];
    return subview;
}

- (void)tableViewScrollDown:(CSFooterCircleFunctionView *)view index:(NSInteger)index {
    
}


- (void)tableViewScrollStop:(CSFooterCircleFunctionView *)view {
    <#code#>
}


- (void)tableViewScrollUp:(CSFooterCircleFunctionView *)view index:(NSInteger)index {
    <#code#>
}



@end
