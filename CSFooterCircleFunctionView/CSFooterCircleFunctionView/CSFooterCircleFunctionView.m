//
//  CSFooterCircleSubviewProtocol
//  CSFooterCircleFunctionView
//
//  Created by ChaoSo on 2018/8/29.
//  Copyright © 2018年 ChaoSo. All rights reserved.
//

#import "CSFooterCircleFunctionView.h"
#import "CSFooterCircleFunctionTool.h"
@interface CSFooterCircleFunctionView()

@property (strong, nonatomic) UIView *customContainerView; //自定义的容器view
@property (copy, nonatomic) NSDictionary *circleSubviewDic; //存储的类型和view
@property (strong, nonatomic) NSString *onShowView; // 正在显示的状态
@property (assign, nonatomic) CGFloat currentY;    //当前的tablview的Y
@property (assign, nonatomic) BOOL isBoundsOffset; //判断是否弹性造成的offset
@end

@implementation CSFooterCircleFunctionView

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    //如果不是tablview的话就不能进行使用
    if (newSuperview && ![newSuperview isKindOfClass:[UITableView class]]) return;
    
    //当这个weaktableview从父view去掉的时候，需要去掉监听，未免引用循环
    if (!newSuperview)
        [self.weakTableView removeObserver:self forKeyPath:@"contentOffset" context:nil];
}

- (instancetype)initWithSubViews:(NSArray<CSFooterCircleSubviewProtocol> *)subViews
{
    self = [super initWithFrame:CGRectMake(0, 0, 45, 45)];
    if (self)
    {
        [self _setup:subViews];
    }
    return self;
}

#pragma mark - Public
- (void)showWithViewName:(NSString *)viewName
{
    
    if (self.hidden == YES)
    {
        self.hidden = NO;
    }
    
    if ([self.onShowView isEqualToString:viewName])
    {
        return ;
    }
    
    [self bringSubviewToFront:[self _getSubViewWithClassName:viewName]];
    self.onShowView = viewName;
}

- (void)hideWithViewName:(NSString *)viewName
{
    [self sendSubviewToBack:[self _getSubViewWithClassName:viewName]];
}

- (void)hide
{
    if (self.hidden == NO)
    {
        self.hidden = YES;
    }
}

#pragma mark - Action
- (void)onClickSubview:(id)sender
{
    UIGestureRecognizer *gestureRecognizer = (UIGestureRecognizer *)sender;
    if (self.actionCompletion)
    {
        self.actionCompletion(self.onShowView, (UIView <CSFooterCircleSubviewProtocol>*)gestureRecognizer.view);
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

#pragma mark - Private
- (void)_setup:(NSArray<CSFooterCircleSubviewProtocol> *)subViews
{
    //先设置自己
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
    
    self.customContainerView = [[UIView alloc] initWithFrame:self.bounds];
    [self.customContainerView setBackgroundColor:[UIColor clearColor]]; //TODO:修改颜色
    //圆角
    self.customContainerView.layer.masksToBounds = YES;
    self.customContainerView.layer.cornerRadius = 22.5;
    [self addSubview:self.customContainerView];
    
    //设置需要显示的子view
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    for (UIView<CSFooterCircleSubviewProtocol> *view in subViews)
    {
        [self.customContainerView addSubview:view];
        self.onShowView = NSStringFromClass(view.class);
        dic[NSStringFromClass(view.class)] = view;
    }
    self.circleSubviewDic = dic.copy;
    
    //设置点击事件
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickSubview:)];
    gesture.numberOfTapsRequired = 1;
    gesture.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:gesture];
}


- (UIView <CSFooterCircleSubviewProtocol>*)_getSubViewWithClassName:(NSString *)className
{
    return self.circleSubviewDic[className];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    //监听tablview上下滑动
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint contentOffset = [change[NSKeyValueChangeNewKey] CGPointValue];
        self.isBoundsOffset = NO;
        if (contentOffset.y <= 5)
        {
            self.isBoundsOffset = YES;
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
                    for (UIView<CSFooterCircleSubviewProtocol > *subView in self.circleSubviewDic.allValues) {
                        if ([subView respondsToSelector:@selector(tableViewScrollUp:index:)])
                        {
                            [subView tableViewScrollUp:self index:lastVisibleRow.row + 1];
                        }
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
                    for (UIView<CSFooterCircleSubviewProtocol > *subView in self.circleSubviewDic.allValues) {
                        if ([subView respondsToSelector:@selector(tableViewScrollDown:index:)])
                        {
                            [subView tableViewScrollDown:self index:lastVisibleRow.row + 1];
                        }
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
    //需要判断设置的weaktablview 是否是uitableview类型
    if ([weakTableView isKindOfClass:[UITableView class]])
    {
        _weakTableView = weakTableView;
    }
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew;
    [_weakTableView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
    
    __weak __typeof(self)weakSelf = self;
    _weakTableView.stopScrollBlock = ^(UIScrollView *view) {
        
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (!strongSelf.isBoundsOffset)
        {
            for (UIView<CSFooterCircleSubviewProtocol > *subView in self.circleSubviewDic.allValues) {
                if ([subView respondsToSelector:@selector(tableViewScrollDown:index:)])
                {
                    [subView tableViewScrollStop:strongSelf];
                }
            }
        }
    };
}
@end
