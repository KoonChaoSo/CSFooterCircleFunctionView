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
@property (nonatomic, strong) UILabel *totalLabel;
@end
@implementation CSFotterCircleShowSrcollIndexTypeSubview

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_top2"] highlightedImage:[UIImage imageNamed:@"bg_top2_pressed"]];
        [self.bgView setContentMode:UIViewContentModeScaleAspectFill];
        [self.bgView setFrame:frame];
        [self addSubview:_bgView];
        
        _indexLabel = [UILabel new];
        _indexLabel.backgroundColor = [UIColor clearColor];
        _indexLabel.font = [UIFont systemFontOfSize:10];
        _indexLabel.textColor = UIColorFromHex(0x333333);
        [_indexLabel setTextAlignment:NSTextAlignmentCenter];
        
        [self addSubview:_indexLabel];
        
        _totalLabel = [UILabel new];
        _totalLabel.backgroundColor = [UIColor clearColor];
        _totalLabel.font = [UIFont systemFontOfSize:10];
        _totalLabel.textColor = UIColorFromHex(0x333333);
        [_totalLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_totalLabel];
        
        _indexLabel.frame = CGRectMake(0, 0, _bgView.frame.size.width, _bgView.frame.size.height/2 + 5);
        _totalLabel.frame = CGRectMake(0, _bgView.frame.size.height/2, _bgView.frame.size.width, _bgView.frame.size.height/2);
    }
    return self;
}

#pragma mark - CSFooterCircleSubviewProtocol
- (void)tableViewScrollDown:(UIView<CSFooterCircleViewProtocol> *)view index:(NSInteger)index {
    if (self.hidden)
    {
        self.hidden = NO;
    }
    [view showWithViewName:NSStringFromClass([self class])];
    
    NSString *indexStr = [NSString stringWithFormat:@"%ld",(long)index];
    [self.indexLabel setText:indexStr];
}

- (void)tableViewScrollStop:(UIView<CSFooterCircleViewProtocol> *)view {
    [view hideWithViewName:NSStringFromClass([self class])];
    self.hidden = YES;
}

- (void)tableViewScrollUp:(UIView<CSFooterCircleViewProtocol> *)view index:(NSInteger)index {
    if (self.hidden)
    {
        self.hidden = NO;
    }
    [view showWithViewName:NSStringFromClass([self class])];
    
    NSString *indexStr = [NSString stringWithFormat:@"%ld",(long)index];
    [self.indexLabel setText:indexStr];
}

- (void)setHighlighted:(BOOL)isHighlighted
{

}

#pragma mark - Setter
- (void)setTotal:(NSUInteger)total
{
    _total = total;
    _totalLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)_total];

}

@end
