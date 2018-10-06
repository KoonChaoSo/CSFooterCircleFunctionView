//
//  ViewController.m
//  CSFooterCircleFunctionView
//
//  Created by 苏冠超[产品技术中心] on 2018/8/27.
//  Copyright © 2018年 苏冠超[产品技术中心]. All rights reserved.
//

#import "ViewController.h"
#import "CSFooterCircleFunctionView.h"
#import "CSFotterCircleScrollToTopSubview.h"
#import "CSFotterCircleShowSrcollIndexTypeSubview.h"
#import "CSFooterCircleSubviewProtocol.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CSFooterCircleFunctionView *footerCircleView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.footerCircleView setFrame:CGRectMake(self.view.bounds.size.width - 70, self.view.bounds.size.height - 100, 50, 50)];
    [self.view addSubview:self.footerCircleView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"test1"];
    [cell.textLabel setText:[NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row]];
    [cell setBackgroundColor:[UIColor brownColor]];
    return cell;
}

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
@end
