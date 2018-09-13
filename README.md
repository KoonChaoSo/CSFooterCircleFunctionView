# CSFooterCircleFunctionView
**列表页码显示和置顶功能**
======
这个控件可以使用比较少的代码侵入，来做页码和置顶功能。

1. 使用方法
```
@property (nonatomic, strong) CSFooterCircleFunctionView *footerCircleView;
...
...
...

- (CSFooterCircleFunctionView *)footerCircleView
{
    if (!_footerCircleView)
    {
        //初始化并传入需要显示的view
        _footerCircleView = [[CSFooterCircleFunctionView alloc] initWithTypes:@[@(CSScrollViewFotterCircleShowSrcollIndexType),@(CSScrollViewFotterCircleScrolToTopType)]];
        //传入所在的tableview
        _footerCircleView.weakTableView = self.tableView;
        __weak __typeof(self)weakSelf = self;
        //监听页码事件
        _footerCircleView.showIndexCompletion = ^(WSScrollViewFotterCircleFunctionType type, UIView<CSFooterCircleSubviewProtocol> *subview, NSUInteger index) 
        {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf.footerCircleView showIndexViewWithIndex:[NSString stringWithFormat:@"%lu",(unsigned long)index] total:@"50"];
        };
        //监听置顶事件
        _footerCircleView.actionCompletion = ^(WSScrollViewFotterCircleFunctionType type, UIView<CSFooterCircleSubviewProtocol> *subview)         {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf.tableView setContentOffset:CGPointMake(1, 1) animated:YES];
        };
    }
    return _footerCircleView;
}

```
2. 效果图
![效果图](https://github.com/KoonChaoSo/CSFooterCircleFunctionView/blob/master/Readme/QQ20180829-223713.gif)

``` 
3. 未来计划
* manager需要提供知道向上、向下、停止信号。
* manager提供一系列的protocol，让自定义view来添加到manager。
* 直接给外面自定义view添加到manager

