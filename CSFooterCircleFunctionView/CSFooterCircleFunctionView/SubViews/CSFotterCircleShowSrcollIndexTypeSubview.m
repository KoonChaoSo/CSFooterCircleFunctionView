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

#pragma mark - CSFooterCircleSubviewProtocol
- (void)tableViewScrollDown:(UIView<CSFooterCircleViewProtocol> *)view index:(NSInteger)index {
    [view showWithViewName:NSStringFromClass([self class])];
    
    NSString *indexStr = [NSString stringWithFormat:@"%ld",(long)index];
    [self.indexLabel setText:indexStr];
}

- (void)tableViewScrollStop:(UIView<CSFooterCircleViewProtocol> *)view {
    [view hideWithViewName:NSStringFromClass([self class])];
}

- (void)tableViewScrollUp:(UIView<CSFooterCircleViewProtocol> *)view index:(NSInteger)index {
    [view showWithViewName:NSStringFromClass([self class])];
    
    NSString *indexStr = [NSString stringWithFormat:@"%ld",(long)index];
    [self.indexLabel setText:indexStr];
}

#pragma mark - Setter
- (void)setTotal:(NSUInteger)total
{
    _total = total;
    _totlaLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)_total];
}

@end
