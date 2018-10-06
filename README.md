# CSFooterCircleFunctionView
**列表页码显示和置顶功能**
======
这个控件可以使用比较少的代码侵入，来做页码和置顶功能。CSFooterCircleFunctionView的实现运用了runtime和KVO监听tableview的停止滚动和上下滑动的方法。使得可以在业务的viewcontroller不用修改代码都可以直接使用。

1. 使用方法
```
@property (nonatomic, strong) CSFooterCircleFunctionView *footerCircleView;
...
...
...

- (NSArray *)setupSubViewsForFooterCircleFunctionView
{
    CSFotterCircleScrollToTopSubview<CSFooterCircleSubviewProtocol> *scrollToTopSubViews = [[CSFotterCircleScrollToTopSubview alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    [scrollToTopSubViews setHighlighted:NO];
    
    CSFotterCircleShowSrcollIndexTypeSubview<CSFooterCircleSubviewProtocol> *srcollIndexTypeSubview = [[CSFotterCircleShowSrcollIndexTypeSubview alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    [srcollIndexTypeSubview setTotal:50];
    [srcollIndexTypeSubview setHighlighted:NO];
    
    NSArray *retArr = @[scrollToTopSubViews,srcollIndexTypeSubview];
    return retArr;
}


- (CSFooterCircleFunctionView *)footerCircleView
{
    if (!_footerCircleView)
    {
        _footerCircleView = [[CSFooterCircleFunctionView alloc] initWithSubViews:(NSArray <CSFooterCircleSubviewProtocol>*)[self setupSubViewsForFooterCircleFunctionView]];
        _footerCircleView.weakTableView = self.tableView;
        
        __weak __typeof(self)weakSelf = self;
        _footerCircleView.actionCompletion = ^(NSString *viewName, UIView<CSFooterCircleSubviewProtocol> *subview) {
            if ([viewName isEqualToString:@"CSFotterCircleScrollToTopSubview"])
            {
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                [strongSelf.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
        };
    }
    return _footerCircleView;
}
```

2. 效果图
![效果图](https://github.com/KoonChaoSo/CSFooterCircleFunctionView/blob/master/Readme/QQ20180829-223713.gif)


3.需要添加自定义子控件
  需要实现CSFooterCircleSubviewProtocol协议，然后在CSFooterCircleFunctionView的初始化方法添加，即可。
