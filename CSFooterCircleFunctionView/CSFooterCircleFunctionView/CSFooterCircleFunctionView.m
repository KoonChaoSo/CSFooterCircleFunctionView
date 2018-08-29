//
//  CSFooterCircleSubviewProtocol
//  CSFooterCircleFunctionView
//
//  Created by ChaoSo on 2018/8/29.
//  Copyright © 2018年 ChaoSo. All rights reserved.
//

#import "CSFooterCircleFunctionView.h"
#import "CSFotterCircleScrollToTopSubview.h"
#import "CSFotterCircleShowSrcollIndexTypeSubview.h"
#import "CSFooterCircleFunctionTool.h"
@interface CSFooterCircleFunctionView()

@property (strong, nonatomic) UIView *customContainerView;
@property (copy, nonatomic) NSDictionary *circleSubviewDic; //存储的类型和view
@property (assign, nonatomic) WSScrollViewFotterCircleFunctionType onShowType; // 正在显示的状态
@property (assign, nonatomic) CGFloat currentY;
@end

@implementation CSFooterCircleFunctionView
- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"weakTableView.contentOffset"];
}

- (instancetype)initWithTypes:(NSArray *)types
{
    self = [super initWithFrame:CGRectMake(0, 0, 45, 45)];
    if (self)
    {
        [self _setup:types];
    }
    return self;
}

#pragma mark - Private

- (void)_setup:(NSArray *)types
{
    //先设置自己
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
    
    self.customContainerView = [[UIView alloc] initWithFrame:self.bounds];
    [self.customContainerView setBackgroundColor:[UIColor whiteColor]]; //TODO:修改颜色
    //圆角
    self.customContainerView.layer.masksToBounds = YES;
    self.customContainerView.layer.cornerRadius = 22.5;
    [self addSubview:self.customContainerView];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    for (NSNumber *typeNum in types)
    {
        UIView *subview = [self _setupSubviewWithSuperview:self.customContainerView type:(WSScrollViewFotterCircleFunctionType)typeNum.integerValue];
        [self.customContainerView addSubview:subview];
        dic[typeNum] = subview;
    }
    
    self.circleSubviewDic = dic.copy;
}


- (UIView <CSFooterCircleSubviewProtocol>*)_setupSubviewWithSuperview:(UIView *)superview type:(WSScrollViewFotterCircleFunctionType)type
{
    switch (type) {
        case CSScrollViewFotterCircleScrolToTopType:
            {
                //初始化 scroltotop
                UIView <CSFooterCircleSubviewProtocol>*subview = [CSFotterCircleScrollToTopSubview setupSubviewWithSuperView:superview];
                subview.userInteractionEnabled = YES;
                UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickSubview:)];
                gesture.numberOfTapsRequired = 1;
                gesture.numberOfTouchesRequired = 1;
                [subview addGestureRecognizer:gesture];
                self.onShowType = type;
                return subview;
            }
            break;
        case CSScrollViewFotterCircleShowSrcollIndexType:
        {
            //初始化 indexType
            //初始化 scroltotop
            UIView <CSFooterCircleSubviewProtocol>*subview = [CSFotterCircleShowSrcollIndexTypeSubview setupSubviewWithSuperView:superview];
            subview.userInteractionEnabled = YES;
            UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickSubview:)];
            gesture.numberOfTapsRequired = 1;
            gesture.numberOfTouchesRequired = 1;
            [subview addGestureRecognizer:gesture];
            self.onShowType = type;
            return subview;
        }
            break;
            
        default:
            break;
    }
}

- (UIView <CSFooterCircleSubviewProtocol>*)_getSubViewWithType:(WSScrollViewFotterCircleFunctionType)type
{
    return self.circleSubviewDic[@(type)];
}

#pragma mark - Public
- (void)showWithType:(WSScrollViewFotterCircleFunctionType)type
{
    if (self.alpha == 0)
    {
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
        }];
    }
    if (self.hidden == YES)
    {
        self.hidden = NO;
    }
    for (NSNumber *typeNum in self.circleSubviewDic.allKeys)
    {
        UIView <CSFooterCircleSubviewProtocol>* view = [self _getSubViewWithType:typeNum.integerValue];
        if (typeNum.integerValue == type)
        {
            [self.customContainerView bringSubviewToFront:view];
            [view showAnimation:YES completion:^{
            }];
            self.onShowType = type;
        }
        else
        {
            [view hideAnimation:NO completion:^{
            }];
        }
    }
}

- (void)hide
{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (void)showIndexViewWithIndex:(NSString *)index total:(NSString *)total
{
    if (self.alpha == 0)
    {
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
        }];
    }
    if (self.hidden == YES)
    {
        self.hidden = NO;
    }
    
    UIView <CSFooterCircleSubviewProtocol>* subview = [self _getSubViewWithType:CSScrollViewFotterCircleShowSrcollIndexType];

    [self showWithType:CSScrollViewFotterCircleShowSrcollIndexType];
    if ([subview respondsToSelector:@selector(setIndex:total:)])
    {
        [subview setIndex:index total:total];
    }
}

#pragma mark - Action
- (void)onClickSubview:(id)sender
{
    UIGestureRecognizer *gestureRecognizer = (UIGestureRecognizer *)sender;
    if (self.actionCompletion)
    {
        self.actionCompletion(self.onShowType, (UIView <CSFooterCircleSubviewProtocol>*)gestureRecognizer.view);
    }
}

#pragma mark - Touch Event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    UIView *view = [touch view];
    if (view.alpha > 0 &&
        [view conformsToProtocol:@protocol(CSFooterCircleSubviewProtocol)]) {
        UIView <CSFooterCircleSubviewProtocol>*touchView = (UIView <CSFooterCircleSubviewProtocol>*)view;
        [touchView setHighlighted:YES];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    UIView *view = [touch view];
    if (view.alpha > 0 &&
        [view conformsToProtocol:@protocol(CSFooterCircleSubviewProtocol)]) {
        UIView <CSFooterCircleSubviewProtocol>*touchView = (UIView <CSFooterCircleSubviewProtocol>*)view;
        [touchView setHighlighted:NO];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    UIView *view = [touch view];
    if (view.alpha > 0 &&
        [view conformsToProtocol:@protocol(CSFooterCircleSubviewProtocol)]) {
        UIView <CSFooterCircleSubviewProtocol>*touchView = (UIView <CSFooterCircleSubviewProtocol>*)view;
        [touchView setHighlighted:NO];
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"weakTableView.contentOffset"]) {
        CGPoint contentOffset = [change[NSKeyValueChangeNewKey] CGPointValue];
        if (contentOffset.y <= 5)
        {
            [self hide];
        }
        else if (contentOffset.y - self.currentY > 5)
        {
            //向下滑动 显示页码
            NSArray *indexPathArr = [self.weakTableView indexPathsForVisibleRows];
            NSIndexPath *lastVisibleRow = indexPathArr.lastObject;
            if (lastVisibleRow)
            {
                if (lastVisibleRow.row +1 > 0)
                {
                    if (self.showIndexCompletion && [self.circleSubviewDic.allKeys containsObject:@(CSScrollViewFotterCircleShowSrcollIndexType)])
                    {
                        self.showIndexCompletion(CSScrollViewFotterCircleShowSrcollIndexType,
                                                 [self _getSubViewWithType:CSScrollViewFotterCircleShowSrcollIndexType],
                                                 lastVisibleRow.row + 1);
                    }
                }
            }
        }
        else if (contentOffset.y - self.currentY < -5)
        {

            //向下滑动 显示页码
            NSArray *indexPathArr = [self.weakTableView indexPathsForVisibleRows];
            NSIndexPath *lastVisibleRow = indexPathArr.lastObject;
            if (lastVisibleRow)
            {
                if (lastVisibleRow.row +1 > 0)
                {
                    if (self.showIndexCompletion && [self.circleSubviewDic.allKeys containsObject:@(CSScrollViewFotterCircleShowSrcollIndexType)])
                    {
                        self.showIndexCompletion(CSScrollViewFotterCircleShowSrcollIndexType,
                                                 [self _getSubViewWithType:CSScrollViewFotterCircleShowSrcollIndexType],
                                                 lastVisibleRow.row + 1);
                    }
                }
            }
        }
        self.currentY = contentOffset.y;
    }
}



#pragma mark - Getter
- (NSDictionary *)circleSubviewDic
{
    if (!_circleSubviewDic)
    {
        _circleSubviewDic = [[NSDictionary alloc] init];
    }
    return _circleSubviewDic;
}

#pragma mark - Setter
- (void)setWeakTableView:(UITableView *)weakTableView
{
    _weakTableView = weakTableView;
    [self addObserver:self forKeyPath:@"weakTableView.contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    __weak __typeof(self)weakSelf = self;
    _weakTableView.stopScrollBlock = ^(UIScrollView *view) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf showWithType:CSScrollViewFotterCircleScrolToTopType];
    };
}
@end
